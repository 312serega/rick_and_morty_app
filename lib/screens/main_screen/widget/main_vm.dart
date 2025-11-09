import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/users_model.dart';

class MainVm extends ChangeNotifier {
  bool type = true;
  final scrollController = ScrollController();
  var i = 1;
  bool goNext = false;
  int userCount = 0;
  String name = '';

  // ===== Search =====
  String searchValue = '';
  String searchValueFavorite = '';

  TextEditingController searchController = TextEditingController();
  TextEditingController searchControllerFavorite = TextEditingController();

  void updateSearch(String value, {bool favorite = false}) {
    if (favorite) {
      searchValueFavorite = value;
      searchControllerFavorite.text = value;
      _applyFavoriteFilters();
    } else {
      searchValue = value;
      searchController.text = value;
    }
    notifyListeners();
  }

  // ===== Favorites =====
  List<Results> favorites = [];
  static const _favoritesKey = 'favorite_characters';

  List<Results> filteredFavorites = [];
  String favoriteStatusFilter = '';
  String favoriteGenderFilter = '';

  List<Results> get displayFavorites =>
      filteredFavorites.isNotEmpty ||
          favoriteStatusFilter.isNotEmpty ||
          favoriteGenderFilter.isNotEmpty
      ? filteredFavorites
      : favorites;

  void applyFavoriteFilter({String status = '', String gender = ''}) {
    favoriteStatusFilter = status;
    favoriteGenderFilter = gender;
    _applyFavoriteFilters();
    notifyListeners();
  }

  void clearFavoriteFilter() {
    favoriteStatusFilter = '';
    favoriteGenderFilter = '';
    _applyFavoriteFilters();
    notifyListeners();
  }

  void _applyFavoriteFilters() {
    filteredFavorites = favorites.where((e) {
      final matchesSearch =
          searchValueFavorite.isEmpty ||
          e.name!.toLowerCase().contains(searchValueFavorite.toLowerCase());
      final matchesStatus =
          favoriteStatusFilter.isEmpty ||
          e.status?.toLowerCase() == favoriteStatusFilter.toLowerCase();
      final matchesGender =
          favoriteGenderFilter.isEmpty ||
          e.gender?.toLowerCase() == favoriteGenderFilter.toLowerCase();
      return matchesSearch && matchesStatus && matchesGender;
    }).toList();
  }

  MainVm() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_favoritesKey) ?? [];
    favorites = data.map((e) => Results.fromJson(jsonDecode(e))).toList();
    _applyFavoriteFilters();
    notifyListeners();
  }

  Future<void> toggleFavorite(Results character) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_favoritesKey) ?? [];

    final exists = data.any((e) => jsonDecode(e)['id'] == character.id);

    if (exists) {
      data.removeWhere((e) => jsonDecode(e)['id'] == character.id);
    } else {
      data.add(
        jsonEncode({
          'id': character.id,
          'name': character.name,
          'status': character.status,
          'species': character.species,
          'type': character.type,
          'gender': character.gender,
          'origin': character.origin != null
              ? {'name': character.origin!.name, 'url': character.origin!.url}
              : null,
          'location': character.location != null
              ? {'name': character.location!.name, 'url': character.location!.url}
              : null,
          'image': character.image,
          'episode': character.episode,
          'url': character.url,
          'created': character.created,
        }),
      );
    }

    await prefs.setStringList(_favoritesKey, data);
    await loadFavorites();
  }

  bool isFavorite(int id) {
    return favorites.any((c) => c.id == id);
  }

  // ======================

  void nextPage() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      goNext = true;
      notifyListeners();
    }
  }

  int filterAZ = 1;

  String statusText = '';
  String genderText = '';
  int statusSelected = -1;
  int genderSelected = -1;

  bool initFilter = false;

  int themeSelect = 1;
  String themeTitle = 'Выключена';

  void filterSelect() {
    if (statusSelected != -1 || genderSelected != -1) {
      initFilter = true;
    } else {
      initFilter = false;
    }
  }

  void updateVm() {
    filterSelect();
    notifyListeners();
  }

  void updateStat() {
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    searchControllerFavorite.dispose();
    super.dispose();
  }
}
