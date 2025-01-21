import 'package:degrees_runners/custom_widgets/custom_confirm_dialog.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/utils/utils.dart';
import '../../../../custom_widgets/custom_button.dart';
import '../../../../models/socket_order_list_model.dart';
import '../../accepted/accepted_order_provider.dart';
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
    final acceptedOrderProvider =
        Provider.of<AcceptedOrderProvider>(context, listen: false);
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
                    color: AppColors.doveGrey,
                  ),
                ),
                Text(
                  '${order?.orderIds ?? ''} ',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.doveGrey,
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
            // Text(
            //   '1 × MASALA TEA\n2 × HOT COFFEE\n& MORE',
            //   style: GoogleFonts.publicSans(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Text(
              '${order?.items[0].quantity} × ${order?.items[0].itemName}',
              // \n2 × HOT COFFEE\n& MORE',
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
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
                      // //* Picked up API
                      // await acceptedOrderProvider.pickupTime(
                      //   context: context,
                      //   orderId: order?.id ?? '',
                      //   type: 'start',
                      // );
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
