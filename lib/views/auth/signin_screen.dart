import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'mobile_number_screen.dart'; // Import the new screen

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            child: Image.asset('assets/images/sub-bg.png', fit: BoxFit.contain),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Get your groceries\nwith nectar',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 25),
                  
                  // Wrap with GestureDetector
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobileNumberScreen(),
                        ),
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.headlineSmall,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '+855',
                          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'assets/images/cam-flag.png',
                                width: 5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Center(child: Text('Or connect with social media')),
                  ),
                  MyButton(
                    onPressed: () {},
                    text: 'Connect with Google',
                    color: Color(0xff5383EC),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 15),
                  MyButton(
                    onPressed: () {},
                    text: 'Connect with Facebook',
                    color: Color(0xff4A66AC),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
