import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_colors.dart';
import '../modules/bottom_bar/orders/order_provider.dart';

// ! Note: to show, Call this in showDialog's builder () =>
class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTapCancel;
  final VoidCallback? onTapYes;
  final String yesBtnText;
  final BuildContext context;
  final bool newValue;
  final OrderProvider provider;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTapCancel,
    this.onTapYes,
    this.yesBtnText = 'YES, REMOVE',
    required this.context,
    required this.newValue,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20.w),
        width: 330.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // * Title
            Text(
              title,
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 23.h),
            // * Subtitle
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 25.h),
            // * Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // * Yes, Remove Button
                Expanded(
                  child: GestureDetector(
                    onTap: onTapYes,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          yesBtnText,
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: AppColors.seaShell,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // * Cancel Button
                Expanded(
                  child: GestureDetector(
                    onTap: onTapCancel,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          "CANCEL",
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: AppColors.seaShell,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ! Method to show the confirmation dialog (Active Status)
Future<void> showConfirmDialog({
  required BuildContext context,
  required bool newValue,
  required OrderProvider provider,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.white,
      title: Center(
        child: Text(
          'CONFIRM',
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      content: SizedBox(
        width: 100.w,
        child: Text(
          newValue
              ? 'Are You Sure You Want To Go Online?'
              : 'Are You Sure You Want To Go Offline?',
          textAlign: TextAlign.center,
          style: GoogleFonts.publicSans(
            fontSize: 15.sp,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            // * Cancel Button
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      "CANCEL",
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: AppColors.seaShell,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // * Yes, Remove Button
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: newValue ? AppColors.green : AppColors.red,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      newValue ? 'ONLINE' : 'OFFLINE',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: AppColors.seaShell,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // * Update the switch state if the user confirmed the action
  provider.onChangeIsActive(
    confirmed,
    newValue,
  );
}
