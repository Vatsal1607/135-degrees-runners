import 'dart:math';

import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/custom_widgets/custom_snackbar.dart';
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
import '../../../../models/timer_model.dart';
import '../controllers/timer_provider.dart';

class AcceptedOrderCardWidget extends StatelessWidget {
  final AcceptedOrderModel? acceptedOrder;
  final AcceptedOrderProvider provider;
  final TimerProvider? timerProvider;
  final int index;
  const AcceptedOrderCardWidget({
    super.key,
    this.acceptedOrder,
    required this.provider,
    required this.timerProvider,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AcceptedOrderProvider>(context, listen: false);
    final timerModel = timerProvider?.getPickedUpTimer(index);
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero, // imp
                  shrinkWrap: true,
                  itemCount:
                      min(acceptedOrder?.orderDetails.items.length ?? 0, 2),
                  itemBuilder: (context, index) {
                    return Text(
                      '${acceptedOrder?.orderDetails.items[index].quantity} × ${acceptedOrder?.orderDetails.items[index].itemName} | Size: ${acceptedOrder?.orderDetails.items[index].size?.sizeName?.substring(0, 1)}',
                      style: GoogleFonts.publicSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seaShell,
                      ),
                    );
                  },
                ),
                if (acceptedOrder?.orderDetails.items != null &&
                    acceptedOrder!.orderDetails.items.length > 2)
                  Text(
                    '& MORE',
                    style: GoogleFonts.publicSans(
                      color: AppColors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                // Text(
                //   '${acceptedOrder?.orderDetails.items[0].quantity} × ${acceptedOrder?.orderDetails.items[0].itemName}',
                //   style: GoogleFonts.publicSans(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.seaShell,
                //   ),
                // ),
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
                Consumer<AcceptedOrderProvider>(
                  builder: (context, _, child) => CustomButton(
                    height: 55.h,
                    onTap: () {
                      if (acceptedOrder?.deliveryStartTime == null) {
                        // * BTN: Pickup
                        acceptedOrder!.pickupStartTime == null
                            ? customSnackBar(
                                context: context,
                                message: 'Order Is Not Prepared Yet')
                            : showDialog(
                                context: context,
                                builder: (context) =>
                                    Consumer<AcceptedOrderProvider>(
                                  builder: (context, _, child) =>
                                      CustomConfirmDialog(
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
                ),
              ],
            ),
          ),
        ),
        // * Infinity Timer indicator (1)
        if (acceptedOrder!.pickupStartTime == null &&
            acceptedOrder!.deliveryStartTime == null)
          Positioned(
            top: 25.h,
            right: 20.w,
            child: Consumer<TimerProvider>(
              builder: (context, _, child) {
                // Note: Infinity timer
                final duration = timerProvider?.duration ?? const Duration();
                // debugPrint('Duration from Consumer: $duration');
                final minutes =
                    (duration.inSeconds ~/ 60).toString().padLeft(2, '0');
                final seconds =
                    (duration.inSeconds % 60).toString().padLeft(2, '0');
                //*Note: Start timer using: timerController.start();
                return CircularProgressWithTimer(
                  time: '$minutes:$seconds', //* Infinity timer
                  valueColor: AppColors.grey,
                  bgColor: AppColors.grey,
                );
              },
            ),
          ),
        // * Picked up Timer indicator (2)
        if (acceptedOrder!.pickupStartTime != null &&
            acceptedOrder!.deliveryStartTime == null)
          Positioned(
            top: 25.h,
            right: 20.w,
            child: Consumer<TimerProvider>(
              builder: (context, _, child) {
                TimerModel? timerModel = timerProvider?.getPickedUpTimer(index);
                String formattedTime = timerModel?.remainingSeconds != null
                    ? timerProvider!.formatTime(timerModel!.remainingSeconds)
                    : '00:00';

                timerProvider?.startPickedUpTimer(index);
                debugPrint('Picked up progress: ${timerModel?.progress}');
                return CircularProgressWithTimer(
                  //* Picked up Timer
                  time: formattedTime,
                  value: timerModel?.progress,
                  valueColor:
                      timerProvider?.getPickedUpTimer(index).isCountingUp ==
                              true
                          ? AppColors.red
                          : AppColors.green,
                  bgColor:
                      timerProvider?.getPickedUpTimer(index).isCountingUp ==
                              true
                          ? AppColors.red
                          : AppColors.green,
                );
              },
            ),
          ),
        // * Delivery Timer indicator (3)
        if (acceptedOrder!.deliveryStartTime != null)
          Positioned(
            top: 25.h,
            right: 20.w,
            child: Consumer<TimerProvider>(
              builder: (context, timerProvider, child) {
                // Get the timer model for the specific index
                TimerModel timerModel = timerProvider.getDeliveryTimer(index);
                // Format the remaining seconds into time format (e.g., mm:ss)
                String formattedTime =
                    timerProvider.formatTime(timerModel.remainingSeconds);
                //* Start delivery timer
                timerProvider.startDeliveryTimer(index);
                return CircularProgressWithTimer(
                  time: formattedTime,
                  value: timerModel.progress,
                  bgColor:
                      timerModel.isCountingUp ? AppColors.red : AppColors.grey,
                  valueColor:
                      timerModel.isCountingUp ? AppColors.red : AppColors.green,
                );
              },
            ),
          ),
      ],
    );
  }
}
