import 'package:flutter/material.dart';

import '../constants/calculator_colors.dart';

typedef OnButtonClick = void Function(String);

class CalculatorBtn extends StatelessWidget {
  String text;
  Color backgroundColor;
  Color textColor;
  int flex;
  Function onButtonClick;
  bool isIcone;

  CalculatorBtn({
    required this.text,
    this.backgroundColor = AppColors.gray,
    this.textColor = AppColors.lightBlue,
    this.flex = 1,
    this.isIcone = false,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            onButtonClick(text);
          },
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: isIcone
              ? Icon(Icons.backspace_outlined, color: AppColors.white,)
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
