import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/svg_icons.dart';
import '../../../routes/routes.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final String accountType =
    //     context.read<LocationSelectionProvider>().accountType ?? '';
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't by the keyboard
      // backgroundColor: accountType != '' && accountType == 'business'
      //     ? AppColors.primaryColor
      //     : accountType != '' && accountType == 'personal'
      //         ? AppColors.darkGreenGrey
      //         : AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const SvgIcon(
            icon: IconStrings.arrowBack,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0, // Removes extra space
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'back'.toUpperCase(),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Form(
        key: provider.formKey,
        child: Stack(
          children: [
            Image.asset(
              width: 1.sw,
              height: 1.sh,
              ImageStrings.doodles,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 100.h,
                  left: 34.w,
                  right: 34.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.publicSans(
                        fontSize: 40.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter your mobile number to get otp.'.toUpperCase(),
                      style: GoogleFonts.publicSans(
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country Code Widget
                        Container(
                          height: 52.h,
                          width: 52.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.5.w,
                              color: AppColors.black,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 4.h),
                          child: Center(
                            child: Text(
                              '+91',
                              style: GoogleFonts.publicSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 11.w),
                        // Mobile Number Text Field
                        Expanded(
                          child: Consumer<LoginProvider>(
                            builder: (context, provider, child) =>
                                TextFormField(
                              focusNode: provider.mobilenumberFocusNode,
                              controller: provider.phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: provider.validateMobileNumber,
                              onChanged: provider.onChangePersonalNumber,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                errorStyle:
                                    const TextStyle(color: AppColors.black),
                                hintText: 'Enter mobile number',
                                errorText: provider.mobileErrorText,
                                hintStyle: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 70.h,
                  left: 34.w,
                  right: 34.w,
                ),
                child: Consumer<LoginProvider>(
                  builder: (context, _, child) => CustomButton(
                    height: 50.h,
                    isLoading: provider.isLoading,
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.otp);
                      if (provider.formKey.currentState!.validate()) {
                        debugPrint('Form is valid');
                        provider.userLogin(context); // * Api call
                      } else {
                        debugPrint('Form is not valid');
                      }
                    },
                    text: 'GET OTP',
                    bgColor: AppColors.black,
                    textColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
