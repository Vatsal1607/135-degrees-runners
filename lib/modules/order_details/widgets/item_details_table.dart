import 'package:degrees_runners/models/order_details_model.dart';
import 'package:degrees_runners/modules/order_details/order_details_provider.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/constants.dart';
import 'item_details_value.dart';

class ItemDetailsTable extends StatelessWidget {
  final String orderType;
  final OrderDetailsData? orderDetailsData;
  const ItemDetailsTable({
    super.key,
    required this.orderType,
    this.orderDetailsData,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h),
        // * Table headers
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
          itemCount: orderDetailsData?.items?.length ?? 0,
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
            final items = orderDetailsData?.items?[index];
            return ItemDetailsValue(
              orderType: orderType,
              items:
                  '${items?.itemName} (${items?.size?.sizeName?.substring(0, 1)})',
              quantity: '${items?.quantity}',
              amount: '₹ ${items?.price}',
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
                    '${provider.totalQuantity}',
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
                    '₹ ${orderDetailsData?.totalAmount}',
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
