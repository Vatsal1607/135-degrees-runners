import 'package:flutter/material.dart';

import '../../../custom_widgets/appbar/custom_sliver_appbar.dart';

class AcceptedOrderPage extends StatelessWidget {
  const AcceptedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Accepted page'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
