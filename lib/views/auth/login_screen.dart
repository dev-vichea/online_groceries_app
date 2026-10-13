import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/my_text_field.dart';
import 'package:online_groceries_app/components/responsive_container.dart';
import 'package:online_groceries_app/components/social_auth_row.dart';
import 'package:online_groceries_app/components/text_login_signup.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/auth/mobile_number_screen.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onSuccessAuth;
  final String? promptMessage;

  const LoginScreen({
    super.key,
    this.onSuccessAuth,
    this.promptMessage,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSkip() {
    final authController = Get.find<AuthController>();
    authController.skipAuthentication();
    SnackBarHelper.messageSnackbar(
      context,
      'Browsing as guest. Sign in anytime to complete purchases!',
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (route) => false,
    );
  }

  void _onAuthComplete(String message) {
    SnackBarHelper.messageSnackbar(context, message);
    if (widget.onSuccessAuth != null) {
      widget.onSuccessAuth!();
      Navigator.pop(context);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const App()),
        (route) => false,
      );
    }
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || !email.contains('@')) {
      SnackBarHelper.messageSnackbar(
        context,
        'Please enter a valid email address.',
        isError: true,
      );
      return;
    }
    if (password.isEmpty) {
      SnackBarHelper.messageSnackbar(
        context,
        'Please enter your password.',
        isError: true,
      );
      return;
    }

    final authController = Get.find<AuthController>();
    authController.login(email: email, password: password);
    _onAuthComplete('Logged in successfully!');
  }

  void _handleGoogleLogin() {
    final authController = Get.find<AuthController>();
    authController.loginWithGoogle();
    _onAuthComplete('Signed in with Google!');
  }

  void _handleFacebookLogin() {
    final authController = Get.find<AuthController>();
    authController.loginWithFacebook();
    _onAuthComplete('Signed in with Facebook!');
  }

  void _handleMobileLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MobileNumberScreen(
          onSuccessAuth: widget.onSuccessAuth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 480,
          child: Column(
          children: [
            // Top Bar with optional Back Button & Prominent Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (Navigator.canPop(context))
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      onPressed: () => Navigator.pop(context),
                    )
                  else
                    const SizedBox(width: 40),

                  // Prominent "Skip" button for new users
                  TextButton.icon(
                    onPressed: _handleSkip,
                    icon: Text(
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
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icons/carrot-color.png',
                        width: 44,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Redirect reason banner if navigated from shopping
                    if (widget.promptMessage != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: kPrimaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.promptMessage!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your email and password',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    MyTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    MyTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          SnackBarHelper.messageSnackbar(
                            context,
                            'Password reset link sent if registered.',
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Submit Login Button
                    MyButton(
                      onPressed: _handleLogin,
                      text: 'Log in',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 24),

                    // Divider with label
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
                    const SizedBox(height: 18),

                    // Horizontal Mobile, Google, Facebook options
                    SocialAuthRow(
                      onMobileTap: _handleMobileLogin,
                      onGoogleTap: _handleGoogleLogin,
                      onFacebookTap: _handleFacebookLogin,
                    ),
                    const SizedBox(height: 24),

                    // Switch to Sign Up
                    RowTextLoginSignup(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(
                              onSuccessAuth: widget.onSuccessAuth,
                              promptMessage: widget.promptMessage,
                            ),
                          ),
                        );
                      },
                      firstText: "Don't have an account? ",
                      secText: 'Sign up',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
