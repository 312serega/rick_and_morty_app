import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/favorite_search_bar.dart';
import '../widget/main_vm.dart';
import '../widget/user_item.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: const Text('Избранное', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(54), child: FavoriteSearchBar()),
      ),
      backgroundColor: AppColors.colorPrimary,
      body: Consumer<MainVm>(
        builder: (context, vm, child) {
          final favorites = vm.displayFavorites; // получаем список избранного

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'Нет избранных персонажей',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final character = favorites[index];
              return UserItem(
                character: character,
                type: true, // список
                vm: vm,
              );
            },
          );
        },
      ),
    );
  }
}
