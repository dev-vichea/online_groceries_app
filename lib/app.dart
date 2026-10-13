import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/main/cart_screen.dart';
import 'package:online_groceries_app/views/main/explore_screen.dart';
import 'package:online_groceries_app/views/main/fav_screen.dart';
import 'package:online_groceries_app/views/main/home_screen.dart';
import 'package:online_groceries_app/views/main/profile_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    CartScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Cart shopping tab
      final authController = Get.find<AuthController>();
      authController.requireAuth(
        context,
        featureName: 'view your shopping cart',
        onAuthenticated: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      );
      return;
    }

    if (index == 3) {
      // Favorites shopping tab
      final authController = Get.find<AuthController>();
      authController.requireAuth(
        context,
        featureName: 'view your saved favorites',
        onAuthenticated: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      unselectedLabelStyle: TextStyle(fontSize: 11),
      selectedLabelStyle: TextStyle(fontSize: 12),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Theme.of(context).colorScheme.tertiary,
      items: [
        _buildNavItem(
          iconPath: 'assets/icons/shop.png',
          label: 'Shop',
          index: 0,
        ),
        _buildNavItem(
          iconPath: 'assets/icons/search.png',
          label: 'Explore',
          index: 1,
        ),
        _buildNavItem(
          iconPath: 'assets/icons/cart.png',
          label: 'Cart',
          index: 2,
        ),
        _buildNavItem(
          iconPath: 'assets/icons/fav.png',
          label: 'Favorites',
          index: 3,
        ),
        _buildNavItem(
          iconPath: 'assets/icons/profile.png',
          label: 'Profile',
          index: 4,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Image.asset(
          iconPath,
          width: isSelected ? 19 : 18,
          height: isSelected ? 19 : 18,
          color:
              isSelected
                  ? kPrimaryColor
                  : Theme.of(context).colorScheme.tertiary,
        ),
      ),
      label: label,
    );
  }
}