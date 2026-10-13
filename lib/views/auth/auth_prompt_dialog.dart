import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/auth/login_screen.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

class AuthPromptDialog {
  static Future<void> show(
    BuildContext context, {
    required String featureName,
    VoidCallback? onSuccessAuth,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 520),
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        final isDark = Theme.of(sheetContext).brightness == Brightness.dark;
        final bgColor = Theme.of(sheetContext).scaffoldBackgroundColor;

        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Handle
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Icon badge
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/carrot-color.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title
              Text(
                'Authentication Required',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(sheetContext).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                'To $featureName, please sign in to your account or create a new one to continue shopping.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Theme.of(sheetContext).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 28),

              // Sign Up Button
              MyButton(
                padding: EdgeInsets.zero,
                text: 'Create an Account (Sign Up)',
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(sheetContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(
                        onSuccessAuth: onSuccessAuth,
                        promptMessage: 'Sign up to $featureName',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Log In Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          onSuccessAuth: onSuccessAuth,
                          promptMessage: 'Log in to $featureName',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
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
                      color: Theme.of(sheetContext).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Continue Browsing (Guest)
              TextButton(
                onPressed: () => Navigator.pop(sheetContext),
                child: Text(
                  'Continue Browsing as Guest',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(sheetContext).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
