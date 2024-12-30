import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetailsValue extends StatelessWidget {
  final String items;
  final String quantity;
  final String amount;
  const ItemDetailsValue({
    super.key,
    required this.items,
    required this.quantity,
    required this.amount,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
