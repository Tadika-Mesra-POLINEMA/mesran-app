import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/models/user.dart';
import 'package:mesran_app/themes.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final int otpLength = 6;
  List<TextEditingController> otpControllers = [];
  List<FocusNode> focusNodes = [];
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  @override
  void initState() {
    super.initState();
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

  void _onOtpEntered(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: UndoButton(onPressed: () => context.pop()),
        ),
        backgroundColor: white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(otpLength, (index) {
                    return Container(
                      width: 50,
                      margin: const EdgeInsets.only(right: 8),
                      child: TextField(
                        controller: otpControllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) => _onOtpEntered(value, index),
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: neutral20),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: neutral20),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TimerCountdown(
                  format: CountDownTimerFormat.minutesSeconds,
                  endTime: DateTime.now().add(const Duration(minutes: 1)),
                  descriptionTextStyle: null,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 144,
        color: white,
        child: Column(children: [
          ElevatedButton(
            onPressed: () => context.push('/auth-success',
                extra: AuthenticationSuccess(
                    title: 'Berhasil masuk ke akun Anda!')),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBase,
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Kirim',
                style: titleOneSemiBold.copyWith(color: white),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () => () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: neutral20),
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Kirim Ulang Kode',
                style: titleOneSemiBold.copyWith(color: neutralBase),
              ),
            ),
          ),
        ]),
      ),
      backgroundColor: white,
    );
  }
}
