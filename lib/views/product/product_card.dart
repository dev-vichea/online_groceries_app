import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/product/product_detail.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(product: product),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: size.width / 2.4,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 80,
                  child: Center(
                    child: Hero(
                      tag: 'product_${product.id}',
                      child: Image.asset(product.imagePath),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${product.description}, ${product.unit}',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // Positioned Add Button
          Positioned(
            right: 12,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                final cartController = Get.find<CartController>();
                cartController.addToCart(product);
                SnackBarHelper.messageSnackbar(context, "${product.name} added to cart!");
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
