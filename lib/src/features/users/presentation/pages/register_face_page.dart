import 'dart:math';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_bloc.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_event.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_state.dart';
import 'package:mesran_app/src/features/users/presentation/widgets/circular_progress_painter.dart';
import 'package:mesran_app/src/shared/presentation/widgets/loader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/features/users/presentation/widgets/register_face_alert.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class RegisterFacePage extends StatelessWidget {
  const RegisterFacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterFaceBloc>(),
      child: const RegisterFaceContent(),
    );
  }
}

class RegisterFaceContent extends StatefulWidget {
  const RegisterFaceContent({super.key});

  @override
  State<RegisterFaceContent> createState() => _RegisterFaceContentState();
}

class _RegisterFaceContentState extends State<RegisterFaceContent> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    if (mounted) {
      context.read<RegisterFaceBloc>().add(LoadUser());
    }
  }

  Future<void> _initializeCamera() async {
    _initializeControllerFuture = Future(() async {
      var status = await Permission.camera.status;

      if (!status.isGranted) {
        status = await Permission.camera.request();
      }

      if (status.isGranted) {
        try {
          final cameras = await availableCameras();

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () {
              return cameras.first;
            },
          );

          _cameraController = CameraController(
            frontCamera,
            ResolutionPreset.medium,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );

          await _cameraController!.initialize();
          await _cameraController!
              .lockCaptureOrientation(DeviceOrientation.portraitUp);

          if (mounted) {
            setState(() {});
          }
        } catch (e) {
          throw Exception('Failed to initialize camera: $e');
        }
      } else if (status.isDenied) {
        throw Exception('Camera permission denied by user');
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
        throw Exception(
            'Camera permission permanently denied, please enable from settings');
      }
    });
  }

  Widget _buildCircularCameraPreview() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final circleSize = size.width * 0.85;
    final progressCircleSize = circleSize * 1.050;

    return BlocConsumer<RegisterFaceBloc, RegisterFaceState>(
      listener: (context, state) {
        if (state is RegisterFaceSuccess) {
          context.go('/register/success');
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: ClipOval(
                child: Transform.scale(
                  scale: (_cameraController!.value.aspectRatio / deviceRatio) *
                      0.5,
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: Size(progressCircleSize, progressCircleSize),
              painter: CircularProgressPainter(
                circleSize: progressCircleSize,
                capturedCount: state.capturedCount,
                totalCount: 5,
                activeColor: primaryBase,
                inactiveColor: neutral20,
              ),
            ),
            if (state is RegisterFaceLoading || state is VerifyingFace)
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(
                          12), // Optional: untuk rounded corners
                    ),
                    child: Center(child: Loader()),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _captureImage(BuildContext context) async {
    final registerFaceBloc = getIt<RegisterFaceBloc>();

    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        await _cameraController!
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
        final XFile image = await _cameraController!.takePicture();

        // ignore: use_build_context_synchronously
        registerFaceBloc.add(CaptureFace(image.path, 1));

        setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print("Error capturing image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterFaceBloc>(),
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          middleText: 'Registrasi Wajah',
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (_cameraController != null &&
                  _cameraController!.value.isInitialized) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(child: _buildCircularCameraPreview()),
                      Gap(24),
                      BlocBuilder<RegisterFaceBloc, RegisterFaceState>(
                          builder: (context, state) {
                        return Text(
                          'Hai ${state.user?.firstname}, Kami akan ambil gambar wajah Anda!',
                          style:
                              headingThreeSemiBold.copyWith(color: neutralBase),
                          textAlign: TextAlign.center,
                        );
                      }),
                      Gap(8),
                      Text(
                        'Kami akan mengambil wajah Anda sekarang agar nanti bisa digunakan untuk masuk ke acara saat hadir!',
                        style: paragraphOne.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      BlocBuilder<RegisterFaceBloc, RegisterFaceState>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            RegisterFaceAlert(
                              text: state is RegisterFaceLoading
                                  ? 'Tunggu kami sedang memproses wajah Anda'
                                  : state is RegisterFaceFailure
                                      ? 'Gagal mengambil wajah Anda'
                                      : 'Posisikan wajah Anda tepat di dalam lingkaran',
                              type: state is RegisterFaceLoading
                                  ? RegisterFaceType.loading
                                  : state is RegisterFaceFailure
                                      ? RegisterFaceType.error
                                      : RegisterFaceType.warning,
                            ),
                            Gap(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Wajah yang sudah diambil',
                                  style: titleOne.copyWith(color: neutralBase),
                                ),
                                Gap(4),
                                Text(
                                  '${state.capturedCount} dari 5',
                                  style: titleOneSemiBold.copyWith(
                                      color: neutralBase),
                                )
                              ],
                            )
                          ],
                        );
                      }),
                      Gap(8),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Tidak dapat menginisialisasi kamera."),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Loader(),
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          color: white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<RegisterFaceBloc, RegisterFaceState>(
                builder: (context, state) {
              return Button(
                onPressed: () => _captureImage(context),
                type: state is RegisterFaceLoading || state is VerifyingFace
                    ? ButtonType.secondaryFill
                    : ButtonType.primary,
                child: Text(
                  state is RegisterFaceLoading
                      ? 'Tunggu'
                      : state is RegisterFaceFailure
                          ? 'Coba lagi'
                          : state is VerifyingFace
                              ? 'Verifikasi'
                              : 'Ambil Foto',
                  style: titleOneMedium.copyWith(
                      color:
                          state is RegisterFaceLoading || state is VerifyingFace
                              ? neutral40
                              : white),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
