import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/icons/carrot.png', width: 40),
                const SizedBox(height: 20),
                Text(
                  'Welcome to our store',
                  style: TextStyle(fontSize: 38, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ger your groceries in as fast as one hour',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 1),
                MyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                    );
                  },
                  text: 'Get Started',
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(kDefualtPaddin),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
