import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesran_app/utils/themes.dart';

class Icon extends StatefulWidget {
  final String assetName;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const Icon({
    super.key,
    required this.assetName,
    this.color,
    this.width = 24.0,
    this.height = 24.0,
    this.padding,
    this.decoration,
  });

  Icon copyWith({
    Color? color,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
  }) {
    return Icon(
      assetName: assetName,
      color: color ?? this.color,
      width: width ?? this.width,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  State<Icon> createState() => _IconState();
}

class _IconState extends State<Icon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(12),
      decoration: widget.decoration,
      child: SvgPicture.asset(
        widget.assetName,
        width: widget.width,
        height: widget.height,
        colorFilter: widget.color != null
            ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
            : ColorFilter.mode(neutral40, BlendMode.srcIn),
      ),
    );
  }
}
