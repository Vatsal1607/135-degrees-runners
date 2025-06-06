import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/app_colors.dart';
import '../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../services/network/api/api_constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(WebViewUrl.aboutUs)); // * About Us Url

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'About Us',
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            )
          : WebViewWidget(controller: webViewController),
    );
  }
}
