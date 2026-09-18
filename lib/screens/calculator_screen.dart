import 'package:calculator_app/widgets/calculator_btn.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/constants/calculator_colors.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String restext = '0';
  String holder = '';
  bool isZero = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    holder,
                    style: TextStyle(
                      color: AppColors.lightGray,
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                  alignment: Alignment.topRight,
                  child: Text(
                    restext,
                    style: isZero
                        ? TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          )
                        : TextStyle(
                            color: AppColors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorBtn(
                                  text: "Ac",
                                  backgroundColor: AppColors.lightGray,
                                  textColor: AppColors.white,
                                  onButtonClick: onAcClick,
                                ),
                                CalculatorBtn(
                                  text: "",
                                  backgroundColor: AppColors.lightGray,
                                  textColor: AppColors.white,
                                  onButtonClick: onRemoveClick,
                                  isIcone: true,
                                ),
                                CalculatorBtn(
                                  text: " / ",
                                  backgroundColor: AppColors.darkBlue,
                                  textColor: AppColors.white,
                                  onButtonClick: onOperatorClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorBtn(
                                  text: "7",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "8",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "9",
                                  onButtonClick: onDigitClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorBtn(
                                  text: "4",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "5",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "6",
                                  onButtonClick: onDigitClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorBtn(
                                  text: "1",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "2",
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: "3",
                                  onButtonClick: onDigitClick,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorBtn(
                                  text: "0",
                                  flex: 2,
                                  onButtonClick: onDigitClick,
                                ),
                                CalculatorBtn(
                                  text: ".",
                                  onButtonClick: onDotClick,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CalculatorBtn(
                            text: " * ",
                            backgroundColor: AppColors.darkBlue,
                            textColor: AppColors.white,
                            flex: 2,
                            onButtonClick: onOperatorClick,
                          ),
                          CalculatorBtn(
                            text: " - ",
                            backgroundColor: AppColors.darkBlue,
                            textColor: AppColors.white,
                            flex: 2,
                            onButtonClick: onOperatorClick,
                          ),
                          CalculatorBtn(
                            text: " + ",
                            backgroundColor: AppColors.darkBlue,
                            textColor: AppColors.white,
                            flex: 3,
                            onButtonClick: onOperatorClick,
                          ),
                          CalculatorBtn(
                            text: "=",
                            backgroundColor: AppColors.lightBlue,
                            textColor: AppColors.white,
                            flex: 3,
                            onButtonClick: onEqualClick,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String lhs = '';
  String rhs = '';
  String operator = '';

  void onEqualClick(String text) {
    rhs = restext;
    if (lhs.isEmpty || rhs.isEmpty) {
      return;
    }
    holder += rhs;
    holder += ' =';
    String result = calculate(lhs, operator, rhs);
    if (result == 'byZero') {
      restext = 'Can\'t divide by zero.';
    } else if (result == 'invalid') {
      restext = 'Invalid format used.';
    } else {
      restext = result;
    }
    lhs = '';
    operator = '';
    setState(() {});
  }

  void onOperatorClick(String clickOperator) {
    if (restext.isEmpty || isZero) {
      return;
    }
    String lastDigit = restext.substring(restext.length - 1);
    if (lastDigit == '.') {
      restext = restext.substring(0, restext.length - 1);
    }
    if (operator.isEmpty) {
      lhs = restext;
    } else {
      rhs = restext;
      lhs = calculate(lhs, operator, rhs);
    }
    if (lhs == 'byZero') {
      restext = 'Can\'t divide by zero.';
    } else if (lhs == 'invalid') {
      restext = 'Invalid format used.';
    } else {
      operator = clickOperator;
      holder = lhs;
      holder += operator;
      restext = '0';
    }
    setState(() {});
  }

  String calculate(String lhs, String operator, String rhs) {
    double num1 = double.parse(lhs);
    double num2 = double.parse(rhs);
    double result = 0.0;
    operator = operator.trim();

    if (operator == '+') {
      result = num1 + num2;
    } else if (operator == '-') {
      result = num1 - num2;
    } else if (operator == '*') {
      result = num1 * num2;
    } else if (operator == '/') {
      if (num1 != 0 && num2 == 0) {
        isZero = true;
        holder = '';
        return restext = 'byZero';
      } else if (num1 == 0 && num2 == 0) {
        isZero = true;
        holder = '';
        return restext = 'invalid';
      } else {
        result = num1 / num2;
      }
    }
    return result.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  void onAcClick(String text) {
    isZero = false;
    lhs = '';
    rhs = '';
    operator = '';
    holder = '';
    restext = '0';
    setState(() {});
  }

  void onRemoveClick(String text) {
    if (holder.contains('=')) {
      holder = '';
    }
    if (isZero) {
      onAcClick(text);
    } else {
      restext = restext.substring(0, restext.length - 1);
    }
    if (restext.isEmpty || restext == '-') {
      restext = '0';
    }
    setState(() {});
  }

  void onDigitClick(String text) {
    if (holder.contains('=') || isZero) {
      onAcClick(text);
    }
    if (restext == '0') {
      restext = text;
    } else {
      restext += text;
    }
    setState(() {});
  }

  void onDotClick(String text) {
    if (restext.contains(text)) {
      return;
    }
    restext += text;
    setState(() {});
  }
}
