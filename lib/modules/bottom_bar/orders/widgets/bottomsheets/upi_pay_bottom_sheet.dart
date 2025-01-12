import 'package:degrees_runners/custom_widgets/buttons/custom_slidable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../custom_widgets/svg_icons.dart';

void upiPayBottomSheeet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.seaShell,
    builder: (context) {
      // final authEmpProvider =
      //     Provider.of<AuthorizedEmpProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h, left: 32.w, right: 32.w),
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'UPI PAY',
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCAN THE QR CODE TO ',
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        'PAY ₹20',
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Image.asset(
                    ImageStrings.qr,
                    height: 180.h,
                    width: 180.w,
                  ),
                  SizedBox(height: 30.h),

                  /// Slidable button
                  const CustomSlidableButton(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
