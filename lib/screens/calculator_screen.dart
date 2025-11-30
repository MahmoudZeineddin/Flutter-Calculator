import 'dart:math';

import 'package:calculator/widgets/button_grid.dart';
import 'package:calculator/widgets/calc_display.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";
  final operators = ["+", "×", "÷", "AC", "C"];
  void onButtonPressed(String value) {
    setState(() {
      if (operators.contains(value) && _expression.isEmpty) {
        return;
      } else if (_expression.isNotEmpty &&
          value == '.' &&
          _expression.contains(RegExp(r'\.\d*$'))) {
        return;
      } else if (value == 'AC') {
        _expression = '';
        _result = '0';
      } else if (value == 'C') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == '=') {
        if (_expression.isEmpty) return;

        try {
          String finalExpression = _expression
              .replaceAll('×', '*')
              .replaceAll('÷', '/');
          Parser parser = Parser();
          Expression exp = parser.parse(finalExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          if (eval == eval.toInt()) {
            _result = eval.toInt().toString();
          } else {
            _result = eval
                .toStringAsFixed(8)
                .replaceAll(RegExp(r'0*$'), '')
                //  احذف كل الأصفار الموجودة في آخر النص
                .replaceAll(RegExp(r'\.$'), '');
            // احذف النقطة إذا كانت في آخر النص
          }
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == '±') {
        if (_expression.isEmpty) return;
        RegExp regExp = RegExp(r'([+\-×÷])?(\-?\d+\.?\d*)$');
        Match? match = regExp.firstMatch(_expression);

        if (match != null) {
          String operator = match.group(1) ?? '';
          String number = match.group(2) ?? '';
          if (operator == '-' && match.start == 0)
          // هدف هذا الشرط إنه يفحص إذا كان الـ "-" هو أول شيء في التعبير
          // يخلي الـ "-" جزء من الرقم مش عملية
          {
            // معناها الـ "-" مش operator، هي جزء من الرقم!
            operator = ''; // خليها فاضية
            number = '-' + number; // ضيف الـ "-" للرقم
          }
          if (operator.isEmpty) {
            if (number.startsWith('-')) {
              number = number.substring(1);
              print('Number: "$number"');
            } else {
              number = '-$number';
            }
            _expression = number;
            return;
          }

          // حالة: يوجد operator → الرقم خلف عملية
          if (number.startsWith('-')) {
            number = number.substring(1);
          } else {
            number = '-$number';
          }

          if (operator == '+') {
            operator = '-';
            number = number.substring(1);
          }

          if (operator == '-' && number.startsWith('-')) {
            number = number.substring(1);
            operator = '+';
          }

          _expression =
              _expression.substring(0, match.start) + operator + number;
        }
      } else if (value == '+') {
        if (_expression.endsWith('-')) {
          _expression = _expression.substring(0, _expression.length - 1);
          _expression += value;
        } else if (_expression.isNotEmpty &&
            operators.contains(_expression[_expression.length - 1]) &&
            operators.contains(value)) {
          return;
        } else {
          _expression += value;
        }
      } else if (value == '-') {
        if (_expression.endsWith('+')) {
          _expression = _expression.substring(0, _expression.length - 1);
          _expression += value;
        } else if (_expression.isNotEmpty &&
            value == (_expression[_expression.length - 1])) {
          return;
        } else {
          _expression += value;
        }
      } else if (value == '0' && _expression == '0') {
        return;
      } else {
        if (_expression.isNotEmpty &&
            operators.contains(_expression[_expression.length - 1]) &&
            operators.contains(value)) {
          return;
        } else {
          _expression += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Calc_display(expression: _expression, result: _result),
              const SizedBox(height: 70),
              Expanded(child: ButtonGrid(onButtonPressed: onButtonPressed)),
            ],
          ),
        ),
      ),
    );
  }
}
