import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class CustomRadioBtn extends StatelessWidget {
  CustomRadioBtn({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.onTap,
    required this.index,
  });
  int index;
  final int currentIndex;
  Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 24,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                currentIndex == index ? Icons.radio_button_on : Icons.radio_button_off,
                size: 24.0,
                color: currentIndex == index ? AppColors.colorBlue : AppColors.colorSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              height: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
