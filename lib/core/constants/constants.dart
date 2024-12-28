import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

InputBorder? kTextfieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.r),
  borderSide: BorderSide(
    color: AppColors.black,
    width: 2.w,
  ),
);

List<BoxShadow>? kDropShadow = [
  const BoxShadow(
    color: Color(0x40000000), // #00000040 in ARGB format
    blurRadius: 4.0,
    offset: Offset(0, 4), // x: 0, y: 4
  ),
];
