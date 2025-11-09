import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String networkImage;
  final String title;

  MySliverAppBar({
    required this.expandedHeight,
    required this.networkImage,
    required this.title,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Hero(
          tag: networkImage,
          child: Image.network(
            networkImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ).blurred(blur: 4, blurColor: Colors.black, colorOpacity: 0.65),
        ),
        Positioned(
          top: 45,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: Container(
                  width: 146,
                  height: 146,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 8,
                      color: AppColors.colorPrimary,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        networkImage,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
