import 'package:degrees_runners/modules/bottom_bar/bottom_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/strings.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider =
        Provider.of<BottomBarProvider>(context, listen: false);
    return SliverAppBar(
      backgroundColor: AppColors.seaShell,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! leading icon
          GestureDetector(
            // onTap: () => Navigator.pushNamed(context, Routes.profile),
            // onVerticalDragEnd: provider.onVerticalDragDownLeading,
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.black,
                  width: 2.w,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  ImageStrings.personalPic,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //! center title content
          Column(
            children: [
              SizedBox(height: 2.h),
              Consumer<BottomBarProvider>(
                builder: (context, _, child) => Text(
                  bottomBarProvider.getGreeting(),
                  style: GoogleFonts.publicSans(
                    color: AppColors.black,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Text(
                'Delivery Boy Name',
                style: GoogleFonts.publicSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          //! trailing(action) icon
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, Routes.notification);
            },
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  const Positioned.fill(
                    // child: SvgIcon(
                    //   icon: IconStrings.notification,
                    //   color: AppColors.white,
                    // ),
                    // Todo: Replace with svg icon (above commented) // ReLaunch
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20.h,
                      width: 20.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.red,
                      ),
                      child: Center(
                        child: Text(
                          '99+',
                          style: GoogleFonts.publicSans(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      // expandedHeight: 150.h,
      /// Bottom content of appbar
      // bottom: PreferredSize(
    );
  }
}
