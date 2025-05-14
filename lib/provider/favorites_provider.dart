import 'package:flutter/material.dart';
import 'package:game_buzz/movie.dart';


class FavoritesProvider with ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  void addFavorite(Movie movie) {
    _favorites.add(movie);
    notifyListeners(); // 🟢 this is critical!
  }

  void removeFavorite(int movieId) {
    _favorites.removeWhere((movie) => movie.id == movieId);
    notifyListeners(); // 🟢 also here!
  }

  bool isFavorite(int movieId) {
    return _favorites.any((movie) => movie.id == movieId);
  }
}
