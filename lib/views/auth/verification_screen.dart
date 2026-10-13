import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/app.dart';
import 'package:online_groceries_app/controllers/auth_controller.dart';
import 'package:online_groceries_app/utils/constants.dart';
import 'package:online_groceries_app/utils/snackbar_helper.dart';
import 'package:online_groceries_app/views/main/screens/select_location_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final VoidCallback? onSuccessAuth;

  const VerificationScreen({
    super.key,
    this.phoneNumber,
    this.onSuccessAuth,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
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

  void _completeVerification() {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      SnackBarHelper.messageSnackbar(
        context,
        'Please enter the 4-digit verification code.',
        isError: true,
      );
      return;
    }

    final authController = Get.find<AuthController>();
    authController.loginWithPhone(widget.phoneNumber ?? '+855');
    SnackBarHelper.messageSnackbar(context, 'Mobile verification successful!');

    if (widget.onSuccessAuth != null) {
      widget.onSuccessAuth!();
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectLocationScreen(),
        ),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your 4-digit code",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Sent to ${widget.phoneNumber ?? 'your mobile number'}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text("Code", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 5),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                counterText: "",
                hintText: '- - - - ',
                hintStyle: TextStyle(
                  fontSize: 20,
                  letterSpacing: 8,
                  color: Colors.grey.shade700,
                ),
              ),
              onFieldSubmitted: (_) => _completeVerification(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    SnackBarHelper.messageSnackbar(
                      context,
                      'Verification code resent!',
                    );
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(color: kPrimaryColor, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    onPressed: _completeVerification,
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
