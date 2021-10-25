import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'imp_styles.dart';

TextStyle robotoStyle({
  double? fSize,
  FontWeight? fWeight,
  Color? color,
  TextDecoration? decoration,
  double? letterSpacing,
}) {
  return GoogleFonts.roboto(
    fontSize: fSize ?? FontSize().common,
    fontWeight: fWeight ?? kRegular,
    color: color ?? kBlackColor,
    decoration: decoration,
    letterSpacing: letterSpacing ?? 0.0,
  );
}
