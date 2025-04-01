import 'package:flutter/material.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/my_text_field.dart';
import 'package:online_groceries_app/components/text_login_signup.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    Text('Log In', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 15),
                    Text(
                      'Enter your email and password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
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
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 15),
                    MyButton(
                      onPressed: () {
                        SnackBarHelper.messageSnackbar(context, 'Loggin Success');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => App(),
                          ),
                        );
                      },
                      text: 'Log in',
                      color: kPrimaryColor,
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 15),
                    RowTextLoginSignup(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      firstText: 'Don\'t have an account? ',
                      secText: 'Sign up',
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
