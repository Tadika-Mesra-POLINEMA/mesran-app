import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/icons/template.dart' as ic;
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class ShareBottomSheetContent extends StatelessWidget {
  final Event event;

  const ShareBottomSheetContent({super.key, required this.event});

  // Generic share method
  void _shareContent(BuildContext context, String platform) async {
    final shareUrl = '${Options.wsBaseUrl}/events/${event.id}/invite';
    final shareMessage = '✨ Ayo Bergabung dengan Event Seru Kami! ✨\n\n'
        '🎉 ${event.name}\n'
        '📅 Tanggal: ${DateFormat.yMd().format(event.date)}\n'
        '🕒 Waktu: ${event.start.hour.toString().padLeft(2, '0')}:${event.start.minute.toString().padLeft(2, '0')}\n'
        '📍 Lokasi: ${event.location}\n\n'
        'Nikmati berbagai aktivitas menarik dan temui orang-orang baru! Jangan lewatkan kesempatan ini untuk mendapatkan pengalaman tak terlupakan. Klik link berikut untuk informasi lebih lanjut dan pendaftaran:\n$shareUrl\n\n'
        '🤝 Kami tunggu kehadiranmu!';

    try {
      switch (platform) {
        case 'whatsapp':
          final whatsappUrl = Uri.parse(
              'whatsapp://send?text=${Uri.encodeComponent(shareMessage)}');
          if (await canLaunchUrl(whatsappUrl)) {
            await launchUrl(whatsappUrl);
          } else {
            await Share.share(shareMessage);
          }
          break;
        case 'facebook':
          final facebookUrl = Uri.parse(
              'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(shareUrl)}');
          if (await canLaunchUrl(facebookUrl)) {
            await launchUrl(facebookUrl);
          } else {
            await Share.share(shareMessage);
          }
          break;
        case 'tiktok':
          final tiktokUrl = Uri.parse('https://www.tiktok.com/share');
          if (await canLaunchUrl(tiktokUrl)) {
            await launchUrl(tiktokUrl);
          } else {
            await Share.share(shareMessage);
          }
          break;
        case 'instagram':
          final instagramUrl =
              Uri.parse('https://www.instagram.com/create/select/');
          if (await canLaunchUrl(instagramUrl)) {
            await launchUrl(instagramUrl);
          } else {
            await Share.share(shareMessage);
          }
          break;
        case 'telegram':
          final telegramUrl = Uri.parse(
              'https://t.me/share/url?url=${Uri.encodeComponent(shareUrl)}');
          if (await canLaunchUrl(telegramUrl)) {
            await launchUrl(telegramUrl);
          } else {
            await Share.share(shareMessage);
          }
          break;
        default:
          await Share.share(shareMessage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membagikan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shareUrl = '${Options.wsBaseUrl}/events/${event.id}}/invite';

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Gap(16),
            Text(
              'Undang teman Anda!',
              style: titleOneSemiBold.copyWith(color: neutralBase),
            ),
            Gap(16),
            Image.asset(
              'assets/images/digital-ads.png',
              width: 230,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: neutral20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      shareUrl,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: shareUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Link disalin ke clipboard')),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: neutral10,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.copy,
                              size: 16,
                              color: neutralBase,
                            ),
                            Gap(6),
                            Text('Salin')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialMediaIcon(
                  onTap: () => _shareContent(context, 'whatsapp'),
                  icon: whatsapp.copyWith(padding: EdgeInsets.all(12)),
                ),
                SocialMediaIcon(
                  onTap: () => _shareContent(context, 'facebook'),
                  icon: facebook.copyWith(padding: EdgeInsets.all(12)),
                ),
                SocialMediaIcon(
                  onTap: () => _shareContent(context, 'tiktok'),
                  icon: tiktok.copyWith(padding: EdgeInsets.all(16)),
                ),
                SocialMediaIcon(
                  onTap: () => _shareContent(context, 'instagram'),
                  icon: instagram.copyWith(padding: EdgeInsets.all(16)),
                ),
                SocialMediaIcon(
                  onTap: () => _shareContent(context, 'telegram'),
                  icon: telegram.copyWith(padding: EdgeInsets.all(16)),
                ),
                GestureDetector(
                  onTap: () => Share.share(shareUrl),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: neutral10,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        size: 24,
                        color: neutralBase,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Button(
              onPressed: () => context.pop(),
              type: ButtonType.secondary,
              child: Text(
                'Batalkan',
                style: titleOneSemiBold.copyWith(color: neutralBase),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final VoidCallback onTap;
  final ic.Icon icon;

  const SocialMediaIcon({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: neutral10,
            borderRadius: BorderRadius.circular(100),
          ),
          child: icon,
        ),
      ),
    );
  }
}
