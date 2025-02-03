import 'package:degrees_runners/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:degrees_runners/custom_widgets/loader/custom_loader.dart';
import 'package:degrees_runners/modules/bottom_bar/history/history_provider.dart';
import 'package:degrees_runners/modules/bottom_bar/history/widgets/history_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../custom_widgets/bottom_blur_on_page.dart';
import '../../../routes/routes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryProvider>().orderHistory(); //* API
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HistoryProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const CustomSliverAppbar(),
              SliverToBoxAdapter(
                child: Consumer<HistoryProvider>(
                  builder: (context, _, child) => provider.isLoading
                      ? const Center(
                          child: CustomLoader(),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 28.w, vertical: 20.h),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.orderHistoryList.length,
                          itemBuilder: (context, index) {
                            final orderHistory =
                                provider.orderHistoryList[index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.orderDetails,
                                arguments: {
                                  'orderType': 'history',
                                  'orderId': orderHistory.sId,
                                },
                              ),
                              child: HistoryOrderCardWidget(
                                orderHistory: orderHistory,
                              ),
                            );
                          },
                        ),
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
