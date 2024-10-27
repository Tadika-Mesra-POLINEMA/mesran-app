import 'package:flutter/material.dart';

double responsiveWidth(context, persentate) {
  return MediaQuery.of(context).size.width * (persentate / 100);
}

double responsiveHeight(context, persentate) {
  return MediaQuery.of(context).size.height * (persentate / 100);
}
