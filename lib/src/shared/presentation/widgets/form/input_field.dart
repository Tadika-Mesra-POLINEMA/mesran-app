import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mesran_app/src/config/styles/icons/template.dart' as ic;
import 'package:mesran_app/src/config/styles/texts/regular.dart';
import 'package:mesran_app/src/config/styles/themes/colors/error.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class InputField extends StatefulWidget {
  final ic.Icon? prefixIcon;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool? isError;
  final String? initialValue;
  final int? maxLines;
  final List<TextInputFormatter>? formatInput;

  const InputField(
      {super.key,
      this.prefixIcon,
      required this.hintText,
      this.keyboardType,
      this.onChanged,
      this.controller,
      this.isError = false,
      this.initialValue,
      this.maxLines,
      this.formatInput});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;
  bool _isControllerInternal = false;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      // Buat controller baru jika tidak ada yang di-pass
      _controller = TextEditingController();
      _isControllerInternal = true;
    }

    // Atur initial value secara eksplisit
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    // Hanya dispose controller yang dibuat internal
    if (_isControllerInternal) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller jika initial value berubah
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLines: widget.maxLines ?? 1,
      inputFormatters: widget.formatInput ?? [],
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon?.copyWith(color: neutralBase),
        hintText: widget.hintText,
        hintStyle: titleOne.copyWith(color: neutral40),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.isError != null && widget.isError == true
                  ? errorBase
                  : neutral20),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryBase, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: neutral20),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
