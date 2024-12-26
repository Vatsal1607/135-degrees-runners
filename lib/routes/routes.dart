import 'package:degrees_runners/modules/auth/otp/otp_page.dart';
import 'package:flutter/material.dart';
import '../modules/auth/auth_selection/auth_selection_page.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/register/register_page.dart';
import '../modules/splash/splash_page.dart';

class Routes {
  static const String initial = '/';
  static const String authSelection = '/authSelection';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    authSelection: (context) => const AuthSelectionPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    otp: (context) => OtpPage(),
  };
}
