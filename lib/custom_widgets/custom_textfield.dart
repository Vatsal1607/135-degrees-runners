import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import '../core/constants/constants.dart';
import 'svg_icons.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String prefixIcon;
  final TextEditingController controller;
  final Color iconColor;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? errorText;
  final Widget? suffixWidget;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.iconColor = AppColors.black,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.errorText,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.publicSans(
        fontSize: 14.sp,
        color: AppColors.black,
      ),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        hintStyle: GoogleFonts.publicSans(
          fontSize: 14.sp,
          color: AppColors.black,
        ),
        prefixIcon: SvgIcon(
          icon: prefixIcon,
          color: iconColor,
        ),
        suffixIcon: suffixWidget,
        border: kTextfieldBorderStyle,
        enabledBorder: kTextfieldBorderStyle,
        focusedBorder: kTextfieldBorderStyle,
        errorBorder: kTextfieldBorderStyle?.copyWith(
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2.w,
          ),
        ),
        errorStyle: const TextStyle(
          color: AppColors.red,
        ),
      ),
    );
  }
}
