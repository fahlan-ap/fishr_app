import 'package:flutter/material.dart';
import 'package:fishr_app/components/nav.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginAuth extends GetxService {
  final supabase = Supabase.instance.client;

  Future<void> login(String email, String password) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Email dan password tidak boleh kosong.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: trimmedEmail,
        password: trimmedPassword,
      );

      final user = res.user;

      if (user != null) {
        Get.off(() => const NavButton());
      }
    } on AuthException {
      Get.snackbar(
        "Login Gagal",
        "Email atau Password Salah",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat login",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}