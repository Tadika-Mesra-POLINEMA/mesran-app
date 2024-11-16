import 'package:flutter/material.dart';
import 'package:mesran_app/utils/icons.dart';
import 'package:mesran_app/utils/themes.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  String path = "home";

  void _setCurrentPath(String newPath) {
    setState(() {
      path = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: neutral20,
            width: 1,
          ),
        ),
      ),
      child: BottomAppBar(
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _setCurrentPath('home'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  home.copyWith(
                      color: path == "home" ? primaryBase : neutral40),
                  Text(
                    'Beranda ',
                    style: titleTwoMedium.copyWith(
                        color: path == "home" ? primaryBase : neutral40),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _setCurrentPath('event'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  document.copyWith(
                      color: path == "event" ? primaryBase : neutral40),
                  Text(
                    'Acara',
                    style: titleTwoMedium.copyWith(
                        color: path == "event" ? primaryBase : neutral40),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _setCurrentPath('message'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bubbleChat.copyWith(
                      color: path == "message" ? primaryBase : neutral40),
                  Text(
                    'Pesan',
                    style: titleTwoMedium.copyWith(
                        color: path == "message" ? primaryBase : neutral40),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _setCurrentPath('profile'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  profile.copyWith(
                      color: path == "profile" ? primaryBase : neutral40),
                  Text(
                    'Profil',
                    style: titleTwoMedium.copyWith(
                        color: path == "profile" ? primaryBase : neutral40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
