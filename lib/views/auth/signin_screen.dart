import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/responsive_container.dart';
import 'package:online_groceries_app/components/social_auth_row.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/auth/login_screen.dart';
import 'package:online_groceries_app/views/auth/mobile_number_screen.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  void _handleSkip(BuildContext context) {
    final authController = Get.find<AuthController>();
    authController.skipAuthentication();
    SnackBarHelper.messageSnackbar(
      context,
      'Browsing as guest. Sign in anytime to checkout!',
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (route) => false,
    );
  }

  void _handleGoogle(BuildContext context) {
    final authController = Get.find<AuthController>();
    authController.loginWithGoogle();
    SnackBarHelper.messageSnackbar(context, 'Signed in with Google!');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (route) => false,
    );
  }

  void _handleFacebook(BuildContext context) {
    final authController = Get.find<AuthController>();
    authController.loginWithFacebook();
    SnackBarHelper.messageSnackbar(context, 'Signed in with Facebook!');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/sub-bg.png', fit: BoxFit.contain),
          ),
          SafeArea(
            child: ResponsiveContainer(
              maxWidth: 500,
              child: Column(
                children: [
                // Top skip button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                      onPressed: () => _handleSkip(context),
                      icon: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      label: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: kPrimaryColor,
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get your groceries\nwith nectar',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Mobile number field input
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MobileNumberScreen(),
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            style: Theme.of(context).textTheme.headlineSmall,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '+855 Enter mobile number',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    'assets/images/cam-flag.png',
                                    width: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Horizontal Continue with Mobile, Google, Facebook
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      SocialAuthRow(
                        onMobileTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MobileNumberScreen(),
                            ),
                          );
                        },
                        onGoogleTap: () => _handleGoogle(context),
                        onFacebookTap: () => _handleFacebook(context),
                      ),
                      const SizedBox(height: 20),

                      // Sign up button
                      MyButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        text: 'Sign up with Email',
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 12),

                      // Log in button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Already have an account? Log In',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
