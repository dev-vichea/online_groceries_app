import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/components/my_trans_button.dart';
import 'package:online_groceries_app/utils/constants.dart';

class CustomShowDialog {
  static void show(BuildContext context, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Image.asset('assets/images/oops.png', height: 150),
                SizedBox(height: 10),
                Text(
                  "Oops! Order Failed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Something went tembly wrong.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 30),
                MyButton(
                  onPressed: onPressed,
                  text: 'Please Try Again',
                  color: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
                ),
                MyTransButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Back Home',
                  padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
