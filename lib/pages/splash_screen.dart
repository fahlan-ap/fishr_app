import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fishr_app/pages/auth/landing_screen.dart';
import 'package:fishr_app/services/storage_service.dart'; // import service

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? imageUrl;
  final storageService = StorageService(); // inisialisasi service

  @override
  void initState() {
    super.initState();
    loadImage();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => LandingScreen());
    });
  }

  void loadImage() {
    final publicUrl = storageService.getPublicImageUrl('FishR.png');

    setState(() {
      imageUrl = publicUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: imageUrl == null
            ? const CircularProgressIndicator()
            : Image.network(
                imageUrl!,
                width: 350,
                height: 350,
              ),
      ),
    );
  }
}