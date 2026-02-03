import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/main/screens/order_success.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final cartItems = cartController.cartItems;
      final totalPrice = cartController.cartTotal;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Cart"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  cartItems.isEmpty
                      ? const Center(child: Text("Your cart is empty! 🛒"))
                      : ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kDefualtPaddin,
                              ),
                              child: Divider(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                        itemBuilder: (context, index) {
                          final product = cartItems[index];
                          return ListTile(
                            leading: Image.asset(
                              product.imagePath,
                              width: 60,
                              fit: BoxFit.contain,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${product.description}, ${product.unit}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartController.removeFromCart(product.id);
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // quantity control
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              cartController.decrementQty(
                                                product.id,
                                              );
                                            },
                                          ),
                                          Text('${product.quantity}'),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              size: 18,
                                              color: kPrimaryColor,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {
                                              cartController.incrementQty(
                                                product.id,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    MyButton(
                      textColor: Theme.of(context).colorScheme.onTertiary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefualtPaddin,
                      ),
                      text: "Go to Checkout",
                      color: kPrimaryColor,
                      onPressed: () {
                        _showCheckoutBottomSheet(context, totalPrice);
                      },
                    ),
                    Positioned(
                      right: 50,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  void _showCheckoutBottomSheet(BuildContext context, double totalPrice) {
    final cartController = Get.find<CartController>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefualtPaddin,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),

            // Reuse _buildCheckoutTile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCheckoutTile(
                    context: context,
                    title: "Delivery",
                    trailing: const Text("Select Method"),
                    onTap: () {},
                  ),
                  _buildCheckoutTile(
                    context: context,
                    title: "Payment",
                    trailing: Image.asset(
                      'assets/icons/mastercard.png',
                      width: 22,
                    ),
                    onTap: () {},
                  ),
                  _buildCheckoutTile(
                    context: context,
                    title: "Promo Code",
                    trailing: const Text(
                      "Pick discount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {},
                  ),
                  _buildCheckoutTile(
                    context: context,
                    title: "Total Cost",
                    trailing: Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text.rich(
                      TextSpan(
                        text: "By placing an order you agree to our\n",
                        children: [
                          TextSpan(
                            text: "Terms",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          const TextSpan(text: " And "),
                          TextSpan(
                            text: "Conditions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: MyButton(
                      padding: EdgeInsets.zero,
                      text: "Place Order",
                      color: kPrimaryColor,
                      onPressed: () async {
                        final shouldProceed = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Confirm Order"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Total: \$${cartController.cartTotal.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Are you sure you want to place this order?",
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: const Text("Confirm"),
                                  ),
                                ],
                              ),
                        );

                        if (shouldProceed == true) {
                          cartController.clearCart();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderSuccessScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildCheckoutTile({
  required BuildContext context,
  required String title,
  required Widget trailing,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15)),
            trailing,
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
      Divider(color: Theme.of(context).colorScheme.surface, height: 0.6),
    ],
  );
}
