import 'package:degrees_runners/modules/bottom_bar/orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../custom_widgets/loader/custom_loader.dart';
import '../../../models/timer_model.dart';
import '../../../routes/routes.dart';
import 'accepted_order_provider.dart';
import 'controllers/timer_provider.dart';
import 'widgets/accepted_order_card.dart';

class AcceptedOrderPage extends StatefulWidget {
  const AcceptedOrderPage({super.key});

  @override
  State<AcceptedOrderPage> createState() => _AcceptedOrderPageState();
}

class _AcceptedOrderPageState extends State<AcceptedOrderPage> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final acceptedProvider =
        Provider.of<AcceptedOrderProvider>(context, listen: false);
    // ! Emit & listen AcceptedOrderList
    acceptedProvider
        .emitAndListenAcceptedOrderList(orderProvider.socketService);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: Consumer<AcceptedOrderProvider>(
              builder: (context, _, child) => acceptedProvider
                              .acceptedOrderList !=
                          null &&
                      acceptedProvider.acceptedOrderList!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 20.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          acceptedProvider.acceptedOrderList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final acceptedOrder =
                            acceptedProvider.acceptedOrderList?[index];
                        final timerProvider =
                            acceptedProvider.timerMap.putIfAbsent(
                          acceptedOrder?.orderId ?? '',
                          () => TimerProvider()..startInfinityTimer(),
                        );
                        return GestureDetector(
                          onTap: () {
                            TimerModel? timerModel;
                            String timerType = 'infinity'; // Default timer type

                            if (acceptedOrder!.pickupStartTime != null &&
                                acceptedOrder!.deliveryStartTime == null) {
                              timerModel =
                                  timerProvider?.getPickedUpTimer(index);
                              timerType = 'picked_up';
                            } else if (acceptedOrder!.deliveryStartTime !=
                                null) {
                              timerModel =
                                  timerProvider?.getDeliveryTimer(index);
                              timerType = 'delivery';
                            }

                            Navigator.pushNamed(
                              context,
                              Routes.orderDetails,
                              arguments: {
                                'orderType': 'accepted',
                                'orderId': acceptedOrder?.orderId ?? '',
                                'acceptedOrder': acceptedOrder,
                                'timerType':
                                    timerType, // Pass which timer to show
                                'time': timerModel != null
                                    ? timerProvider!
                                        .formatTime(timerModel.remainingSeconds)
                                    : '00:00',
                                'progress': timerModel?.progress ?? 0.0,
                                'valueColor': timerModel?.isCountingUp == true
                                    ? AppColors.red
                                    : AppColors.green,
                                'bgColor': timerModel?.isCountingUp == true
                                    ? AppColors.red
                                    : AppColors.grey,
                              },
                            );
                          },
                          child: AcceptedOrderCardWidget(
                            provider: acceptedProvider,
                            acceptedOrder: acceptedOrder,
                            timerProvider: timerProvider,
                            index: index,
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      height: 1.sh / 1.3,
                      child: false
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: const CustomLoader(
                                  color: AppColors.black,
                                  strokeWidth: 6,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('No Accepted Orders Available'),
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
