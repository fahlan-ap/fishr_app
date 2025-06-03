import 'package:flutter/material.dart';
import 'package:fishr_app/components/nav.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterAuth extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> register(String email, String password) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Email dan Password tidak boleh kosong.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: trimmedEmail,
        password: trimmedPassword,
      );

      final user = res.user;

      if (user != null) {
        Get.off(() => const NavButton());
      }
    } on AuthException catch (e) {
      Get.snackbar(
        "Registrasi Gagal",
        e.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat registrasi.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}