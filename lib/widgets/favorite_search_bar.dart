import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/svgs_src.dart';
import '../screens/favorite_filter_screen/favorite_filter_screen.dart';
import '../screens/main_screen/widget/main_vm.dart';

class FavoriteSearchBar extends StatefulWidget {
  const FavoriteSearchBar({super.key});

  @override
  State<FavoriteSearchBar> createState() => _FavoriteSearchBarState();
}

class _FavoriteSearchBarState extends State<FavoriteSearchBar> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainVm>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.colorGray,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              SvgPicture.asset(SvgsSrc.search),
              const SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: vm.searchControllerFavorite,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    hintText: 'Найти персонажа',
                    hintStyle: const TextStyle(
                      color: AppColors.colorSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onChanged: (value) {
                    vm.updateSearch(value, favorite: true);
                    vm.updateStat();
                  },
                ),
              ),
              const SizedBox(width: 10),
              const SizedBox(
                height: 49,
                child: VerticalDivider(
                  color: AppColors.colorSecondary,
                  indent: 12,
                  endIndent: 12,
                  width: 1,
                ),
              ),
              // кнопка переключения вида (List/Grid)
              const SizedBox(width: 10),
              SizedBox(
                width: 24,
                height: 24,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoriteFilterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.colorGray,
                    padding: EdgeInsets.zero,
                  ),
                  child: SvgPicture.asset(SvgsSrc.filter),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
