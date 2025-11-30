import 'package:calculator/themes/app_colors.dart';
import 'package:calculator/widgets/calc_button.dart';
import 'package:flutter/material.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  const ButtonGrid({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "AC",
      "C",
      "%",
      "÷",
      "7",
      "8",
      "9",
      "×",
      "4",
      "5",
      "6",
      "-",
      "1",
      "2",
      "3",
      "+",
      "±",
      "0",
      ".",
      "=",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final lable = buttons[index];
        final colorButton = lable == "="
            ? AppColors.lightEqil
            : int.tryParse(lable) != null
            ? AppColors.numberButtonColor
            : AppColors.lightPrimary;
        return Calc_Button(
          lable: lable,
          color: colorButton,
          onTap: () => onButtonPressed(lable),
        );
      },
    );
  }
}
