import 'dart:math';

import 'package:degrees_runners/custom_widgets/custom_confirm_dialog.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/utils/utils.dart';
import '../../../../custom_widgets/custom_button.dart';
import '../../../../models/socket_order_list_model.dart';
import '../order_provider.dart';

class OrderCardWidget extends StatelessWidget {
  final SocketOrderModel? order;
  final OrderProvider provider;
  const OrderCardWidget({
    super.key,
    this.order,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    // final acceptedOrderProvider =
    //     Provider.of<AcceptedOrderProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.davyGrey.withOpacity(.34),
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
                    color: AppColors.davyGrey,
                  ),
                ),
                Text(
                  '${order?.orderIds ?? ''} ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.davyGrey,
                  ),
                ),
                Text(
                  'RECEIVED ON ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  // '9:51 AM',
                  Utils.formatTime(order!.createdAt.toString()),
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: AppColors.black,
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
              itemCount: min(order?.items.length ?? 0, 2),
              itemBuilder: (context, index) {
                return Text(
                  '${order?.items[index].quantity} × ${order?.items[index].itemName} | Size: ${order?.items[index].size?.sizeName?.substring(0, 1)}',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            if (order?.items != null && order!.items.length > 2)
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
                    color: AppColors.doveGrey,
                  ),
                ),
                Flexible(
                  child: Text(
                    order?.deliveryAddress ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomButton(
              height: 55.h,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomConfirmDialog(
                    context: context,
                    title: 'confirm',
                    subTitle: 'Are You Sure You Want To Accept Order?',
                    yesBtnText: 'ACCEPT',
                    onTapCancel: () => Navigator.pop(context),
                    onTapYes: () async {
                      // * Emit the 'orderAccept' event
                      provider.socketService
                          .emitEvent(SocketEvents.orderAccept, {
                        'deliveryBoyId': sharedPrefsService
                            .getString(SharedPrefsKeys.userId),
                        'orderId': order?.id,
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              bgColor: AppColors.black,
              text: 'ACCEPT',
            ),
          ],
        ),
      ),
    );
  }
}
