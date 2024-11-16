import 'package:flutter/widgets.dart';
import 'package:mesran_app/src/config/styles/texts/medium.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';

class AuthTypeSection extends StatelessWidget {
  final AuthType type;
  final Function(AuthType type) toggleChangeLoginType;

  const AuthTypeSection({
    super.key,
    required this.type,
    required this.toggleChangeLoginType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: neutral10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          AuthTypeButton(
            type: AuthType.email,
            isActive: type == AuthType.email,
            toggleChangeLoginType: toggleChangeLoginType,
          ),
          AuthTypeButton(
            type: AuthType.phone,
            isActive: type == AuthType.phone,
            toggleChangeLoginType: toggleChangeLoginType,
          ),
        ],
      ),
    );
  }
}

class AuthTypeButton extends StatelessWidget {
  final bool isActive;
  final AuthType type;
  final Function(AuthType type) toggleChangeLoginType;

  const AuthTypeButton({
    super.key,
    required this.type,
    required this.toggleChangeLoginType,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => toggleChangeLoginType(type),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? white : neutral10,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            type == AuthType.email ? 'Email' : 'No. Hp',
            style: titleOneMedium.copyWith(
              color: isActive ? neutralBase : neutral40,
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthType { email, phone }
