import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/my_text_field.dart';
import 'package:online_groceries_app/components/text_login_signup.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVis = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Image.asset('assets/icons/carrot-color.png', width: 40),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text('Sign Up', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 15),
                    Text(
                      'Enter your credentials to continue',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    MyTextField(label: 'Username', obscureText: false),
                    SizedBox(height: 30),
                    MyTextField(label: 'Email', obscureText: false),
                    SizedBox(height: 30),
                    MyTextField(
                      label: 'Password',
                      obscureText: isVis,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVis = !isVis;
                          });
                        },
                        icon: Icon(
                          isVis
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text.rich(
                      TextSpan(
                        text: "By continuing you agree to our ",
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy.",
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
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      onPressed: () {},
                      text: 'Sign up',
                      color: kPrimaryColor,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 15),
                    RowTextLoginSignup(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      firstText: 'Already have an account? ',
                      secText: 'Log in',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
