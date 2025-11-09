import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    super.key,
    this.value = false,
    required this.onTap,
    required this.title,
    required this.index,
    required this.currentIndex,
  });
  int index;
  final bool value;
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
            width: 18,
            height: 18,
            child: Stack(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? AppColors.colorBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: currentIndex == index ? AppColors.colorBlue : AppColors.colorSecondary,
                      width: 2,
                    ),
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(Icons.check, size: 17.0, color: AppColors.colorPrimary),
                ),
              ],
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
