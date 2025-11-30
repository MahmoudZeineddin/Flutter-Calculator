import 'package:calculator/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Calc_display extends StatelessWidget {
  final String expression;
  final String result;

  const Calc_display({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBackgroundDisplay,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            expression,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            result,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
