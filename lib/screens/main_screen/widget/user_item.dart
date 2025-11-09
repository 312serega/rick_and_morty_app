import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/user_screen/user_screen.dart';

import '../../../model/users_model.dart';
import '../../../resources/app_colors.dart';
import 'main_vm.dart';

// ignore: must_be_immutable
class UserItem extends StatelessWidget {
  final Results character;
  final bool type; // true = list, false = grid
  final MainVm vm;

  const UserItem({super.key, required this.character, required this.type, required this.vm});

  String cropText(String text, [int limit = 16]) {
    if (text.length > limit) return '${text.substring(0, limit)}...';
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => UserScreen(id: character.id!)));
      },
      child: type ? ListItem(character: character, vm: vm) : GridItem(character: character, vm: vm),
    );
  }
}

class ListItem extends StatelessWidget {
  final Results character;
  final MainVm vm;

  const ListItem({super.key, required this.character, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: character.image ?? character.id.toString(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
              imageUrl: character.image ?? '',
              errorWidget: (context, url, error) => const Icon(Icons.error),
              progressIndicatorBuilder: (context, url, progress) =>
                  CircularProgressIndicator(value: progress.progress),
              height: 74,
              width: 74,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (character.status ?? '').toUpperCase(),
              style: TextStyle(
                color: character.status == 'Alive' ? AppColors.colorSuccess : Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
            Text(
              character.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            Text(
              '${character.species ?? ''} • ${character.gender ?? ''}',
              style: const TextStyle(
                color: AppColors.colorSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            vm.isFavorite(character.id!) ? Icons.star_rounded : Icons.star_outline_rounded,
            color: vm.isFavorite(character.id!) ? const Color(0xFFE6FF01) : Colors.grey,
          ),
          onPressed: () => vm.toggleFavorite(character),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final Results character;
  final MainVm vm;

  const GridItem({super.key, required this.character, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: IconButton(
              icon: Icon(
                vm.isFavorite(character.id!) ? Icons.star_rounded : Icons.star_outline_rounded,
                color: vm.isFavorite(character.id!) ? const Color(0xFFE6FF01) : Colors.grey,
              ),
              onPressed: () => vm.toggleFavorite(character),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: character.image ?? character.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: character.image ?? '',
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(value: progress.progress),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  (character.status ?? '').toUpperCase(),
                  style: TextStyle(
                    color: character.status == 'Alive' ? AppColors.colorSuccess : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  character.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${character.species ?? ''} • ${character.gender ?? ''}',
                  style: const TextStyle(
                    color: AppColors.colorSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
