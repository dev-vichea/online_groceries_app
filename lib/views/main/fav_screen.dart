import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/controllers/favorite_controller.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/product/product_detail.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();
    final cartController = Get.find<CartController>();

    return Obx(() {
      final favoriteProducts = favoriteController.favorites.toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  favoriteProducts.isEmpty
                      ? const Center(
                        child: Text("No favorite products yet! ❤️"),
                      )
                      : ListView.separated(
                        itemCount: favoriteProducts.length,
                        separatorBuilder:
                            (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefualtPaddin,
                              ),
                              child: Divider(),
                            ),
                        itemBuilder: (context, index) {
                          Product product = favoriteProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ProductDetail(product: product),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.asset(
                                product.imagePath,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("${product.description}, Price"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "\$${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                      favoriteController.removeFromFavorites(
                                        product,
                                      );
                                    },
                                    icon: Image.asset(
                                      'assets/icons/trash.png',
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            if (favoriteProducts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefualtPaddin,
                  ),
                  text: "Add All to Cart",
                  color: kPrimaryColor,
                  onPressed: () {
                    SnackBarHelper.messageSnackbar(
                      context,
                      'All Items has been added to cart!',
                    );
                    cartController.addAllFavoritesToCart(
                      favoriteController.favorites.toList(),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}
