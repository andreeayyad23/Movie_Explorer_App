import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_explorer_app/models/search_model.dart';

class FavoriteProvider with ChangeNotifier {
  List<Result> _favorites = [];

  List<Result> get favorites => _favorites;

  FavoriteProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs
            .getStringList('favoriteIds')
            ?.map((id) => int.parse(id))
            .toList() ??
        [];
    // Fetch movie details for each ID (you may need to call an API here)
    // For now, we'll just store the IDs and fetch details later
    _favorites = favoriteIds
        .map((id) => Result(
            id: id,
            adult: false,
            backdropPath: '',
            genreIds: [],
            originalLanguage: '',
            originalTitle: '',
            overview: '',
            popularity: 0.0,
            posterPath: '',
            releaseDate: DateTime.now(),
            title: '',
            video: false,
            voteAverage: 0.0,
            voteCount: 0 
            ))
        .toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(Result movie) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favorites.any((m) => m.id == movie.id)) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    await prefs.setStringList(
        'favoriteIds', _favorites.map((m) => m.id.toString()).toList());
    notifyListeners();
  }

  bool isFavorite(int movieId) {
    return _favorites.any((m) => m.id == movieId);
  }
}
