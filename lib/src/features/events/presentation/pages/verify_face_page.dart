import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/features/users/presentation/widgets/register_face_alert.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class VerifyFacePage extends StatefulWidget {
  const VerifyFacePage({super.key});

  @override
  State<VerifyFacePage> createState() => _VerifyFacePageState();
}

class _VerifyFacePageState extends State<VerifyFacePage> {
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
          debugPrint('Available cameras: ${cameras.length}');

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
            orElse: () {
              debugPrint(
                  'Front camera not found, using first available camera');
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
              debugPrint(
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
          debugPrint('Camera initialization error: $e');
          throw Exception('Failed to initialize camera: $e');
        }
      } else if (status.isDenied) {
        debugPrint('Camera permission is denied');
        throw Exception('Camera permission denied by user');
      } else if (status.isPermanentlyDenied) {
        debugPrint('Camera permission is permanently denied');
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

    return BlocConsumer<VerifyFaceBloc, VerifyFaceState>(
      listener: (context, state) {},
      builder: (context, state) {
        debugPrint('Loading pada widget ${state.isLoading}');

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.isLoading
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
              ),
              child: ClipOval(
                child: Transform.scale(
                  scale: (_cameraController!.value.aspectRatio / deviceRatio) *
                      0.5,
                  child: Center(
                    child: CameraPreview(_cameraController!),
                  ),
                ),
              ),
            ),
            if (state.isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }

  Future<void> _captureImage(BuildContext context) async {
    final verifyFaceBloc = getIt<VerifyFaceBloc>();

    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        await _cameraController!
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
        final XFile image = await _cameraController!.takePicture();

        // ignore: use_build_context_synchronously
        verifyFaceBloc.add(CaptureFace(image.path));

        setState(() {});
      } catch (e) {
        // ignore: avoid_debugPrint
        debugPrint("Error capturing image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VerifyFaceBloc>(),
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          middleText: 'Cek Wajah',
        ),
        body: BlocConsumer<VerifyFaceBloc, VerifyFaceState>(
          listener: (context, state) {
            if (state is VerifyFaceSuccess) {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    color: white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Wajah Anda berhasil diverifikasi!',
                          style: titleOneMedium.copyWith(color: white),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is VerifyFaceFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Verifikasi gagal: ${state.errorMessage}',
                    style: titleOneMedium.copyWith(color: white),
                  ),
                  backgroundColor: primaryBase,
                ),
              );
            }
          },
          builder: (context, state) {
            return FutureBuilder<void>(
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
                          const Gap(24),
                          Text(
                            'Ambil gambar wajah Anda!',
                            style: headingThreeSemiBold.copyWith(
                                color: neutralBase),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(8),
                          Text(
                            'Kami akan mengambil wajah Anda sekarang agar nanti bisa digunakan untuk masuk ke acara saat hadir!',
                            style: paragraphOne.copyWith(color: neutral40),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          RegisterFaceAlert(
                            text: 'Posisikan wajah Anda dengan benar',
                            type: RegisterFaceType.warning,
                          ),
                          const Gap(8),
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
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          color: white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Button(
              onPressed: () => _captureImage(context),
              type: ButtonType.primary,
              child: Text(
                'Ambil',
                style: titleOneMedium.copyWith(color: white),
              ),
            ),
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
