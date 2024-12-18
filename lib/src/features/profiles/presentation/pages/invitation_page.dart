import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_state.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class InvitationPage extends StatelessWidget {
  final String eventId;
  const InvitationPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<ProfileBloc>()),
      BlocProvider(create: (_) => getIt<InvitationBloc>())
    ], child: InvitationContent(eventId: eventId));
  }
}

class InvitationContent extends StatefulWidget {
  final String eventId;
  const InvitationContent({super.key, required this.eventId});

  @override
  State<InvitationContent> createState() => _InvitationContentState();
}

class _InvitationContentState extends State<InvitationContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ProfileBloc>().add(ProfileLoad());
        context.read<InvitationBloc>().add(InvitationLoad(widget.eventId));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar(
        middleText: 'Undangan',
        endSection: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              context: context,
              builder: (context) => SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/faq.png',
                                  width: 230,
                                  height: 230,
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ingin menghapus undangan?',
                                      style: TextStyle(
                                        color: neutralBase,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Sudah yakin dengan keputusan anda ingin sekali menghapus undangan ini?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: neutral40,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  child: Button(
                                onPressed: () => context.pop(),
                                type: ButtonType.secondary,
                                child: Text('Tidak',
                                    style: titleOneSemiBold.copyWith(
                                        color: neutralBase)),
                              )),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Button(
                                onPressed: () {},
                                child: Text('Iya',
                                    style: titleOneSemiBold.copyWith(
                                        color: white)),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: trash.copyWith(color: errorBase),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) {
                return previous.user != current.user;
              }, builder: (context, state) {
                if (state.user != null) {
                  return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: neutral10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Undangan untuk:',
                              style: titleOne.copyWith(color: neutral40),
                            ),
                            Gap(8),
                            Text(
                              state.user!.firstName,
                              style: headingThree.copyWith(color: neutralBase),
                            ),
                          ],
                        ),
                      ));
                } else {
                  return CircularProgressIndicator();
                }
              }),
              Gap(16),
              BlocBuilder<InvitationBloc, InvitationState>(
                  buildWhen: (previous, current) =>
                      previous.event != current.event,
                  builder: (context, state) {
                    return CircularProgressIndicator();
                  }),
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
