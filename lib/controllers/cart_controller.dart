import 'package:get/get.dart';
import 'package:online_groceries_app/model/product_model.dart';

class CartController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;

  List<Product> get items => cartItems;

  double get cartTotal =>
      cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));

  void addToCart(Product product) {
    final newProduct = Product(
      id: product.id,
      name: product.name,
      imagePath: product.imagePath,
      description: product.description,
      price: product.price,
      unit: product.unit,
      categories: List.from(product.categories),
      category: product.category,
      quantity: product.quantity,
    );

    final existingIndex = cartItems.indexWhere(
      (item) => item.id == newProduct.id,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity += newProduct.quantity;
      cartItems.refresh();
    } else {
      cartItems.add(newProduct);
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.id == productId);
  }

  void incrementQty(int productId) {
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decrementQty(int productId) {
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index == -1) return;

    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(index);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  void addAllFavoritesToCart(List<Product> favorites) {
    for (final product in favorites) {
      if (!cartItems.any((item) => item.id == product.id)) {
        addToCart(product);
      }
    }
  }
}
