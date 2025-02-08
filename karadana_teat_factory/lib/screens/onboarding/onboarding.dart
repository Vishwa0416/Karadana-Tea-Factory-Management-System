import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/auth/loginpage.dart';

import 'package:karadana_tea_factory/screens/auth/signuppage.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/onboarding_image.png',
                height: 250, fit: BoxFit.cover),
            const SizedBox(height: 30),

            const Text(
              "Welcome to Karadana Tea Factory",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            const Text(
              "Manage tea collections, suppliers, and factory operations seamlessly.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Login",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),

            const SizedBox(height: 15),

            // Sign Up Button
            OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                side: const BorderSide(color: Colors.green, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
