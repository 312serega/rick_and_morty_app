import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.title, required this.subTitle, this.iconName});
  final String title;
  final String subTitle;
  final IconData? iconName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.colorSecondary, fontSize: 12, height: 1.33),
          ),
        ],
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.42),
      ),
      trailing: iconName != null
          ? Icon(iconName, color: Colors.white, size: 14)
          : const SizedBox.shrink(),
    );
  }
}
