import 'package:degrees_runners/custom_widgets/circular_progress_with_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/constants/strings.dart';
import '../svg_icons.dart';

class CustomAppbarWithCenterTitle extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
  final Color? backgroundColor;
  final bool isAction;
  final VoidCallback? onTapAction;
  final double? leftPadTitle;
  final String actionIcon;
  final Color actionIconColor;
  final String? orderType;
  const CustomAppbarWithCenterTitle({
    super.key,
    required this.title,
    this.onBackButtonPressed,
    this.backgroundColor = AppColors.seaShell,
    this.isAction = false,
    this.onTapAction,
    this.leftPadTitle = 0.0,
    this.actionIcon = IconStrings.clock,
    this.actionIconColor = AppColors.black,
    this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true, // * disable color change on scroll
      elevation: 0.0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBackButtonPressed ?? () => Navigator.pop(context),
              child: Container(
                height: 48.h,
                width: 48.w,
                margin: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
                child: const SvgIcon(
                  icon: IconStrings.arrowBack,
                  color: AppColors.seaShell,
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: leftPadTitle,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title, // * title
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          if (isAction)
            Positioned.fill(
              right: 15.w,
              child: Align(
                alignment: Alignment.centerRight,
                child: CircularProgressWithTimer(
                  bgColor: orderType != null && orderType == 'history'
                      ? AppColors.green
                      : AppColors.black,
                  valueColor: orderType != null && orderType == 'history'
                      ? AppColors.green
                      : AppColors.black,
                  timeColor: AppColors.black,
                ),
              ),
              // * Svg icon for action in appbar
              // child: GestureDetector(
              //   onTap: onTapAction,
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: SvgIcon(
              //       icon: actionIcon,
              //       color: actionIconColor,
              //     ),
              //   ),
              // ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
