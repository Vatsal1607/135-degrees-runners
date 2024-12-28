import 'package:degrees_runners/core/constants/strings.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_page.dart';
import 'package:degrees_runners/modules/bottom_bar/bottom_bar_provider.dart';
import 'package:degrees_runners/modules/bottom_bar/history/history_page.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';

class BottomBarPage extends StatelessWidget {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomBarProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.seaShell,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: provider.myPage,
        // onPageChanged: (index) {
        //   debugPrint('Page Changes to index $index');
        // },
        children: const [
          OrdersPage(),
          AcceptedOrderPage(),
          HistoryPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero, // * full size of bottombar
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Container(
          height: 70.h,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                onTap: () {
                  provider.myPage.jumpToPage(0);
                },
                icon: Icons.local_cafe,
                label: 'ORDERS',
              ),
              SizedBox(width: 48.w),
              _buildNavItem(
                onTap: () {
                  provider.myPage.jumpToPage(2);
                },
                icon: Icons.insert_drive_file,
                label: 'HISTORY',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          provider.myPage.jumpToPage(1);
        },
        child: Container(
          height: 60.h,
          width: 140.w,
          decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                width: 5.w,
                color: AppColors.seaShell,
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SvgIcon(
                icon: IconStrings.accepted,
                color: AppColors.seaShell,
              ),
              SizedBox(width: 5.w),
              Text(
                'ACCEPTED',
                style: GoogleFonts.publicSans(
                  color: AppColors.seaShell,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 120.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.publicSans(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
