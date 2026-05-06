import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Map>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<Map>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  final box = Hive.box('favorites');

  void loadFavorites() {
    state = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  void toggleFavorite(Map movie) {
    final id = movie['id'];

    if (box.containsKey(id)) {
      box.delete(id);
    }else{
      box.put(id, movie);
    }

    loadFavorites();
  }

  bool isFavorite(int id) {
    return box.containsKey(id);
  }
}
