import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/components/responsive_container.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/auth/verification_screen.dart';

class MobileNumberScreen extends StatefulWidget {
  final VoidCallback? onSuccessAuth;

  const MobileNumberScreen({super.key, this.onSuccessAuth});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSkip() {
    final authController = Get.find<AuthController>();
    authController.skipAuthentication();
    SnackBarHelper.messageSnackbar(
      context,
      'Browsing as guest. Sign in anytime to complete purchases!',
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (route) => false,
    );
  }

  void _proceedToVerification() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      SnackBarHelper.messageSnackbar(
        context,
        'Please enter your mobile phone number.',
        isError: true,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          phoneNumber: phone,
          onSuccessAuth: widget.onSuccessAuth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _handleSkip,
              icon: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              label: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: ResponsiveContainer(
        maxWidth: 480,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your mobile number",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mobile Number",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+855 12 345 678',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/cam-flag.png',
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              onFieldSubmitted: (_) => _proceedToVerification(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    onPressed: _proceedToVerification,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 26,
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
