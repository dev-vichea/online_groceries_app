import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favorites => List.unmodifiable(_favoriteProducts);

  bool isFavorite(Product product) {
    return _favoriteProducts.any((fav) => fav.id == product.id);
  }

  void toggleFavorite(Product product) {
    final existingIndex = _favoriteProducts.indexWhere((fav) => fav.id == product.id);
    
    if (existingIndex != -1) {
      _favoriteProducts.removeAt(existingIndex);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }
  

  void removeFromFavorites(Product product) {
    _favoriteProducts.removeWhere((fav) => fav.id == product.id);
    notifyListeners();
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}