import 'package:calculator/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Calc_Button extends StatelessWidget {
  final String lable;
  final Color color;
  final VoidCallback onTap;

  const Calc_Button({
    super.key,
    required this.lable,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          lable,
          style: TextStyle(
            fontSize: 26,
            color: AppColors.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
