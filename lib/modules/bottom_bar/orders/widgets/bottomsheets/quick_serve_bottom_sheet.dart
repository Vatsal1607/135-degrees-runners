import 'package:degrees_runners/custom_widgets/custom_textfield.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/widgets/bottomsheets/payment_method_bottom_sheet.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../custom_widgets/buttons/custom_button_with_arrow.dart';
import '../../../../../custom_widgets/svg_icons.dart';

TextEditingController nameOrCompanyController = TextEditingController();
TextEditingController mobileController = TextEditingController();

void quickServeBottomSheeet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.seaShell,
    builder: (context) {
      // final authEmpProvider =
      //     Provider.of<AuthorizedEmpProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h, left: 32.w, right: 32.w),
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'QUICK SERVE',
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hint: 'Enter Your/Company Name',
                    prefixIcon: IconStrings.person,
                    controller: nameOrCompanyController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hint: 'Enter Mobile Number',
                    prefixIcon: IconStrings.person,
                    controller: mobileController,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'SELECT ITEMS TO SERVE',
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductWidget(
                        image: ImageStrings.masalaTea2,
                        name: 'Masala tea',
                      ),
                      ProductWidget(
                        image: ImageStrings.masalaTea2,
                        name: 'Masala tea',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomButtonWithArrow(
                    isMargin: false,
                    onTap: () {
                      debugPrint('PROCEED TO ACCEPT pressed');
                      Navigator.pop(context);
                      paymentMethodBottomSheeet(context: context);
                    },
                    text: 'PROCEED TO ACCEPT ₹ 20',
                  ),
                  SizedBox(height: 18.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
