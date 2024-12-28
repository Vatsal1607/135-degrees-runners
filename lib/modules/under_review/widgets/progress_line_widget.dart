import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_colors.dart';

class ProgressLineWidget extends StatelessWidget {
  final double? value;
  const ProgressLineWidget({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: AppColors.davyGrey.withOpacity(.8),
        valueColor: const AlwaysStoppedAnimation<Color>(
          AppColors.white,
        ),
      ),
    );
  }
}
