import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_state.dart';
import 'package:mesran_app/src/features/events/presentation/widgets/create_event_form.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:mesran_app/src/shared/presentation/widgets/loader.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateEventBloc>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<CreateEventBloc, CreateEventState>(
              builder: (context, state) {
            return CustomAppBar(
              onBack: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: white,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Gap(24),
                              Image.asset(
                                'assets/images/faq.png',
                                width: 319,
                              ),
                              Gap(16),
                              Text(
                                'Batal Membuat Acara?',
                                style: headingOneSemiBold.copyWith(
                                    color: neutralBase),
                              ),
                              Gap(4),
                              Text(
                                'Perubahan yang mungkin telah Anda lakukan akan terhapus',
                                style: titleOne.copyWith(color: neutralBase),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                      child: Button(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          type: ButtonType.secondary,
                                          child: Text(
                                            'Batal',
                                            style: titleOneSemiBold.copyWith(
                                                color: neutral40),
                                          ))),
                                  Gap(8),
                                  Expanded(
                                      child: Button(
                                          onPressed: () {
                                            context.go('/home');
                                          },
                                          type: ButtonType.primary,
                                          child: Text(
                                            'Ya, Batalkan',
                                            style: titleOneSemiBold.copyWith(
                                                color: white),
                                          )))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              leadingText: 'Buat Acara',
            );
          }),
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  CreateEventForm(),
                  BlocBuilder<CreateEventBloc, CreateEventState>(
                    buildWhen: (previous, current) =>
                        current is CreateEventLoading,
                    builder: (context, state) {
                      if (state is CreateEventLoading) {
                        return Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(width: 1, color: neutral20)),
                              child: Loader(),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: white,
        bottomNavigationBar: BottomCreateEventPage(),
      ),
    );
  }
}

class BottomCreateEventPage extends StatelessWidget {
  const BottomCreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: white,
      child: Column(
        children: [
          Button(
              onPressed: () {
                context.read<CreateEventBloc>().add(SubmitEvent());
              },
              type: ButtonType.primary,
              child: Text(
                'Buat',
                style: titleOneSemiBold.copyWith(color: white),
              ))
        ],
      ),
    );
  }
}
