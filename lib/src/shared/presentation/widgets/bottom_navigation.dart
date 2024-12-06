import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/styles/icons/custom.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class BottomNavigation extends StatelessWidget {
  final BottomNavigationPath path;

  const BottomNavigation({super.key, required this.path});

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
            BottomNavigationItem(
              icon: home.copyWith(
                color: _getColor(path, BottomNavigationPath.home),
                padding: EdgeInsets.all(0),
              ),
              label: 'Beranda',
              onTap: () => _setCurrentPath(context, BottomNavigationPath.home),
              color: _getColor(path, BottomNavigationPath.home),
            ),
            BottomNavigationItem(
              icon: document.copyWith(
                color: _getColor(path, BottomNavigationPath.history),
                padding: EdgeInsets.all(0),
              ),
              label: 'Riwayat',
              onTap: () =>
                  _setCurrentPath(context, BottomNavigationPath.history),
              color: _getColor(path, BottomNavigationPath.history),
            ),
            BottomNavigationItem(
              icon: bubbleChat.copyWith(
                color: _getColor(path, BottomNavigationPath.message),
                padding: EdgeInsets.all(0),
              ),
              label: 'Pesan',
              onTap: () =>
                  _setCurrentPath(context, BottomNavigationPath.message),
              color: _getColor(path, BottomNavigationPath.message),
            ),
            BottomNavigationItem(
              icon: profile.copyWith(
                color: _getColor(path, BottomNavigationPath.profile),
                padding: EdgeInsets.all(0),
              ),
              label: 'Profil',
              onTap: () =>
                  _setCurrentPath(context, BottomNavigationPath.profile),
              color: _getColor(path, BottomNavigationPath.profile),
            )
          ],
        ),
      ),
    );
  }

  void _setCurrentPath(BuildContext context, BottomNavigationPath path) {
    switch (path) {
      case BottomNavigationPath.home:
        context.go('/home');
        break;
      case BottomNavigationPath.history:
        context.go('/history');
        break;
      case BottomNavigationPath.message:
        context.go('/messages');
        break;
      case BottomNavigationPath.profile:
        context.go('/account/profile');
        break;
    }
  }

  Color _getColor(BottomNavigationPath path, BottomNavigationPath currentPath) {
    return path == currentPath ? primaryBase : neutral40;
  }
}

class BottomNavigationItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const BottomNavigationItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text(
            label,
            style: titleTwoMedium.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

enum BottomNavigationPath {
  home,
  history,
  message,
  profile,
}
