import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];
  final List<Product> _favoriteItems = [];

  List<Product> get cartItems =>
      List.unmodifiable(_cartItems); // Prevent external modification
  List<Product> get favoriteItems => List.unmodifiable(_favoriteItems);

  void addToCart(Product product) {
    final newProduct = Product(
      id: product.id,
      name: product.name,
      imagePath: product.imagePath,
      description: product.description,
      price: product.price,
      unit: product.unit,
      categories: List.from(
        product.categories,
      ), // Create new list to avoid reference issues
      category: product.category,
      quantity: product.quantity,
    );

    final existingIndex = _cartItems.indexWhere(
      (item) => item.id == newProduct.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += newProduct.quantity;
    } else {
      _cartItems.add(newProduct);
    }
    notifyListeners();
  }

  double get cartTotal =>
      _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));

  void removeFromCart(int productId) {
    // Changed to int
    _cartItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void incrementQty(int productId) {
    // Changed to int
    final index = _cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQty(int productId) {
    // Changed to int
    final index = _cartItems.indexWhere((item) => item.id == productId);
    if (index == -1) return;

    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void addToFavorite(Product product) {
    if (!_favoriteItems.any((item) => item.id == product.id)) {
      _favoriteItems.add(
        Product(
          id: product.id,
          name: product.name,
          imagePath: product.imagePath,
          description: product.description,
          price: product.price,
          unit: product.unit,
          categories: List.from(product.categories),
          category: product.category,
          quantity: 1, // Favorites typically don't need quantity
        ),
      );
      notifyListeners();
    }
  }

  void addAllFavoritesToCart(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(
      context,
      listen: false,
    );
    for (var product in favoriteProvider.favorites) {
      if (!_cartItems.any((item) => item.id == product.id)) {
        addToCart(product);
      }
    }
    notifyListeners();
  }

  void removeFromFavorite(int productId) {
    // Changed to int
    _favoriteItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  // Helper method
  bool isFavorite(int productId) {
    return _favoriteItems.any((item) => item.id == productId);
  }
}
