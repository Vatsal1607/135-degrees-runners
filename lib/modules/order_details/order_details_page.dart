import 'package:degrees_runners/core/constants/constants.dart';
import 'package:degrees_runners/core/constants/strings.dart';
import 'package:degrees_runners/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:degrees_runners/custom_widgets/loader/custom_loader.dart';
import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_provider.dart';
import 'package:degrees_runners/modules/order_details/order_details_provider.dart';
import 'package:degrees_runners/modules/order_details/widgets/item_details_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/constants/keys.dart';
import '../../core/utils/utils.dart';
import '../../custom_widgets/custom_confirm_dialog.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../routes/routes.dart';
import '../../services/local/shared_preferences_service.dart';
import '../bottom_bar/orders/order_provider.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final orderType = arguments?['orderType'] ?? '';
    final orderId = arguments?['orderId'] ?? '';
    final acceptedOrder = arguments?['acceptedOrder'] ?? '';
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final acceptedOrderProvider =
        Provider.of<AcceptedOrderProvider>(context, listen: false);
    final provider = Provider.of<OrderDetailsProvider>(context, listen: false);
    // ! Emit & listen OrderDetails
    provider.emitAndListenOrderDetails(
      orderProvider.socketService,
      orderId.toString(),
    );

    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Order Details',
        isAction: orderType == 'accepted' ? true : false,
        orderType: orderType,
      ),
      body: Consumer<OrderDetailsProvider>(
        builder: (context, _, child) => provider.isLoading
            ? const Center(child: CustomLoader(height: 50, width: 50))
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: getColorOrderDetails(
                    orderType: orderType,
                    ordersColor: AppColors.grey,
                    acceptedOrderColor: AppColors.black,
                    historyOrderColor: AppColors.black,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // * Top content
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ORDER ID ',
                                style: GoogleFonts.publicSans(
                                  fontSize: 12.sp,
                                  color: AppColors.doveGrey,
                                ),
                              ),
                              Consumer<OrderDetailsProvider>(
                                builder: (context, _, child) => Text(
                                  '${provider.orderDetailsData?.orderIds ?? ''} ',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.doveGrey,
                                  ),
                                ),
                              ),
                              Text(
                                orderType == 'accepted'
                                    ? 'ACCEPTED ON '
                                    : orderType == 'history'
                                        ? 'PICKED ON '
                                        : 'RECEIVED ON ',
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
                              Consumer<OrderDetailsProvider>(
                                builder: (context, _, child) => Text(
                                  // '9:51 AM',
                                  Utils.formatTime(provider
                                          .orderDetailsData?.createdAt
                                          .toString() ??
                                      ''),
                                  style: GoogleFonts.publicSans(
                                    fontSize: 12.sp,
                                    color: getColorOrderDetails(
                                      orderType: orderType,
                                      ordersColor: AppColors.black,
                                      acceptedOrderColor: AppColors.seaShell,
                                      historyOrderColor: AppColors.seaShell,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer<OrderDetailsProvider>(
                            builder: (context, _, child) => ItemDetailsTable(
                              orderType: orderType,
                              orderDetailsData: provider.orderDetailsData,
                            ),
                          ),
                        ],
                      ),
                      // * Bottom content
                      Consumer<OrderDetailsProvider>(
                        builder: (context, _, child) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // * Modify Order widget
                              if (orderType == 'history')
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 8.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.seaShell,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SvgIcon(
                                          icon: IconStrings.modifyOrder),
                                      SizedBox(width: 5.5.h),
                                      Text(
                                        'modify order'.toUpperCase(),
                                        style: GoogleFonts.publicSans(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // *
                              SizedBox(height: 10.h),
                              Text(
                                'Deliver To,',
                                style: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  color: getColorOrderDetails(
                                    orderType: orderType,
                                    acceptedOrderColor: AppColors.grey,
                                    historyOrderColor: AppColors.grey,
                                    ordersColor:
                                        AppColors.black.withOpacity(.5),
                                  ),
                                ),
                              ),
                              Text(
                                ((provider.orderDetailsData?.businessName ??
                                        ('${provider.orderDetailsData?.userFirstName ?? ''} ${provider.orderDetailsData?.userLastName ?? ''}')
                                            .trim())
                                    .toUpperCase()),
                                style: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: getColorOrderDetails(
                                    orderType: orderType,
                                    acceptedOrderColor: AppColors.seaShell,
                                    historyOrderColor: AppColors.seaShell,
                                    ordersColor: AppColors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Address:',
                                style: GoogleFonts.publicSans(
                                  fontSize: 12.sp,
                                  color: getColorOrderDetails(
                                    orderType: orderType,
                                    acceptedOrderColor: AppColors.grey,
                                    historyOrderColor: AppColors.grey,
                                    ordersColor:
                                        AppColors.black.withOpacity(.5),
                                  ),
                                ),
                              ),
                              Text(
                                '${provider.orderDetailsData?.deliveryAddress}',
                                style: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: getColorOrderDetails(
                                    orderType: orderType,
                                    ordersColor: AppColors.black,
                                    acceptedOrderColor: AppColors.seaShell,
                                    historyOrderColor: AppColors.seaShell,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              if (orderType != 'history')
                                CustomButton(
                                  height: 48.h,
                                  onTap: () {
                                    if (orderType == 'orders') {
                                      // * onTap orderType 'orders'
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomConfirmDialog(
                                          context: context,
                                          title: 'confirm',
                                          subTitle:
                                              'Are You Sure You Want To Accept Order?',
                                          yesBtnText: 'ACCEPT',
                                          onTapCancel: () =>
                                              Navigator.pop(context),
                                          onTapYes: () {
                                            //! Emit the 'orderAccept' event
                                            orderProvider.socketService
                                                .emitEvent(
                                                    SocketEvents.orderAccept, {
                                              'deliveryBoyId':
                                                  sharedPrefsService.getString(
                                                      SharedPrefsKeys.userId),
                                              'orderId': arguments?['orderId'],
                                            });
                                            Navigator.popUntil(context,
                                                (route) {
                                              // Keep popping until the condition is met
                                              return route.settings.name ==
                                                  Routes.bottomBar;
                                            });
                                          },
                                        ),
                                      );
                                    } else if (orderType == 'accepted' &&
                                        acceptedOrder?.deliveryStartTime ==
                                            null) {
                                      // * onTap orderType 'accepted' BTN: PICKED UP
                                      acceptedOrder!.pickupStartTime == null
                                          ? customSnackBar(
                                              context: context,
                                              message:
                                                  'Order Is Not Prepared Yet')
                                          : showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomConfirmDialog(
                                                context: context,
                                                title: 'confirm',
                                                subTitle:
                                                    'Confirm That You Have Successfully Picked Up The Order!',
                                                yesBtnText: 'PICKED UP',
                                                yesBgColor: AppColors.black,
                                                onTapCancel: () =>
                                                    Navigator.pop(context),
                                                onTapYes: () async {
                                                  //* Picked up API - end
                                                  await acceptedOrderProvider
                                                      .pickupTime(
                                                    context: context,
                                                    orderId: orderId,
                                                    // orderId: acceptedOrder?.deliveryStartTime ?? '',
                                                    type: 'end',
                                                  );
                                                  //* API delivery-time 'start'
                                                  await acceptedOrderProvider
                                                      .deliveryTime(
                                                    context: context,
                                                    orderId: orderId,
                                                    type: 'start',
                                                  )
                                                      .then((isSuccess) {
                                                    if (isSuccess == true) {
                                                      Navigator.popUntil(
                                                          context, (route) {
                                                        // Keep popping until the condition is met
                                                        return route.settings
                                                                .name ==
                                                            Routes.bottomBar;
                                                      });
                                                    }
                                                  });
                                                },
                                              ),
                                            );
                                    } else if (orderType == 'accepted' &&
                                        acceptedOrder?.deliveryStartTime !=
                                            null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            Consumer<AcceptedOrderProvider>(
                                          builder: (context, _, child) =>
                                              CustomConfirmDialog(
                                            context: context,
                                            title: 'confirm',
                                            subTitle:
                                                'Confirm That You Have Successfully Delivered The Order!',
                                            yesBtnText: 'DELIVERED',
                                            isLoading: acceptedOrderProvider
                                                .isDeliveryTimeLoading,
                                            yesBgColor: AppColors.green,
                                            onTapCancel: () =>
                                                Navigator.pop(context),
                                            onTapYes: () async {
                                              //* API delivery-time 'end'
                                              await acceptedOrderProvider
                                                  .deliveryTime(
                                                context: context,
                                                orderId:
                                                    acceptedOrder?.orderId ??
                                                        '',
                                                type: 'end',
                                              )
                                                  .then((isSuccess) {
                                                if (isSuccess == true) {
                                                  //* API call
                                                  acceptedOrderProvider
                                                      .orderInvoiceGenerate(
                                                    acceptedOrder?.orderId ??
                                                        '',
                                                  );
                                                  Navigator.popUntil(context,
                                                      (route) {
                                                    // Keep popping until the condition is met
                                                    return route
                                                            .settings.name ==
                                                        Routes.bottomBar;
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    } else if (orderType == 'history') {
                                      // * onTap orderType 'history'
                                    }
                                  },
                                  bgColor: orderType == 'accepted' &&
                                          acceptedOrder?.deliveryStartTime ==
                                              null
                                      ? AppColors.seaShell
                                      : orderType == 'accepted'
                                          ? AppColors.green
                                          : AppColors.black,
                                  // bgColor: getColorOrderDetails(
                                  //   orderType: orderType,
                                  //   ordersColor: AppColors.black,
                                  //   acceptedOrderColor: AppColors.seaShell,
                                  //   historyOrderColor: AppColors.green,
                                  // ),
                                  text: orderType == 'accepted' &&
                                          (acceptedOrder?.deliveryStartTime ==
                                              null)
                                      ? 'pickup'
                                      : orderType == 'accepted'
                                          ? 'deliver'
                                          : 'ACCEPT',
                                  textColor: orderType == 'accepted' &&
                                          acceptedOrder?.deliveryStartTime ==
                                              null
                                      ? AppColors.black
                                      : AppColors.seaShell,
                                  // textColor: getColorOrderDetails(
                                  //   orderType: orderType,
                                  //   ordersColor: AppColors.seaShell,
                                  //   acceptedOrderColor: AppColors.black,
                                  //   historyOrderColor: AppColors.seaShell,
                                  // ),
                                  // text: orderType == 'accepted'
                                  //     ? 'PICKUP'
                                  //     : orderType == 'history'
                                  //         ? 'DELIVER'
                                  //         : 'ACCEPT',
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
