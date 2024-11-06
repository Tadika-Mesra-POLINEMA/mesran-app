import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/components/undo_button.dart';
import 'package:mesran_app/utils/themes.dart';

class EditAcaraPage extends StatelessWidget {
  const EditAcaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          child: UndoButton(
            onPressed: () => context.pop(),
          ),
        ),
        title: Text(
          'Cek Wajah',
          style: headingTwoSemiBold.copyWith(color: neutralBase),
        ),
        centerTitle: false,
      ),
    );
  }
}
