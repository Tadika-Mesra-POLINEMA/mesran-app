import 'package:flutter/material.dart';
import 'package:mesran_app/src/config/styles/themes/colors/primary.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderContent(controller: _ctrl);
  }
}

class LoaderContent extends StatelessWidget {
  LoaderContent({super.key, required this.controller})
      : transl = Tween<double>(begin: -20, end: 25).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn))),
        scaleXY = Tween<double>(begin: 0, end: 5).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn))),
        scaleX = Tween<double>(begin: 15, end: 25).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.4, curve: Curves.fastOutSlowIn))),
        scaleY = Tween<double>(begin: 15, end: 25).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn))),
        scaleXY2 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)));

  final AnimationController controller;
  final Animation<double> transl;
  final Animation<double> scaleXY;
  final Animation<double> scaleX;
  final Animation<double> scaleY;
  final Animation<double> scaleXY2;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                transform: Matrix4.translationValues(transl.value, 0, 0),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryBase,
                ),
              ),
              Container(
                width: scaleX.value + scaleXY.value + scaleXY2.value,
                height: scaleY.value + scaleXY.value + scaleXY2.value,
                decoration:
                    ShapeDecoration(shape: OvalBorder(), color: primaryBase),
              ),
              Container(
                transform: Matrix4.translationValues(-transl.value, 0, 0),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryBase,
                ),
              ),
            ],
          );
        });
  }
}
