import 'dart:developer';
import 'package:degrees_runners/modules/bottom_bar/accepted/accepted_order_provider.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarProvider extends ChangeNotifier {
  PageController myPage = PageController(initialPage: 0);

  int currentIndex = 0;

  onPageChanged(index, context) {
    currentIndex = index;
    notifyListeners();
    log('Index is $index');

    //* Manage Socket listeners here
    if (index == 0) {
      // Order page
      // final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      // orderProvider.emitAndListenOrderList();
      final acceptedOrderProvider =
          Provider.of<AcceptedOrderProvider>(context, listen: false);
      acceptedOrderProvider.disposeAcceptedOrderListener();
    } else if (index == 1) {
      // Acceptedorder page
      // final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      // orderProvider.disposeOrderListener();
    } else {
      // History
      // final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      // orderProvider.disposeOrderListener();
      final acceptedOrderProvider =
          Provider.of<AcceptedOrderProvider>(context, listen: false);
      acceptedOrderProvider.disposeAcceptedOrderListener();
    }
  }

  // * get dynamic greetings
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning,";
    } else if (hour < 17) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }
}
