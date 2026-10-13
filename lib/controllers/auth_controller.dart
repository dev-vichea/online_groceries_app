import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/views/auth/auth_prompt_dialog.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String authProvider; // 'email', 'google', 'facebook', 'phone'

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.authProvider,
  });
}

class AuthController extends GetxController {
  final RxBool isAuthenticated = false.obs;
  final RxBool isGuest = true.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  bool get isLoggedIn => isAuthenticated.value;

  void login({required String email, required String password}) {
    final displayName = email.split('@').first;
    currentUser.value = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: displayName.isNotEmpty
          ? displayName[0].toUpperCase() + displayName.substring(1)
          : 'User',
      email: email,
      authProvider: 'email',
    );
    isAuthenticated.value = true;
    isGuest.value = false;
  }

  void signup({
    required String name,
    required String email,
    required String password,
  }) {
    currentUser.value = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim().isNotEmpty ? name.trim() : 'New User',
      email: email,
      authProvider: 'email',
    );
    isAuthenticated.value = true;
    isGuest.value = false;
  }

  void loginWithGoogle() {
    currentUser.value = const UserModel(
      id: 'usr_google',
      name: 'Google User',
      email: 'user@gmail.com',
      authProvider: 'google',
    );
    isAuthenticated.value = true;
    isGuest.value = false;
  }

  void loginWithFacebook() {
    currentUser.value = const UserModel(
      id: 'usr_facebook',
      name: 'Facebook User',
      email: 'user@facebook.com',
      authProvider: 'facebook',
    );
    isAuthenticated.value = true;
    isGuest.value = false;
  }

  void loginWithPhone(String phone) {
    currentUser.value = UserModel(
      id: 'usr_phone',
      name: 'Mobile User',
      email: '$phone@groceries.app',
      phone: phone,
      authProvider: 'phone',
    );
    isAuthenticated.value = true;
    isGuest.value = false;
  }

  void skipAuthentication() {
    isAuthenticated.value = false;
    isGuest.value = true;
    currentUser.value = null;
  }

  void logout() {
    isAuthenticated.value = false;
    isGuest.value = true;
    currentUser.value = null;
  }

  /// Checks if user is authenticated. If not, prompts or redirects to auth screen.
  /// Returns `true` if already authenticated, or `false` if unauthenticated.
  bool requireAuth(
    BuildContext context, {
    required String featureName,
    VoidCallback? onAuthenticated,
  }) {
    if (isAuthenticated.value) {
      onAuthenticated?.call();
      return true;
    }

    AuthPromptDialog.show(
      context,
      featureName: featureName,
      onSuccessAuth: () {
        onAuthenticated?.call();
      },
    );
    return false;
  }
}
