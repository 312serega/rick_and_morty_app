import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';

class MyListTileEpisode extends StatelessWidget {
  const MyListTileEpisode({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconName,
    this.series,
  });
  final String? series;
  final String title;
  final String subTitle;
  final IconData? iconName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://rickandmortyapi.com/api/character/avatar/1.jpeg'),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (series != null)
                  Text(
                    series ?? '',
                    style: const TextStyle(color: Color(0xff22A2BD), fontSize: 10, height: 1.33),
                  ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.33),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: AppColors.colorSecondary,
                    fontSize: 14,
                    height: 1.42,
                  ),
                ),
              ],
            ),
          ),
          if (iconName != null) Icon(iconName, color: Colors.white, size: 14),
        ],
      ),
    );
  }
}
