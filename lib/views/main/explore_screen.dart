import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/widgets/category_card.dart';
import 'package:online_groceries_app/widgets/search_field.dart';
import 'package:online_groceries_app/model/category_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  
  List<Product> getCategoryProducts(String category) {
    return products
        .where((product) => product.categories.contains(category))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Find Products',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
        child: Column(
          children: [
            SearchField(products: products),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(category: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
