import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/controllers/favorite_controller.dart';
import 'package:online_groceries_app/controllers/theme_controller.dart';
import 'package:online_groceries_app/main.dart';

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

  testWidgets('App renders onboarding screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Welcome to our store'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
