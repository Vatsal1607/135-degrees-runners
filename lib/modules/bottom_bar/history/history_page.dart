import 'package:degrees_runners/modules/bottom_bar/history/widgets/history_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return HistoryOrderCardWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
