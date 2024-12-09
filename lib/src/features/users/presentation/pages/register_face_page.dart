import 'dart:io';
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
import 'package:mesran_app/src/features/users/presentation/widgets/error_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/features/users/presentation/widgets/register_face_alert.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class RegisterFacePage extends StatefulWidget {
  const RegisterFacePage({super.key});

  @override
  State<RegisterFacePage> createState() => _RegisterFacePageState();
}

class _RegisterFacePageState extends State<RegisterFacePage> {
  // Controller for the camera, used to display the camera preview and capture images
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _initializeControllerFuture = Future(() async {
      // Cek permission dulu sebelum request
      var status = await Permission.camera.status;

      // Jika belum granted, baru request
      if (!status.isGranted) {
        status = await Permission.camera.request();
      }

      if (status.isGranted) {
        try {
          final cameras = await availableCameras();

          // Tambahkan log untuk debug
          print('Available cameras: ${cameras.length}');

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () {
              print('Front camera not found, using first available camera');
              return cameras.first;
            },
          );

          _cameraController = CameraController(
            frontCamera,
            ResolutionPreset.medium,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );

          // Tambahkan listener untuk error
          _cameraController!.addListener(() {
            if (_cameraController!.value.hasError) {
              print(
                  'Camera error ${_cameraController!.value.errorDescription}');
            }
          });

          await _cameraController!.initialize();
          await _cameraController!
              .lockCaptureOrientation(DeviceOrientation.portraitUp);

          if (mounted) {
            setState(() {});
          }
        } catch (e) {
          print('Camera initialization error: $e'); // Tambahkan log error
          throw Exception('Failed to initialize camera: $e');
        }
      } else if (status.isDenied) {
        print('Camera permission is denied');
        // Tambahkan handling untuk ketika user menolak permission
        throw Exception('Camera permission denied by user');
      } else if (status.isPermanentlyDenied) {
        print('Camera permission is permanently denied');
        // Buka settings aplikasi
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
        print(state.capturedCount);
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
                color: state is RegisterFaceLoading
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
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
            if (state is RegisterFaceLoading)
              Center(
                child: CircularProgressIndicator(
                  color: primaryBase,
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

        // Cek apakah file gambar valid
        final imageFile = File(image.path);
        if (await imageFile.exists() && await imageFile.length() > 0) {
          // Jika file valid, lanjutkan dengan trigger event
          registerFaceBloc.add(CaptureFace(image.path));
        } else {
          print("Invalid image file: ${image.path}");
        }
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
                      Text(
                        'Ambil gambar wajah Anda!',
                        style:
                            headingThreeSemiBold.copyWith(color: neutralBase),
                        textAlign: TextAlign.center,
                      ),
                      Gap(8),
                      Text(
                        'Kami akan mengambil wajah Anda selama 5 kali,',
                        style: paragraphOne.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Harap posisikan wajah Anda dengan benar menyesuaikan lingkaran yang ada di layar ponsel Anda',
                        style: paragraphOne.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      BlocBuilder<RegisterFaceBloc, RegisterFaceState>(
                        builder: (context, state) {
                          return RegisterFaceAlert(
                            text: state is RegisterFaceFailure
                                ? state.message
                                : state is RegisterFaceLoading
                                    ? 'Tunggu wajah Anda sedang kami proses'
                                    : 'Posisikan wajah Anda dengan benar',
                            type: state is RegisterFaceFailure
                                ? RegisterFaceType.error
                                : state is RegisterFaceLoading
                                    ? RegisterFaceType.loading
                                    : RegisterFaceType.warning,
                          );
                        },
                      ),
                      Gap(8)
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
              return const Center(
                child: CircularProgressIndicator(),
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
                onPressed: () {
                  _captureImage(context);
                },
                type: ButtonType.primary,
                child: Text(
                  'Ambil',
                  style: titleOneMedium.copyWith(color: white),
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
