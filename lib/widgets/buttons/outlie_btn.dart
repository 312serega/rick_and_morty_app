import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class OutlineBtn extends StatelessWidget {
  OutlineBtn({super.key, required this.text, required this.onTap});
  final String text;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(0),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.colorBlue, width: 1),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.colorBlue,
          fontSize: 16,
          height: 1.42,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
