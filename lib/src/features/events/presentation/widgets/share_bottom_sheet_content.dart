import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mesran_app/src/config/styles/icons/template.dart' as ic;
import 'package:mesran_app/src/config/styles/texts/semibold.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/shared/presentation/widgets/form/button.dart';

class ShareBottomSheetContent extends StatelessWidget {
  final String eventId;

  const ShareBottomSheetContent({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
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
                      '${Options.wsBaseUrl}/events/$eventId/invite',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gap(8),
                  InkWell(
                    onTap: () => {
                      Clipboard.setData(ClipboardData(
                          text: '${Options.wsBaseUrl}/events/$eventId/invite'))
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
                  shareTo:
                      'https://wa.me/?text=https://mesran.com/event/123456',
                  icon: whatsapp,
                ),
                SocialMediaIcon(
                  shareTo:
                      'https://twitter.com/intent/tweet?text=https://mesran.com/event/123456',
                  icon: twitter,
                ),
                SocialMediaIcon(
                  shareTo:
                      'https://www.facebook.com/sharer/sharer.php?u=https://mesran.com/event/123456',
                  icon: facebook,
                ),
                SocialMediaIcon(
                  shareTo:
                      'https://www.tiktok.com/?url=https://mesran.com/event/123456',
                  icon: tiktok,
                ),
                SocialMediaIcon(
                  shareTo:
                      'https://www.instagram.com/?url=https://mesran.com/event/123456',
                  icon: instagram,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share('https://evenify.my.id/events/123456/invite');
                  },
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
                onPressed: () {
                  context.pop();
                },
                type: ButtonType.secondary,
                child: Text(
                  'Batalkan',
                  style: titleOneSemiBold.copyWith(color: neutralBase),
                ))
          ],
        ),
      ),
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final String shareTo;
  final ic.Icon icon;

  const SocialMediaIcon({super.key, required this.shareTo, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          // await Share.share();
        } catch (error) {
          print('Error sharing to $shareTo: $error');
        }
      },
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
