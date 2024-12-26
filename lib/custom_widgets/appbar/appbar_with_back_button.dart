import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;

  const AppBarWithBackButton({
    super.key,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back, // Replace with your SvgIcon widget
          color: Colors.black,
          size: 25.w,
        ),
      ),
      centerTitle: false,
      titleSpacing: 0, // Removes extra space
      title: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Text(
          'back'.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
