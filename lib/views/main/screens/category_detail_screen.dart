import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/responsive_container.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/product/product_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products
        .where((product) => product.category.contains(categoryName.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text("No products found in this category"))
          : ResponsiveContainer(
              maxWidth: 960,
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 840
                      ? 4
                      : constraints.maxWidth >= 580
                          ? 3
                          : 2;

                  return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.77,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
