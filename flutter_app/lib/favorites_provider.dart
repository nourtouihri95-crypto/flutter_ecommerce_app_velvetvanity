import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.name == product.name);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.name == product.name);
    } else {
      _favorites.add(product);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favorites.map((p) => p.toJson()).toList();
    prefs.setString('favorites', jsonEncode(data));
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorites');

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      _favorites.clear();
      _favorites.addAll(
        decoded.map((e) => Product.fromJson(e)),
      );
      notifyListeners();
    }
  }
}

