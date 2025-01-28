import 'dart:developer';

import 'package:degrees_runners/custom_widgets/appbar/custom_sliver_appbar.dart';
import 'package:degrees_runners/custom_widgets/bottom_blur_on_page.dart';
import 'package:degrees_runners/custom_widgets/loader/custom_loader.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/order_provider.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/widgets/bottomsheets/new_order_bottom_sheet.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/widgets/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/custom_confirm_dialog.dart';
import '../../../routes/routes.dart';
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
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // * Active Status with Switch
                          Container(
                            height: 55.h,
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 13.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
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
                                  builder: (context, _, child) => Switch(
                                    value: provider.isActive,
                                    onChanged: (value) {
                                      // * showDialog
                                      showConfirmDialog(
                                        context: context,
                                        newValue: value,
                                        provider: provider,
                                      );
                                      log('isActive: ${provider.isActive}');
                                    },
                                    activeColor: AppColors.seaShell,
                                    activeTrackColor: AppColors.lightGreen,
                                    inactiveThumbColor: AppColors.seaShell,
                                    inactiveTrackColor: AppColors.coralRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Consumer<OrderProvider>(
                            builder: (context, _, child) => GestureDetector(
                              onTap: provider.isActive
                                  ? () {
                                      newOrderBottomSheeet(context: context);
                                      // cashPayBottomSheeet(context: context);
                                    }
                                  : null,
                              child: Container(
                                width: 115.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: provider.isActive
                                      ? AppColors.green
                                      : AppColors.green.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NEW',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.seaShell,
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
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Consumer<OrderProvider>(
                        builder: (context, _, child) {
                          log('Orderlist-- ${provider.orderList}');
                          return provider.isActive
                              ? Align(
                                  alignment: Alignment.center,
                                  // * Ordercard widget
                                  child: provider.orderList != null &&
                                          provider.orderList!.isNotEmpty
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.orderList?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final order =
                                                provider.orderList?[index];
                                            return GestureDetector(
                                              onTap: () => Navigator.pushNamed(
                                                context,
                                                Routes.orderDetails,
                                                arguments: {
                                                  'orderType': 'orders',
                                                },
                                              ),
                                              child: OrderCardWidget(
                                                order: order,
                                                provider: provider,
                                              ),
                                            );
                                          },
                                        )
                                      : SizedBox(
                                          height: 1.sh / 1.8,
                                          child: false
                                              ? SizedBox(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  child: const FittedBox(
                                                    child: CustomLoader(
                                                      color: AppColors.black,
                                                      strokeWidth: 4,
                                                    ),
                                                  ),
                                                )
                                              : const Center(
                                                  child: Text(
                                                      'No Orders Available'),
                                                ),
                                        ),
                                )
                              :
                              // * Offline widget
                              const OfflineWidget();
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
            height: 60.h,
            isTopBlur: true,
          ),
          BottomBlurOnPage(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
