import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/constants.dart';
import 'item_details_value.dart';

class ItemDetailsTable extends StatelessWidget {
  final String orderType;
  const ItemDetailsTable({
    super.key,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h),
        // * New table headers
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "ITEMS",
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: getColorOrderDetails(
                      orderType: orderType,
                      ordersColor: AppColors.black,
                      acceptedOrderColor: AppColors.seaShell,
                      historyOrderColor: AppColors.seaShell,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "QUANTITY",
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorOrderDetails(
                        orderType: orderType,
                        ordersColor: AppColors.black,
                        acceptedOrderColor: AppColors.seaShell,
                        historyOrderColor: AppColors.seaShell,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "AMOUNT",
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorOrderDetails(
                        orderType: orderType,
                        ordersColor: AppColors.black,
                        acceptedOrderColor: AppColors.seaShell,
                        historyOrderColor: AppColors.seaShell,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        // * List Items
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 3,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          separatorBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 12.h),
              DottedDashedLine(
                dashWidth: 10.w,
                height: 16.h,
                axis: Axis.horizontal,
                width: double.infinity,
                dashColor: getColorOrderDetails(
                  orderType: orderType,
                  ordersColor: AppColors.black,
                  acceptedOrderColor: AppColors.seaShell,
                  historyOrderColor: AppColors.seaShell,
                ),
              ),
            ],
          ),
          itemBuilder: (context, index) {
            return ItemDetailsValue(
              orderType: orderType,
              items: 'MASALA TEA',
              quantity: '1',
              amount: '₹ 50',
            );
          },
        ),
        SizedBox(height: 10.h),

        // * TOTAL
        Container(
          // color: AppColors.black,
          color: getColorOrderDetails(
            orderType: orderType,
            ordersColor: AppColors.black,
            acceptedOrderColor: AppColors.green,
            historyOrderColor: AppColors.green,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'TOTAL',
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '4',
                    style: GoogleFonts.publicSans(
                      color: AppColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '₹ 80',
                    style: GoogleFonts.publicSans(
                      color: AppColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
