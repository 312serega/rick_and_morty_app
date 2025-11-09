import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/svgs_src.dart';
import 'favorite_list_tab/favorite_list_tab.dart';
import 'character_list_tab/character_list_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<Widget> tabsScreen = <Widget>[CharacterList(), const FavoriteListScreen()];
  int _activeTab = 0;
  void onSelectTsb(int index) {
    if (_activeTab == index) return;
    setState(() {
      _activeTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGray,
      body: tabsScreen[_activeTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.colorGray,
        currentIndex: _activeTab,
        selectedItemColor: AppColors.colorSuccess,
        unselectedItemColor: const Color(0xff5B6975),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgsSrc.character,
            activeIcon: SvgsSrc.characterActive,
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: SvgsSrc.favorite,
            activeIcon: SvgsSrc.favoriteActive,
            label: 'Избранное',
          ),
        ],
        onTap: onSelectTsb,
      ),
    );
  }
}
