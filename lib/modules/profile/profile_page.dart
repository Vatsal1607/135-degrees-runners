import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/constants/keys.dart';
import '../../core/constants/strings.dart';
import '../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../custom_widgets/custom_confirm_dialog.dart';
import '../../custom_widgets/svg_icons.dart';
import '../../routes/routes.dart';
import '../../services/local/shared_preferences_service.dart';
import 'edit_profile/edit_profile_provider.dart';
import 'profile_provider.dart';
import 'widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.seaShell,
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Account',
        backgroundColor: AppColors.seaShell,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer<ProfileProvider>(
                builder: (context, _, child) => CustomConfirmDialog(
                  context: context,
                  onTapCancel: () => Navigator.pop(context),
                  onTapYes: () {
                    provider.logout(context: context); // * LogOut
                  },
                  yesBtnText: 'LOGOUT',
                  isLoading: provider.isLoading,
                  title: 'ARE YOU SURE?',
                  subTitle: 'You really want to Logout?',
                ),
              );
            },
          );
        },
        child: Container(
          height: 50.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SvgIcon(
                icon: IconStrings.logout,
                color: AppColors.seaShell,
              ),
              SizedBox(width: 13.w),
              Text(
                'Logout',
                style: GoogleFonts.publicSans(
                  color: AppColors.seaShell,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 30.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Consumer<EditProfileProvider>(
                        builder: (context, provider, child) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage: provider.getProfileImage(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sharedPrefsService
                                .getString(SharedPrefsKeys.username) ??
                            '',
                        style: GoogleFonts.publicSans(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editProfile);
                        },
                        child: Text(
                          'EDIT PROFILE',
                          style: GoogleFonts.publicSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.grey,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 29.h),
            Divider(
              height: 2.h,
              indent: 33.w,
              endIndent: 33.w,
              color: AppColors.grey,
            ),
            SizedBox(height: 29.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.w),
              child: Column(
                children: [
                  // * Consider tile Index 0
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      onTap: () {
                        provider.updateTileIndex(0);
                        Navigator.pop(context);
                      },
                      isSelected: provider.selectedTileIndex == 0,
                      title: 'Home',
                      icon: IconStrings.home,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 1
                      onTap: () {
                        provider.updateTileIndex(1);
                        // Navigator.pushNamed(context, Routes.aboutUs);
                      },
                      isSelected: provider.selectedTileIndex == 1,
                      title: 'Earnings',
                      icon: IconStrings.earnings,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 2
                      onTap: () {
                        provider.updateTileIndex(2);
                        // Navigator.pushNamed(context, Routes.aboutUs);
                      },
                      isSelected: provider.selectedTileIndex == 2,
                      title: 'Report',
                      icon: IconStrings.report,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 3
                      onTap: () {
                        provider.updateTileIndex(3);
                        // Navigator.pushNamed(context, Routes.aboutUs);
                      },
                      isSelected: provider.selectedTileIndex == 3,
                      title: 'About Us',
                      icon: IconStrings.aboutUs,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
