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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.orderDetails,
                    arguments: {
                      'orderType': 'accepted',
                    },
                  ),
                  child: const AcceptedOrderCardWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
