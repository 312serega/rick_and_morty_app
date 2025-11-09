import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/users_model.dart';

class FavoritesService {
  static const _key = 'favorite_characters';

  Future<List<Results>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => Results.fromJson(jsonDecode(e))).toList();
  }

  Future<void> toggleFavorite(Results character) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];

    final exists = favorites.any((e) => jsonDecode(e)['id'] == character.id);

    if (exists) {
      favorites.removeWhere((e) => jsonDecode(e)['id'] == character.id);
    } else {
      favorites.add(
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

    await prefs.setStringList(_key, favorites);
  }

  Future<bool> isFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites.any((e) => jsonDecode(e)['id'] == id);
  }
}
