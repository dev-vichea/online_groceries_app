import 'package:get/get.dart';
import 'package:online_groceries_app/model/product_model.dart';

class FavoriteController extends GetxController {
  final RxList<Product> favorites = <Product>[].obs;

  bool isFavorite(Product product) {
    return favorites.any((fav) => fav.id == product.id);
  }

  void toggleFavorite(Product product) {
    final existingIndex = favorites.indexWhere((fav) => fav.id == product.id);
    if (existingIndex != -1) {
      favorites.removeAt(existingIndex);
    } else {
      favorites.add(product);
    }
  }

  void removeFromFavorites(Product product) {
    favorites.removeWhere((fav) => fav.id == product.id);
  }
}
