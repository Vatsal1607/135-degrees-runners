import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/strings.dart';
import '../../../../custom_widgets/svg_icons.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String name;

  const ProductWidget({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            height: 180.h,
            width: 160.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2.w,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // * Gradient Overlay at the Bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // height: 55.h,
                        height: 58.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.seaShell.withOpacity(0.0),
                              AppColors.seaShell.withOpacity(0.8),
                              AppColors.seaShell,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                      ),
                    ),
                    // * Foreground Content
                    Text(
                      capitalizeEachWord(name),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            // * Add button
            child: GestureDetector(
              onTap: () {
                //* Custom Size bottomsheet
                // showSizeModalBottomSheet(
                //   context: context,
                //   accountType: accountType,
                // );
                // showSnackbar(context, '{count} ITEMS ADDED');
              },
              child: Container(
                height: 28.h,
                width: 82.w,
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ADD',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    SvgIcon(
                      icon: IconStrings.add,
                      color: AppColors.white,
                      height: 15.h,
                      width: 15.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
