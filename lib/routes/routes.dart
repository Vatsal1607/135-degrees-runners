import 'package:degrees_runners/modules/auth/otp/otp_page.dart';
import 'package:degrees_runners/modules/order_details/order_details_page.dart';
import 'package:degrees_runners/modules/under_review/under_review.dart';
import 'package:flutter/material.dart';
import '../modules/auth/auth_selection/auth_selection_page.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/register/register_page.dart';
import '../modules/bottom_bar/accepted/accepted_order_details/accepted_order_details.dart';
import '../modules/bottom_bar/bottom_bar_page.dart';
import '../modules/splash/splash_page.dart';

class Routes {
  static const String initial = '/';
  static const String authSelection = '/authSelection';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String underReview = '/underReview';
  static const String bottomBar = '/bottomBar';
  static const String orderDetails = '/orderDetails';
  // static const String acceptedOrderDetails = '/acceptedOrderDetails';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    authSelection: (context) => const AuthSelectionPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    otp: (context) => OtpPage(),
    underReview: (context) => const UnderReviewPage(),
    bottomBar: (context) => const BottomBarPage(),
    orderDetails: (context) => OrderDetailsPage(),
    // acceptedOrderDetails: (context) => const AcceptedOrderDetailsPage(),
  };
}
