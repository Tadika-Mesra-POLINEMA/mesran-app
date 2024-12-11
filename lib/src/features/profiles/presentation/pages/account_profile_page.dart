import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injector.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_state.dart';
import 'package:mesran_app/src/shared/presentation/widgets/bottom_navigation.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class AccountProfilePage extends StatelessWidget {
  const AccountProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ProfileBloc>(), child: const ProfileContent());
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ProfileBloc>().add(ProfileLoad());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (_, state) {},
        builder: (context, state) {
          if (state.user != null) {
            final User user = state.user!;
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Profil',
                            style: headingTwoSemiBold,
                          ),
                          InkWell(
                              onTap: () => context.push('/notifications'),
                              child: bell.copyWith(color: neutralBase))
                        ]),
                  )),
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 48, // Ukuran radius lingkaran
                        backgroundColor:
                            Colors.blue, // Warna latar belakang lingkaran
                        child: Text(
                          user.firstName
                              .split(' ')
                              .map((word) => word.isNotEmpty ? word[0] : '')
                              .join(), // Konten string
                          style: TextStyle(
                            fontSize: 24, // Ukuran font
                            fontWeight: FontWeight.bold, // Tebal font
                            color: Colors.white, // Warna teks
                          ),
                        ),
                      ),
                      Gap(16),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: headingThreeSemiBold,
                      ),
                      Gap(8),
                      Text(
                        user.phone,
                        style: titleTwo.copyWith(color: neutral40),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () {
                          context.push('/account/update');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors
                              .white, // Background color similar to TextFormField
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: neutral20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                profile.copyWith(color: neutralBase),
                                const SizedBox(width: 12),
                                Text(
                                  'Informasi Pribadi',
                                  style: titleOne.copyWith(color: neutralBase),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: neutralBase,
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                      TextButton(
                        onPressed: () {
                          context.push('/account/profile/update');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors
                              .white, // Background color similar to TextFormField
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: neutral20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                setting.copyWith(color: neutralBase),
                                const SizedBox(width: 12),
                                Text(
                                  'Akun',
                                  style: titleOne.copyWith(color: neutralBase),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: neutralBase,
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                      TextButton(
                        onPressed: () {
                          context.push('/account/history');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors
                              .white, // Background color similar to TextFormField
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: neutral20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                invite.copyWith(color: neutralBase),
                                const SizedBox(width: 12),
                                Text(
                                  'Undanganku',
                                  style: titleOne.copyWith(color: neutralBase),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: neutralBase,
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 12,
                      ),
                      TextButton(
                        onPressed: () {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20),
                                        Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/advertising.png',
                                                width: 230,
                                                height: 230,
                                              ),
                                              SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Ingin keluar dari akun Anda?',
                                                    style: TextStyle(
                                                      color: neutralBase,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Semua perubahan yang belum disimpan akan hilang, dan Anda harus masuk kembali untuk mengakses fitur.',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: neutral40,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                  style:
                                                      titleOneSemiBold.copyWith(
                                                          color: neutralBase)),
                                            )),
                                            SizedBox(width: 10),
                                            Expanded(
                                                child: Button(
                                              onPressed: () async {
                                                final secureStorage = getIt<
                                                    FlutterSecureStorage>();

                                                // Delete all secure storage entries
                                                await secureStorage.deleteAll();

                                                // Verify deletion
                                                final allValues =
                                                    await secureStorage
                                                        .readAll();
                                                print(
                                                    'Secure storage after deletion: $allValues');

                                                // Navigate to login page
                                                context.replace('/login');
                                              },
                                              child: Text('Iya',
                                                  style: titleOneSemiBold
                                                      .copyWith(color: white)),
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
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: primary10),
                            borderRadius: BorderRadius.circular(64),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Keluar',
                              style: titleOne.copyWith(color: primaryBase),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              backgroundColor: white,
              bottomNavigationBar: BottomNavigation(
                path: BottomNavigationPath.profile,
              ),
            );
          }

          return Scaffold(
            backgroundColor: white,
            body: Center(
                child: CircularProgressIndicator(
              color: primaryBase,
            )),
          );
        });
  }
}
