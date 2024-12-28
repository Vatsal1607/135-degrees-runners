import 'package:degrees_runners/custom_widgets/appbar/custom_sliver_appbar.dart';
import 'package:degrees_runners/custom_widgets/bottom_blur_on_page.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import 'widgets/order_card_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CustomSliverAppbar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // * Active Status with Switch
                          Container(
                            height: 55.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "ACTIVE STATUS",
                                  style: GoogleFonts.publicSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Consumer<OrderProvider>(
                                  builder: (context, value, child) => Switch(
                                    value: provider.isActive,
                                    onChanged: provider.onChangeIsActive,
                                    activeColor: AppColors.seaShell,
                                    activeTrackColor: AppColors.lightGreen,
                                    inactiveThumbColor: AppColors.seaShell,
                                    inactiveTrackColor: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 105.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(100.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'NEW',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const SvgIcon(
                                  icon: IconStrings.add,
                                  color: AppColors.seaShell,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // * Ordercard widget
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const OrderCardWidget();
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottomBlurOnPage(
            height: 55.h,
            isTopBlur: true,
          ),
          BottomBlurOnPage(
            height: 55.h,
          ),
        ],
      ),
    );
  }
}
