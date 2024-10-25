import 'package:flutter/material.dart';

// Color Pallete

// Neutral
Color neutral100 = const Color(0xFF050505);
Color neutral90 = const Color(0xFF090909);
Color neutral80 = const Color(0xFF0E0E0E);
Color neutral70 = const Color(0xFF121212);
Color neutral60 = const Color(0xFF171717);
Color neutralBase = const Color(0xFF1B1B1B);
Color neutral50 = const Color(0xFF414141);
Color neutral40 = const Color(0xFF676767);
Color neutral30 = const Color(0xFF8D8D8D);
Color neutral20 = const Color(0xFFB3B3B3);
Color neutral10 = const Color(0xFFF6F6F6);
Color white = const Color(0xFFFFFFFF);

// Primary
Color primary100 = const Color(0xFF33100A);
Color primary90 = const Color(0xFF551A11);
Color primary80 = const Color(0xFF7F281A);
Color primary70 = const Color(0xFFA93523);
Color primary60 = const Color(0xFFD4422B);
Color primaryBase = const Color(0xFFFE4F34);
Color primary50 = const Color(0xFFFE6C56);
Color primary40 = const Color(0xFFFE8A78);
Color primary30 = const Color(0xFFFEA799);
Color primary20 = const Color(0xFFFFC4BB);
Color primary10 = const Color(0xFFFFDCD6);

// Success
Color success100 = const Color(0xFF001F09);
Color success90 = const Color(0xFF00330F);
Color success80 = const Color(0xFF004D17);
Color success70 = const Color(0xFF00661F);
Color success60 = const Color(0xFF008026);
Color successBase = const Color(0xFF00992E);
Color success50 = const Color(0xFF2BAA51);
Color success40 = const Color(0xFF55BB74);
Color success30 = const Color(0xFF80CC96);
Color success20 = const Color(0xFFAADDB9);
Color success10 = const Color(0xFFCCEBD5);

// Error
Color error100 = const Color(0xFF2D0000);
Color error90 = const Color(0xFF4B0000);
Color error80 = const Color(0xFF700101);
Color error70 = const Color(0xFF950101);
Color error60 = const Color(0xFFBB0101);
Color errorBase = const Color(0xFFE00101);
Color error50 = const Color(0xFFE52B2B);
Color error40 = const Color(0xFFEA5656);
Color error30 = const Color(0xFFEF8080);
Color error20 = const Color(0xFFF5AAAA);
Color error10 = const Color(0xFFF9CCCC);

// Warning
Color warning100 = const Color(0xFF312C00);
Color warning90 = const Color(0xFF524900);
Color warning80 = const Color(0xFF7B6E00);
Color warning70 = const Color(0xFFA39300);
Color warning60 = const Color(0xFFCCB700);
Color warningBase = const Color(0xFFF5DC00);
Color warning50 = const Color(0xFFF7E22B);
Color warning40 = const Color(0xFFF8E855);
Color warning30 = const Color(0xFFFAED80);
Color warning20 = const Color(0xFFFCF3AA);
Color warning10 = const Color(0xFFFDF8CC);

// Typography
TextStyle baseTextStyle(double fontSize, FontWeight fontWeight) {
  return TextStyle(
    fontFamily: 'SF-Pro-Display',
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

// Display Styles
TextStyle displayOne = baseTextStyle(40, FontWeight.normal);
TextStyle displayOneBold = baseTextStyle(40, FontWeight.bold);
TextStyle displayOneSemiBold = baseTextStyle(40, FontWeight.w600);
TextStyle displayOneMedium = baseTextStyle(40, FontWeight.w500);
TextStyle displayOneLight = baseTextStyle(40, FontWeight.w300);

TextStyle displayTwo = baseTextStyle(32, FontWeight.normal);
TextStyle displayTwoBold = baseTextStyle(32, FontWeight.bold);
TextStyle displayTwoSemiBold = baseTextStyle(32, FontWeight.w600);
TextStyle displayTwoMedium = baseTextStyle(32, FontWeight.w500);
TextStyle displayTwoLight = baseTextStyle(32, FontWeight.w300);

TextStyle displayThree = baseTextStyle(28, FontWeight.normal);
TextStyle displayThreeBold = baseTextStyle(28, FontWeight.bold);
TextStyle displayThreeSemiBold = baseTextStyle(28, FontWeight.w600);
TextStyle displayThreeMedium = baseTextStyle(28, FontWeight.w500);
TextStyle displayThreeLight = baseTextStyle(28, FontWeight.w300);

// Heading Styles
TextStyle headingOne = baseTextStyle(24, FontWeight.normal);
TextStyle headingOneBold = baseTextStyle(24, FontWeight.bold);
TextStyle headingOneSemiBold = baseTextStyle(24, FontWeight.w600);
TextStyle headingOneMedium = baseTextStyle(24, FontWeight.w500);
TextStyle headingOneLight = baseTextStyle(24, FontWeight.w300);

TextStyle headingTwo = baseTextStyle(20, FontWeight.normal);
TextStyle headingTwoBold = baseTextStyle(20, FontWeight.bold);
TextStyle headingTwoSemiBold = baseTextStyle(20, FontWeight.w600);
TextStyle headingTwoMedium = baseTextStyle(20, FontWeight.w500);
TextStyle headingTwoLight = baseTextStyle(20, FontWeight.w300);

TextStyle headingThree = baseTextStyle(18, FontWeight.normal);
TextStyle headingThreeBold = baseTextStyle(18, FontWeight.bold);
TextStyle headingThreeSemiBold = baseTextStyle(18, FontWeight.w600);
TextStyle headingThreeMedium = baseTextStyle(18, FontWeight.w500);
TextStyle headingThreeLight = baseTextStyle(18, FontWeight.w300);

// Title Styles
TextStyle titleOne = baseTextStyle(16, FontWeight.normal);
TextStyle titleOneBold = baseTextStyle(16, FontWeight.bold);
TextStyle titleOneSemiBold = baseTextStyle(16, FontWeight.w600);
TextStyle titleOneMedium = baseTextStyle(16, FontWeight.w500);
TextStyle titleOneLight = baseTextStyle(16, FontWeight.w300);

TextStyle titleTwo = baseTextStyle(14, FontWeight.normal);
TextStyle titleTwoBold = baseTextStyle(14, FontWeight.bold);
TextStyle titleTwoSemiBold = baseTextStyle(14, FontWeight.w600);
TextStyle titleTwoMedium = baseTextStyle(14, FontWeight.w500);
TextStyle titleTwoLight = baseTextStyle(14, FontWeight.w300);

TextStyle titleThree = baseTextStyle(14, FontWeight.normal);
TextStyle titleThreeBold = baseTextStyle(14, FontWeight.bold);
TextStyle titleThreeSemiBold = baseTextStyle(14, FontWeight.w600);
TextStyle titleThreeMedium = baseTextStyle(14, FontWeight.w500);
TextStyle titleThreeLight = baseTextStyle(14, FontWeight.w300);

// Paragraph Styles
TextStyle paragraphOne = baseTextStyle(14, FontWeight.normal);
TextStyle paragraphOneBold = baseTextStyle(14, FontWeight.bold);
TextStyle paragraphOneSemiBold = baseTextStyle(14, FontWeight.w600);
TextStyle paragraphOneMedium = baseTextStyle(14, FontWeight.w500);
TextStyle paragraphOneLight = baseTextStyle(14, FontWeight.w300);
