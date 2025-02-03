import 'dart:math';

import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/models/order_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/utils/utils.dart';

class HistoryOrderCardWidget extends StatelessWidget {
  final OrderHistory? orderHistory;
  const HistoryOrderCardWidget({
    super.key,
    this.orderHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'ORDER ID ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: AppColors.seaShell.withOpacity(.8),
                  ),
                ),
                Text(
                  // '12345 ',
                  '${orderHistory?.orderIds} ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
                Text(
                  orderHistory!.deliveryEndTime != null
                      ? 'DELIVERED ON '
                      : 'PREPARING',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
                Text(
                  orderHistory!.deliveryEndTime != null
                      ? Utils.formatTime(
                          orderHistory!.deliveryEndTime.toString())
                      : '',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: AppColors.seaShell,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // * Items details
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero, // imp
              shrinkWrap: true,
              itemCount: min(orderHistory?.items?.length ?? 0, 2),
              itemBuilder: (context, index) {
                return Text(
                  '${orderHistory?.items?[index].quantity} × ${orderHistory?.items?[index].itemName} | Size: ${orderHistory?.items?[index].size?.sizeName?.substring(0, 1)}',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                );
              },
            ),
            if (orderHistory?.items != null &&
                (orderHistory?.items?.length ?? 0) > 2)
              Text(
                '& MORE',
                style: GoogleFonts.publicSans(
                  color: AppColors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  'DELIVERY: ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.seaShell,
                  ),
                ),
                Flexible(
                  child: Text(
                    '${orderHistory?.deliveryAddress}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.seaShell,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomButton(
              height: 55.h,
              onTap: () {},
              isBorder: false,
              bgColor: AppColors.green.withOpacity(.5),
              text: 'delivery  completed',
              textColor: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }
}
