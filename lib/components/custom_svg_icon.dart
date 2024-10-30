import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesran_app/utils/themes.dart';

class CustomSvgIcon extends StatefulWidget {
  final String assetName;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const CustomSvgIcon({
    super.key,
    required this.assetName,
    this.color,
    this.width = 24.0,
    this.height = 24.0,
    this.padding,
    this.decoration,
  });

  // Fungsi copyWith untuk membuat salinan widget ini dengan perubahan tertentu
  CustomSvgIcon copyWith({
    Color? color,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
  }) {
    return CustomSvgIcon(
      assetName: assetName,
      color: color ?? this.color,
      width: width ?? this.width,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  State<CustomSvgIcon> createState() => _CustomSvgIconState();
}

class _CustomSvgIconState extends State<CustomSvgIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(0),
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
