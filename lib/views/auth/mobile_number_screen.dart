import 'package:flutter/material.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/views/auth/verification_screen.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter your mobile number", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(
              "Mobile Number",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            TextFormField(
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
