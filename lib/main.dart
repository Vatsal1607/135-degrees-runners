import 'package:degrees_runners/modules/auth/otp/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'modules/auth/login/login_provider.dart';
import 'modules/auth/register/register_provider.dart';
import 'modules/bottom_bar/bottom_bar_provider.dart';
import 'modules/bottom_bar/orders/order_provider.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932), // Base screen size (width x height)
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '135 Degrees Runners',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.seaShell,
          ),
          // home: const UnderReviewPage(),
          initialRoute: Routes.initial,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
