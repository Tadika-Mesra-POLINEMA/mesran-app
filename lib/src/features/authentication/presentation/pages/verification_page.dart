import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_event.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_state.dart';
import 'package:mesran_app/src/features/authentication/presentation/widgets/otp_input_section.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final int otpLength = 6;
  final List<TextEditingController> otpControllers = [];
  final List<FocusNode> focusNodes = [];

  late DateTime endTimeTarget;
  bool isEndCountdown = false;

  @override
  void initState() {
    super.initState();

    // init end time in seconds
    endTimeTarget = DateTime.now().add(Duration(seconds: 60));

    for (int i = 0; i < otpLength; i++) {
      otpControllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(BuildContext context, String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }

      context
          .read<OtpVerificationBloc>()
          .add(OtpChanged(index: index, value: value));
    }
  }

  void _onOtpResend(BuildContext context) {
    setState(() {
      endTimeTarget = DateTime.now().add(Duration(seconds: 60));
    });
    context.read<OtpVerificationBloc>().add(ResendOtpRequested());
  }

  void _onOtpSubmitted(BuildContext context) {
    final otp = otpControllers.map((controller) => controller.text).join();
    context.read<OtpVerificationBloc>().add(OtpSubmitted(otp: otp));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OtpVerificationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
        ),
        backgroundColor: white,
        body: BlocListener<OtpVerificationBloc, OtpVerificationState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              context.go('/verify/success');
            } else if (state is OtpFailure) {
              // TODO: Handling failure otp verification
              print(state.message);
            }

            if (state is ResendOtpRequested) {
              endTimeTarget = DateTime.now().add(Duration(seconds: 60));
            }
          },
          child: BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
            builder: (context, state) {
              if (state is OtpLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Verifikasi Kode OTP',
                      style: headingTwoSemiBold.copyWith(color: neutralBase),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masukkan kode OTP yang telah dikirimkan ke nomor atau email Anda untuk melanjutkan proses verifikasi. Pastikan kode yang dimasukkan benar sebelum waktu habis.',
                      style: titleTwo.copyWith(color: neutral40),
                    ),
                    const SizedBox(height: 32),
                    OtpInputSection(
                      otpLength: otpLength,
                      focusNodes: focusNodes,
                      onOtpChanged: (String value, int index) =>
                          _onOtpChanged(context, value, index),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: neutral10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TimerCountdown(
                          format: CountDownTimerFormat.minutesSeconds,
                          endTime: endTimeTarget,
                          onEnd: () {
                            isEndCountdown = true;
                          },
                          spacerWidth: 2,
                          timeTextStyle:
                              titleOneMedium.copyWith(color: neutralBase),
                          colonsTextStyle:
                              titleOneMedium.copyWith(color: neutralBase),
                          descriptionTextStyle: const TextStyle(
                            fontSize: 0, // Hide descriptions
                          ),
                          minutesDescription: "",
                          secondsDescription: "",
                        ),
                      ),
                    ),
                    Spacer(),
                    Button(
                      onPressed: () => _onOtpSubmitted(context),
                      child: Text('Kirim',
                          style: titleOneSemiBold.copyWith(color: white)),
                    ),
                    Gap(8),
                    Button(
                        onPressed: () => _onOtpResend(context),
                        type: ButtonType.secondary,
                        child: Text('Kirim Ulang Kode',
                            style:
                                titleOneSemiBold.copyWith(color: neutralBase)))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
