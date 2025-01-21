import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../custom_widgets/circular_progress_with_timer.dart';
import '../../../../custom_widgets/custom_confirm_dialog.dart';
import '../../../../models/socket_accepted_order_model.dart';

class AcceptedOrderCardWidget extends StatelessWidget {
  final AcceptedOrderModel? acceptedOrder;
  final AcceptedOrderProvider provider;
  const AcceptedOrderCardWidget({
    super.key,
    this.acceptedOrder,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // * Card widget
        Container(
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
                        color: AppColors.doveGrey,
                      ),
                    ),
                    Text(
                      '${acceptedOrder?.orderDetails.orderIds ?? ''} ',
                      // '',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.doveGrey,
                      ),
                    ),
                    Text(
                      'PICKED ON ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seaShell,
                      ),
                    ),
                    Text(
                      Utils.formatTime(
                          acceptedOrder!.pickupStartTime.toString()),
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
                Text(
                  '${acceptedOrder?.orderDetails.items[0].quantity} × ${acceptedOrder?.orderDetails.items[0].itemName}',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
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
                        '${acceptedOrder?.orderDetails.deliveryAddress}',
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
                  onTap: () {
                    if (acceptedOrder?.pickupStartTime == null) {
                      // * BTN: Pickup
                      showDialog(
                        context: context,
                        builder: (context) => CustomConfirmDialog(
                          context: context,
                          title: 'confirm',
                          subTitle:
                              'Confirm That You Have Successfully Picked Up The Order!',
                          yesBtnText: 'PICKED UP',
                          yesBgColor: AppColors.green,
                          onTapCancel: () => Navigator.pop(context),
                          onTapYes: () {
                            //* Picked up API - end
                            provider.pickupTime(
                              context: context,
                              orderId: acceptedOrder?.orderId ?? '',
                              type: 'end',
                            );
                          },
                        ),
                      );
                    } else {
                      // * onTap orderType 'accepted' // BTN: deliver
                      showDialog(
                        context: context,
                        builder: (context) => CustomConfirmDialog(
                          context: context,
                          title: 'confirm',
                          subTitle:
                              'Confirm That You Have Successfully Delivered The Order!',
                          yesBtnText: 'DELIVERED',
                          yesBgColor: AppColors.green,
                          onTapCancel: () => Navigator.pop(context),
                          onTapYes: () {
                            // Todo call Delivered up event
                          },
                        ),
                      );
                    }
                  },
                  bgColor: acceptedOrder?.pickupStartTime == null
                      ? AppColors.seaShell
                      : AppColors.green,
                  text: acceptedOrder?.pickupStartTime == null
                      ? 'pickup'
                      : 'deliver',
                  textColor: acceptedOrder?.pickupStartTime == null
                      ? AppColors.black
                      : AppColors.seaShell,
                ),
              ],
            ),
          ),
        ),
        // * Timer indicator
        Positioned(
          top: 30.h,
          right: 20.w,
          child: const CircularProgressWithTimer(),
        ),
      ],
    );
  }
}
