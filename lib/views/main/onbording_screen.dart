import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/responsive_container.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/auth/signin_screen.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onbording-bg.png',
              fit: BoxFit.cover,
            ),
          ),
          ResponsiveContainer(
            maxWidth: 480,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/icons/carrot.png', width: 40),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to our store',
                  style: TextStyle(fontSize: 38, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Get your groceries in as fast as one hour',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 1),
                MyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SigninScreen()),
                    );
                  },
                  text: 'Get Started',
                  color: kPrimaryColor,
                  padding: const EdgeInsets.all(kDefualtPaddin),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
