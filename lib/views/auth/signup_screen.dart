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
import 'package:online_groceries_app/views/auth/login_screen.dart';
import 'package:online_groceries_app/views/auth/mobile_number_screen.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback? onSuccessAuth;
  final String? promptMessage;

  const SignupScreen({
    super.key,
    this.onSuccessAuth,
    this.promptMessage,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
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

  void _handleSignup() {
    final username = _usernameController.text.trim();
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
    if (password.length < 6) {
      SnackBarHelper.messageSnackbar(
        context,
        'Password must be at least 6 characters long.',
        isError: true,
      );
      return;
    }

    final authController = Get.find<AuthController>();
    authController.signup(name: username, email: email, password: password);
    _onAuthComplete('Account created successfully!');
  }

  void _handleGoogleSignup() {
    final authController = Get.find<AuthController>();
    authController.loginWithGoogle();
    _onAuthComplete('Signed in with Google!');
  }

  void _handleFacebookSignup() {
    final authController = Get.find<AuthController>();
    authController.loginWithFacebook();
    _onAuthComplete('Signed in with Facebook!');
  }

  void _handleMobileSignup() {
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

                    // Redirect reason banner if navigated from a shopping feature
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
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your credentials to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Username Field
                    MyTextField(
                      controller: _usernameController,
                      label: 'Username',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),

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
                    const SizedBox(height: 16),

                    // Terms text
                    Text.rich(
                      TextSpan(
                        text: 'By continuing you agree to our ',
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Sign Up Submit Button
                    MyButton(
                      onPressed: _handleSignup,
                      text: 'Sign up',
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
                      onMobileTap: _handleMobileSignup,
                      onGoogleTap: _handleGoogleSignup,
                      onFacebookTap: _handleFacebookSignup,
                    ),
                    const SizedBox(height: 24),

                    // Switch to Log in
                    RowTextLoginSignup(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              onSuccessAuth: widget.onSuccessAuth,
                              promptMessage: widget.promptMessage,
                            ),
                          ),
                        );
                      },
                      firstText: 'Already have an account? ',
                      secText: 'Log in',
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
