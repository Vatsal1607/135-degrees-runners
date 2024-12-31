import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants/constants.dart';

class ItemDetailsValue extends StatelessWidget {
  final String items;
  final String quantity;
  final String amount;
  final String orderType;
  const ItemDetailsValue({
    super.key,
    required this.items,
    required this.quantity,
    required this.amount,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              items,
              style: GoogleFonts.publicSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: getColorOrderDetails(
                  orderType: orderType,
                  ordersColor: AppColors.black,
                  acceptedOrderColor: AppColors.seaShell,
                  historyOrderColor: AppColors.seaShell,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              quantity,
              style: GoogleFonts.publicSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: getColorOrderDetails(
                  orderType: orderType,
                  ordersColor: AppColors.black,
                  acceptedOrderColor: AppColors.seaShell,
                  historyOrderColor: AppColors.seaShell,
                ),
              ),
            ),
          ),
        ),
        // Perks Column: Align Right
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              amount,
              style: GoogleFonts.publicSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: getColorOrderDetails(
                  orderType: orderType,
                  ordersColor: AppColors.black,
                  acceptedOrderColor: AppColors.seaShell,
                  historyOrderColor: AppColors.seaShell,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
