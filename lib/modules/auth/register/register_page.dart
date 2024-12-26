import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/valdiator.dart';
import '../../../custom_widgets/appbar/appbar_with_back_button.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import 'register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't move by the keyboard
      appBar: const AppBarWithBackButton(),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.doodles,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 80.h,
                left: 34.w,
                right: 34.w,
              ),
              child: Form(
                key: provider.formKey,
                child: SingleChildScrollView(
                  // physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: GoogleFonts.publicSans(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 18.h),
                        CustomTextField(
                          hint: 'Enter Your Name',
                          validator: Validator.validateName,
                          prefixIcon: IconStrings.person,
                          controller: provider.firstNameController,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          hint: 'Enter Your E-Mail Address',
                          validator: Validator.validateName,
                          prefixIcon: IconStrings.mail,
                          controller: provider.lastNameController,
                        ),
                        SizedBox(height: 20.h),
                        // SizedBox(height: 20.h),
                        Consumer<RegisterProvider>(
                          builder: (context, _, child) => CustomTextField(
                            hint: 'Enter Mobile Number',
                            errorText: provider.personalMobileErrorText,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: Validator.validatePhoneNumber,
                            onChanged: provider.onChangePersonalNumber,
                            prefixIcon: IconStrings.phone,
                            controller: provider.personalMobileController,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
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
              child: Consumer<RegisterProvider>(
                builder: (context, rProvider, child) => CustomButton(
                  height: 48.h,
                  // isLoading: rProvider.isLoading,
                  onTap: () {},
                  bgColor: AppColors.black,
                  text: 'submit',
                  textColor: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
