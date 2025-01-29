import 'package:degrees_runners/core/constants/strings.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_page.dart';
import 'package:degrees_runners/modules/bottom_bar/bottom_bar_provider.dart';
import 'package:degrees_runners/modules/bottom_bar/history/history_page.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/orders_page.dart';
import 'package:degrees_runners/modules/bottom_bar/widgets/nav_item.dart';
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
        onPageChanged: provider.onPageChanged,
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
              Consumer<BottomBarProvider>(
                builder: (context, _, child) => NavItem(
                  selectedColor: provider.currentIndex == 0
                      ? AppColors.seaShell
                      : AppColors.grey,
                  onTap: () {
                    provider.myPage.jumpToPage(0);
                  },
                  icon: IconStrings.orders,
                  label: 'ORDERS',
                ),
              ),
              SizedBox(width: 48.w),
              Consumer<BottomBarProvider>(
                builder: (context, _, child) => NavItem(
                  selectedColor: provider.currentIndex == 2
                      ? AppColors.seaShell
                      : AppColors.grey,
                  onTap: () {
                    provider.myPage.jumpToPage(2);
                  },
                  label: 'HISTORY',
                ),
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
          child: Consumer<BottomBarProvider>(
            builder: (context, _, child) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon: IconStrings.accepted,
                  color: provider.currentIndex == 1
                      ? AppColors.seaShell
                      : AppColors.seaShell.withOpacity(.8),
                ),
                SizedBox(width: 5.w),
                Text(
                  'ACCEPTED',
                  style: GoogleFonts.publicSans(
                    color: AppColors.seaShell,
                    fontWeight:
                        provider.currentIndex == 1 ? FontWeight.bold : null,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildNavItem(
  //     {required IconData icon, required String label, VoidCallback? onTap}) {
  //   return NavItem();
  // }
}
