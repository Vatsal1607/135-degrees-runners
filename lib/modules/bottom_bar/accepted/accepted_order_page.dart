import 'package:degrees_runners/modules/bottom_bar/orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../routes/routes.dart';
import 'accepted_order_provider.dart';
import 'widgets/accepted_order_card.dart';

class AcceptedOrderPage extends StatelessWidget {
  const AcceptedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final acceptedProvider =
        Provider.of<AcceptedOrderProvider>(context, listen: false);
    acceptedProvider
        .emitAndListenAcceptedOrderList(orderProvider.socketService);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: Consumer<AcceptedOrderProvider>(
              builder: (context, _, child) =>
                  acceptedProvider.acceptedOrderList != null &&
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
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.orderDetails,
                                arguments: {
                                  'orderType': 'accepted',
                                },
                              ),
                              child: AcceptedOrderCardWidget(
                                provider: acceptedProvider,
                                acceptedOrder: acceptedOrder,
                                // time: acceptedProvider.formatTime(
                                //     acceptedProvider.pickUpRemainingSeconds),
                                time: acceptedOrder?.pickupStartTime == null
                                    ? acceptedProvider.formatTime(
                                        acceptedProvider.infinitySeconds)
                                    : '',
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No Orders Available'),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
