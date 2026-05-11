import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }
  
  Future<void> _loadFavorites() async {
    final box = Hive.box('favorites');
    final favorites = box.get('routes', defaultValue: <int>[]);
    state = List<int>.from(favorites);
  }
  
  Future<void> addFavorite(int routeId) async {
    if (!state.contains(routeId)) {
      state = [...state, routeId];
      final box = Hive.box('favorites');
      await box.put('routes', state);
    }
  }
  
  Future<void> removeFavorite(int routeId) async {
    state = state.where((id) => id != routeId).toList();
    final box = Hive.box('favorites');
    await box.put('routes', state);
  }
  
  bool isFavorite(int routeId) {
    return state.contains(routeId);
  }
}
