import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/auth/auth_prompt_dialog.dart';
import 'package:online_groceries_app/views/auth/signin_screen.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Obx(() {
              final isAuthed = authController.isAuthenticated.value;
              final user = authController.currentUser.value;

              return Padding(
                padding: const EdgeInsets.all(kDefualtPaddin),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: isAuthed
                            ? kPrimaryColor.withValues(alpha: 0.15)
                            : Colors.grey.shade300,
                        backgroundImage: isAuthed
                            ? const AssetImage('assets/images/profilepic.png')
                            : null,
                        child: !isAuthed
                            ? const Icon(
                                Icons.person_outline_rounded,
                                size: 36,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAuthed
                                ? (user?.name ?? 'Groceries Member')
                                : 'Guest User',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isAuthed
                                ? (user?.email ?? 'member@nectar.com')
                                : 'Sign in to access your orders & details',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isAuthed)
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: kPrimaryColor),
                        onPressed: () {},
                      )
                    else
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
            Divider(color: Theme.of(context).colorScheme.secondary),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(
                    context,
                    'assets/icons/order.png',
                    'Orders',
                    requiresAuth: true,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/detail-card.png',
                    'My Details',
                    requiresAuth: true,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/location.png',
                    'Delivery Address',
                    requiresAuth: true,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/payment.png',
                    'Payment Methods',
                    requiresAuth: true,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/promo.png',
                    'Promo Code',
                    requiresAuth: false,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/notification.png',
                    'Notifications',
                    requiresAuth: false,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/help.png',
                    'Help',
                    requiresAuth: false,
                  ),
                  buildListTile(
                    context,
                    'assets/icons/about.png',
                    'About',
                    requiresAuth: false,
                  ),
                ],
              ),
            ),
            Obx(() {
              final isAuthed = authController.isAuthenticated.value;

              if (isAuthed) {
                return MyButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 20,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    authController.logout();
                    SnackBarHelper.messageSnackbar(
                      context,
                      'Logged out successfully.',
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  text: 'Log out',
                  textColor: kPrimaryColor,
                  color: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefualtPaddin,
                  ),
                );
              } else {
                return MyButton(
                  icon: const Icon(
                    Icons.login_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    AuthPromptDialog.show(
                      context,
                      featureName: 'your full profile and account benefits',
                    );
                  },
                  text: 'Sign In / Sign Up',
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefualtPaddin,
                  ),
                );
              }
            }),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context,
    String icon,
    String title, {
    bool requiresAuth = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            icon,
            width: 30,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          title: Text(title, style: const TextStyle(fontSize: 15)),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onTap: () {
            if (requiresAuth) {
              final authController = Get.find<AuthController>();
              authController.requireAuth(
                context,
                featureName: 'access $title',
                onAuthenticated: () {
                  SnackBarHelper.messageSnackbar(context, "Opening $title");
                },
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          child: Divider(
            color: Theme.of(context).colorScheme.secondary,
            height: 0.8,
          ),
        ),
      ],
    );
  }
}
