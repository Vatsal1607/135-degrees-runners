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

// * Note: order details type
// enum OrderType { orders, accepted, history }

Color getColorOrderDetails({
  required String orderType,
  required Color ordersColor,
  required Color acceptedOrderColor,
  required Color historyOrderColor,
}) {
  return orderType != '' && orderType == 'accepted'
      ? acceptedOrderColor
      : orderType != '' && orderType == 'history'
          ? historyOrderColor
          : ordersColor;
}

// Capitalized every first word
String capitalizeEachWord(String text) {
  return text
      .split(' ') // Split the text by spaces
      .map((word) => word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '') // Capitalize the first letter
      .join(' '); // Join the words back together
}
