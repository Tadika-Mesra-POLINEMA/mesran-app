import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/domain/entities/dress.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_field.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/input_label.dart';

class EventDresscodePage extends StatefulWidget {
  const EventDresscodePage({super.key});

  @override
  State<EventDresscodePage> createState() => _EventDresscodePageState();
}

class _EventDresscodePageState extends State<EventDresscodePage> {
  int _selectedIndex = 0;

  final List<Dress> _items = [
    Dress(label: 'Formal', icon: formalClothes),
    Dress(label: 'Kasual', icon: casualClothes),
    Dress(label: 'Olahraga', icon: sport),
    Dress(label: 'Tradisional', icon: traditional),
    Dress(label: 'Horror', icon: horror),
    Dress(label: 'Anime', icon: anime),
  ];

  void handleDresscodeSave(BuildContext context) {
    context
        .read<EventDresscodeBloc>()
        .add(ChangeDresscode(dresscode: _items[_selectedIndex].label));
  }

  bool _getSelectedDresscode(int index, String dresscode) {
    return _items[index].label == dresscode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventDresscodeBloc>.value(
      value: getIt<EventDresscodeBloc>()..add(LoadEventDresscode()),
      child: Scaffold(
        appBar: CustomAppBar(
          onBack: () {
            context.go('/events/create');
          },
          leadingText: 'Pakaian dan Tema',
        ),
        body: BlocBuilder<EventDresscodeBloc, EventDresscodeState>(
          buildWhen: (previous, current) =>
              previous.dresscode != current.dresscode &&
              previous.theme != current.theme,
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InputTheme(),
                  Gap(24),
                  Text('Pilih Pakaian', style: titleOneMedium),
                  Gap(8),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            handleDresscodeSave(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _getSelectedDresscode(
                                        index, state.dresscode)
                                    ? primaryBase
                                    : neutral20,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _items[index].icon.copyWith(
                                      color: neutralBase,
                                      padding: EdgeInsets.all(0)),
                                  Gap(4),
                                  Text(_items[index].label,
                                      style: titleOneMedium),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(16),
                  Button(
                      onPressed: () {
                        context.go('/events/create');
                      },
                      type: ButtonType.primary,
                      child: Text(
                        'Simpan',
                        style: titleOneSemiBold.copyWith(color: white),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InputTheme extends StatelessWidget {
  const _InputTheme();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDresscodeBloc, EventDresscodeState>(
      buildWhen: (previous, current) => previous.dresscode != current.dresscode,
      builder: (context, state) {
        final isThemeError = !state.dresscode.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabel(label: 'Pilih Tema'),
            Gap(8),
            InputField(
              onChanged: (theme) {
                context
                    .read<EventDresscodeBloc>()
                    .add(ChangeTheme(theme: theme));
              },
              hintText: 'Masukkan tema',
              isError: isThemeError,
              initialValue: state.theme,
            ),
            if (isThemeError)
              Column(
                children: [
                  Gap(4),
                  Text(
                    'Tema harus diisi dan minimal 3 karakter',
                    style: titleTwoMedium.copyWith(color: primaryBase),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
