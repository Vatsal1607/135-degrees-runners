import 'package:degrees_runners/modules/bottom_bar/history/widgets/history_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../custom_widgets/bottom_blur_on_page.dart';
import '../../../routes/routes.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CustomSliverAppbar(),
              SliverToBoxAdapter(
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.orderDetails,
                        arguments: {
                          'orderType': 'history',
                        },
                      ),
                      child: const HistoryOrderCardWidget(),
                    );
                  },
                ),
              ),
            ],
          ),
          BottomBlurOnPage(
            height: 65.h,
            isTopBlur: true,
          ),
          BottomBlurOnPage(
            height: 65.h,
          ),
        ],
      ),
    );
  }
}
