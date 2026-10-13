import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/controllers/favorite_controller.dart';
import 'package:online_groceries_app/controllers/theme_controller.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.put(AuthController());
    Get.put(CartController());
    Get.put(FavoriteController());
    Get.put(ThemeController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SignupScreen displays horizontal options: Mobile, Google, Facebook', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SignupScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title and credentials fields
    expect(find.text('Sign Up'), findsWidgets);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify Horizontal options
    expect(find.text('Mobile'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('Facebook'), findsOneWidget);

    // Verify Skip button
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('Skip button updates AuthController guest state', (WidgetTester tester) async {
    final authController = Get.find<AuthController>();

    await tester.pumpWidget(
      const GetMaterialApp(
        home: SignupScreen(),
      ),
    );
    await tester.pumpAndSettle();

    final skipFinder = find.text('Skip');
    expect(skipFinder, findsOneWidget);

    await tester.tap(skipFinder);
    await tester.pumpAndSettle();

    expect(authController.isAuthenticated.value, isFalse);
    expect(authController.isGuest.value, isTrue);
  });

  testWidgets('AuthController requires authentication for shopping actions', (WidgetTester tester) async {
    final authController = Get.find<AuthController>();
    expect(authController.isAuthenticated.value, isFalse);

    bool actionExecuted = false;

    await tester.pumpWidget(
      GetMaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  authController.requireAuth(
                    context,
                    featureName: 'add item to cart',
                    onAuthenticated: () {
                      actionExecuted = true;
                    },
                  );
                },
                child: const Text('Add To Cart Test'),
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Tap button without being logged in
    await tester.tap(find.text('Add To Cart Test'));
    await tester.pumpAndSettle();

    // Action should not have executed yet because user is unauthenticated
    expect(actionExecuted, isFalse);

    // Should display the authentication required prompt with sign up and log in options
    expect(find.text('Authentication Required'), findsOneWidget);
    expect(find.text('Create an Account (Sign Up)'), findsOneWidget);
    expect(find.text('Already have an account? Log In'), findsOneWidget);
  });
}
