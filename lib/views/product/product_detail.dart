import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:like_button/like_button.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/provider/add_to_cart_provider.dart';
import 'package:online_groceries_app/provider/favorite_provider.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Product _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentProduct = Product(
      id: widget.product.id,
      name: widget.product.name,
      imagePath: widget.product.imagePath,
      description: widget.product.description,
      price: widget.product.price,
      unit: widget.product.unit,
      categories: List.from(widget.product.categories),
      category: widget.product.category,
      quantity: widget.product.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentTotal = _currentProduct.price * _currentProduct.quantity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: ImageSlideshow(
                    indicatorRadius: 3,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kDefualtPaddin),
                        child: Image.asset(_currentProduct.imagePath),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefualtPaddin),
                        child: Image.asset(_currentProduct.imagePath),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefualtPaddin),
                        child: Image.asset(_currentProduct.imagePath),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _currentProduct.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LikeButton(
                          size: 25,
                          isLiked: context.watch<FavoriteProvider>().isFavorite(
                            _currentProduct,
                          ),
                          onTap: (isLiked) async {
                            context.read<FavoriteProvider>().toggleFavorite(
                              _currentProduct,
                            );
                            return !isLiked; // Return the new state
                          },
                          likeBuilder: (bool isLiked) {
                            return isLiked
                                ? Image.asset('assets/icons/liked.png')
                                : Image.asset('assets/icons/like.png');
                          },
                        ),
                      ],
                    ),
                    Text(
                      '${_currentProduct.description}, ${_currentProduct.unit}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    // Updated Quantity Controls and Price Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity Controls
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_currentProduct.quantity > 1) {
                                      _currentProduct.quantity--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                '${_currentProduct.quantity}',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: kPrimaryColor),
                                onPressed: () {
                                  setState(() {
                                    _currentProduct.quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        // Total Price
                        Text(
                          '\$${currentTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text('Product Detail'),
                      childrenPadding: EdgeInsets.only(bottom: 10),
                      children: [
                        Text(
                          "Apples are nutritious. They may help with weight loss and heart health.",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.only(bottom: 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nutritions'),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '100gr',
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            const Text(
                              '100g',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Energy: 52kcal',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.only(bottom: 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Review'),
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Text(
                          'Good quality, but a bit pricey.',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: MyButton(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          text: 'Add To Basket - \$${currentTotal.toStringAsFixed(2)}',
          color: kPrimaryColor,
          onPressed: () {
            context.read<CartProvider>().addToCart(_currentProduct);
            SnackBarHelper.messageSnackbar(
              context,
              _currentProduct.quantity == 1
                  ? "${widget.product.name} added to cart!"
                  : "${_currentProduct.quantity} ${widget.product.name} added to cart!",
            );
            // _addToCartMess(context);
          },
        ),
      ),
    );
  }
}
