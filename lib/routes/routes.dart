import 'package:degrees_runners/modules/about_us/about_us_page.dart';
import 'package:degrees_runners/modules/auth/otp/otp_page.dart';
import 'package:degrees_runners/modules/order_details/order_details_page.dart';
import 'package:degrees_runners/modules/profile/profile_page.dart';
import 'package:degrees_runners/modules/under_review/under_review.dart';
import 'package:flutter/material.dart';
import '../modules/auth/auth_selection/auth_selection_page.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/otp/widgets/verify_success_page.dart';
import '../modules/auth/register/register_page.dart';
import '../modules/bottom_bar/bottom_bar_page.dart';
import '../modules/profile/edit_profile/edit_profile_page.dart';
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
  static const String profile = '/profile';
  static const String verifySuccess = '/verifySuccess';
  static const String editProfile = '/editProfilePage';
  static const String aboutUs = '/aboutUs';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    authSelection: (context) => const AuthSelectionPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    otp: (context) => const OtpPage(),
    underReview: (context) => const UnderReviewPage(),
    bottomBar: (context) => const BottomBarPage(),
    orderDetails: (context) => const OrderDetailsPage(),
    profile: (context) => const ProfilePage(),
    verifySuccess: (context) => const VerifySuccessPage(),
    editProfile: (context) => const EditProfilePage(),
    aboutUs: (context) => const AboutUsPage(),
  };
}
