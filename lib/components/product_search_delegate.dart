import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/main/screens/filter_screen.dart';
import 'package:online_groceries_app/views/product/product_card.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        titleSpacing: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(8),
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      IconButton(
        icon: Image.asset('assets/icons/filter.png', width: 25),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FilterScreen()),
          );
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> filteredProducts =
        products
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefualtPaddin,
          left: kDefualtPaddin,
          right: kDefualtPaddin,
        ),
        child:
            filteredProducts.isEmpty
                ? const Center(
                  child: Text(
                    "No products found 👾",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
                : GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(product: filteredProducts[index]);
                  },
                ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
