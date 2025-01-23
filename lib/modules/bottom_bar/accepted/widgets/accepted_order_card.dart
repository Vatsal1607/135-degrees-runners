import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../custom_widgets/circular_progress_with_timer.dart';
import '../../../../custom_widgets/custom_confirm_dialog.dart';
import '../../../../models/socket_accepted_order_model.dart';
import '../controllers/timer_provider.dart';

class AcceptedOrderCardWidget extends StatelessWidget {
  final AcceptedOrderModel? acceptedOrder;
  final AcceptedOrderProvider provider;
  // final String time;
  final TimerProvider? timerProvider;
  final int index;
  const AcceptedOrderCardWidget({
    super.key,
    this.acceptedOrder,
    required this.provider,
    // required this.time,
    required this.timerProvider,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AcceptedOrderProvider>(context, listen: false);
    // provider.startPickupTimer(); //!
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
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.doveGrey,
                      ),
                    ),
                    Text(
                      acceptedOrder!.pickupStartTime != null
                          ? 'PICKED ON '
                          : 'PREPARING',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seaShell,
                      ),
                    ),
                    Text(
                      acceptedOrder!.pickupStartTime != null
                          ? Utils.formatTime(
                              acceptedOrder!.pickupStartTime.toString())
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
                    if (acceptedOrder?.deliveryStartTime == null) {
                      // * BTN: Pickup
                      showDialog(
                        context: context,
                        builder: (context) => Consumer<AcceptedOrderProvider>(
                          builder: (context, _, child) => CustomConfirmDialog(
                            context: context,
                            title: 'confirm',
                            subTitle:
                                'Confirm That You Have Successfully Picked Up The Order!',
                            yesBtnText: 'PICKED UP',
                            isLoading: provider.isLoading,
                            yesBgColor: AppColors.green,
                            onTapCancel: () => Navigator.pop(context),
                            onTapYes: () async {
                              //* Picked up API - end
                              await provider.pickupTime(
                                context: context,
                                orderId: acceptedOrder?.orderId ?? '',
                                // orderId: acceptedOrder?.deliveryStartTime ?? '',
                                type: 'end',
                              );
                              //* API delivery-time 'start'
                              await provider.deliveryTime(
                                context: context,
                                orderId: acceptedOrder?.orderId ?? '',
                                type: 'start',
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      // * onTap orderType 'accepted' // BTN: deliver
                      showDialog(
                        context: context,
                        builder: (context) => Consumer<AcceptedOrderProvider>(
                          builder: (context, _, child) => CustomConfirmDialog(
                            context: context,
                            title: 'confirm',
                            subTitle:
                                'Confirm That You Have Successfully Delivered The Order!',
                            yesBtnText: 'DELIVERED',
                            isLoading: provider.isDeliveryTimeLoading,
                            yesBgColor: AppColors.green,
                            onTapCancel: () => Navigator.pop(context),
                            onTapYes: () async {
                              //* API delivery-time 'end'
                              await provider.deliveryTime(
                                context: context,
                                orderId: acceptedOrder?.orderId ?? '',
                                type: 'end',
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  bgColor: acceptedOrder?.deliveryStartTime == null
                      ? AppColors.seaShell
                      : AppColors.green,
                  text: acceptedOrder?.deliveryStartTime == null
                      ? 'pickup'
                      : 'deliver',
                  textColor: acceptedOrder?.deliveryStartTime == null
                      ? AppColors.black
                      : AppColors.seaShell,
                ),
              ],
            ),
          ),
        ),
        // * Timer indicator
        Positioned(
          top: 25.h,
          right: 20.w,
          child: Consumer<TimerProvider>(
            builder: (context, _, child) {
              // Note: Infinity timer
              final duration = timerProvider?.duration ?? const Duration();
              debugPrint('Duration from Consumer: $duration');
              final minutes =
                  (duration.inSeconds ~/ 60).toString().padLeft(2, '0');
              final seconds =
                  (duration.inSeconds % 60).toString().padLeft(2, '0');
              //*Note: Start timer using: timerController.start();
              return CircularProgressWithTimer(
                // time: '$minutes:$seconds', //* Infinity timer
                time:
                    '${provider.formatTime(provider.pickUpRemainingSeconds)}', //* Picked up Timer
                valueColor: AppColors.grey,
                bgColor: AppColors.grey,
              );
            },
          ),
        ),
      ],
    );
  }
}
