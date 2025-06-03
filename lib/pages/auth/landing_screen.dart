import 'package:flutter/material.dart';
import 'package:fishr_app/pages/auth/login_screen.dart';
import 'package:fishr_app/pages/auth/register_screen.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              "assets/images/FishR.png",
              width: 325,
              height: 325,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 7.5),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: const BorderSide(color: Color(0xFF012748), width: 2.0),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.to(RegisterScreen());
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF012748),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 7.5),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: const BorderSide(color: Color(0xFF012748), width: 2.0),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF012748),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
