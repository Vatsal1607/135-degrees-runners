import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/app_colors.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final Color color;
  const SvgIcon({
    super.key,
    required this.icon,
    this.color = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn, // Use srcIn to apply color
      ),
      fit: BoxFit.scaleDown,
    );
  }
}
