import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/groceries_model.dart';
import 'package:online_groceries_app/model/product_model.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/product/product_card.dart';
import 'package:online_groceries_app/widgets/carousel_slider.dart';
import 'package:online_groceries_app/widgets/category_product.dart';
import 'package:online_groceries_app/widgets/features.dart';
import 'package:online_groceries_app/widgets/search_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> getCategoryProducts(String category) {
    return products
        .where((product) => product.categories.contains(category))
        .toList();
  }

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: kDefualtPaddin * 2),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/carrot-color.png', width: 35),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                        child: Image.asset(
                          'assets/icons/exclude.png',
                          width: 14,
                        ),
                      ),
                      Text('Cambodia, Phnom Penh'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefualtPaddin),
              child: SearchField(products: products),
            ),
            SizedBox(
              height: 100,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  MyCarouselSlider(
                    onPageChanged: (index) {
                      _currentIndex.value = index;
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: ValueListenableBuilder<int>(
                      valueListenable: _currentIndex,
                      builder: (context, value, child) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: PageController(initialPage: value),
                            count: 3,
                            effect: ExpandingDotsEffect(
                              dotHeight: 6,
                              dotWidth: 6,
                              activeDotColor: kPrimaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Feature(text: 'Exclusive Offer'),
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getCategoryProducts('exclusiveOffer').length,
                itemBuilder: (context, index) {
                  final product = getCategoryProducts('exclusiveOffer')[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: kDefualtPaddin - 5),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
            Feature(text: 'Best Selling'),
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getCategoryProducts('bestSelling').length,
                itemBuilder: (context, index) {
                  final product = getCategoryProducts('bestSelling')[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: kDefualtPaddin - 5),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
            Feature(text: 'Groceries'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: groceries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: kDefualtPaddin),
                    child: CategoryProduct(groceries: groceries[index]),
                  );
                },
              ),
            ),
            SizedBox(height: kDefualtPaddin),
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getCategoryProducts('groceries').length,
                itemBuilder: (context, index) {
                  final product = getCategoryProducts('groceries')[index];
                  final isLastItem =
                      index == getCategoryProducts('groceries').length - 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: kDefualtPaddin,
                      right: isLastItem ? kDefualtPaddin : 0,
                    ),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
