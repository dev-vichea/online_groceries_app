import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/product_search_delegate.dart';
import 'package:online_groceries_app/model/product_model.dart';

class SearchField extends StatelessWidget {
  final List<Product> products;

  const SearchField({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: ProductSearchDelegate(products));
      },
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          hintText: 'Search Store',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
