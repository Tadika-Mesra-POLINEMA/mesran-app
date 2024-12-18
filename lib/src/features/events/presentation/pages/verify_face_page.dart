import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/loader.dart';
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
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  final VerifyFaceBloc _verifyFaceBloc = getIt<VerifyFaceBloc>();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
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
            ResolutionPreset.ultraHigh,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );

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

    // Tampilkan preview kamera
    return BlocProvider.value(
      value: _verifyFaceBloc,
      child: BlocConsumer<VerifyFaceBloc, VerifyFaceState>(
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/login-success.png',
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Terdeteksi sebagai',
                              style:
                                  titleOneMedium.copyWith(color: neutralBase)),
                          Gap(8),
                          Text(
                            '${state.response.firstName} ${state.response.lastName}',
                            style:
                                headingTwoSemiBold.copyWith(color: neutralBase),
                          )
                        ],
                      ),
                      Gap(16),
                      Row(
                        children: [
                          Expanded(
                            child: Button(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              type: ButtonType.secondary,
                              child: Text(
                                'Tutup',
                                style:
                                    titleOneMedium.copyWith(color: neutralBase),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: Button(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              type: ButtonType.primary,
                              child: Text(
                                'Lanjutkan',
                                style: titleOneMedium.copyWith(color: white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          final size = MediaQuery.of(context).size;
          final deviceRatio = size.width / size.height;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size.width * 0.85,
                height: size.width * 0.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.isLoading
                      ? Colors.black.withOpacity(0.5)
                      : Colors.transparent,
                ),
                child: ClipOval(
                  child: Transform.scale(
                    scale:
                        (_cameraController!.value.aspectRatio / deviceRatio) *
                            0.5,
                    child: Center(
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                ),
              ),
              if (state.isLoading)
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
      ),
    );
  }

  Future<void> _captureImage(BuildContext context) async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        await _cameraController!
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
        final XFile image = await _cameraController!.takePicture();
        _verifyFaceBloc.add(CaptureFace(image.path));
      } catch (e) {
        debugPrint("Error capturing image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _verifyFaceBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBar(
          middleText: 'Cek Wajah',
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
                      const Gap(24),
                      Text(
                        'Ambil gambar wajah Anda!',
                        style:
                            headingThreeSemiBold.copyWith(color: neutralBase),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(8),
                      Text(
                        'Kami akan mengambil wajah Anda sekarang agar nanti bisa digunakan untuk masuk ke acara saat hadir!',
                        style: paragraphOne.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      BlocBuilder<VerifyFaceBloc, VerifyFaceState>(
                        builder: (context, state) {
                          return RegisterFaceAlert(
                            text: state is VerifyFaceFailure
                                ? '${state.errorMessage}'
                                : 'Posisikan wajah Anda dengan benar',
                            type: state is VerifyFaceFailure
                                ? RegisterFaceType.error
                                : RegisterFaceType.warning,
                          );
                        },
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
    _verifyFaceBloc.close();
    super.dispose();
  }
}
