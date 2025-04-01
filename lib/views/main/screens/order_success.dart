import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/my_trans_button.dart';
import 'package:online_groceries_app/utils/constants.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset('assets/animated/confetti.json'),
                  Image.asset('assets/icons/accepted.png', width: 140),
                ],
              ),
              const Text(
                "Your Order has been accepted",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Your items have been placed and are on\ntheir way to being processed.",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              MyButton(
                onPressed: () {},
                text: "Track Order",
                color: kPrimaryColor,
                padding: EdgeInsets.zero,
              ),
              // MyButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => App()),
              //     );
              //   },
              //   textColor: Theme.of(context).colorScheme.onSecondary,
              //   text: "Back to home",
              //   color: Colors.white,
              //   padding: EdgeInsets.zero,
              // ),
              MyTransButton(
                text: 'Back to Home',
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => App()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
