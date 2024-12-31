import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../routes/routes.dart';
import 'widgets/accepted_order_card.dart';

class AcceptedOrderPage extends StatelessWidget {
  const AcceptedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
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
