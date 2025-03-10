import 'package:degrees_runners/modules/auth/otp/otp_provider.dart';
import 'package:degrees_runners/modules/order_delivered/order_delivered_page.dart';
import 'package:degrees_runners/modules/profile/profile_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'modules/auth/login/login_provider.dart';
import 'modules/auth/register/register_provider.dart';
import 'modules/bottom_bar/accepted/accepted_order_provider.dart';
import 'modules/bottom_bar/accepted/controllers/timer_provider.dart';
import 'modules/bottom_bar/bottom_bar_provider.dart';
import 'modules/bottom_bar/history/history_provider.dart';
import 'modules/bottom_bar/orders/order_provider.dart';
import 'modules/order_details/order_details_provider.dart';
import 'modules/profile/edit_profile/edit_profile_provider.dart';
import 'routes/routes.dart';
import 'services/local/shared_preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPrefsService.init(); // * local storage init
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AcceptedOrderProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => OrderDetailsProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
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
          // home: const OrderDeliveredPage(),
          initialRoute: Routes.initial,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
