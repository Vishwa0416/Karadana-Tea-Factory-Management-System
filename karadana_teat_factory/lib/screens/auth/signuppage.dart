import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/auth/loginpage.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up - KTF',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController employeeIDController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void registerUser() {
    // TODO: Implement user registration API call here
    // Example:
    // bool isSuccess = await registerAPI(fullNameController.text, employeeIDController.text, designationController.text, passwordController.text);
    // if (isSuccess) { Navigate to HomePage } else { Show error message }

    if (fullNameController.text.isNotEmpty &&
        employeeIDController.text.isNotEmpty &&
        designationController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text == confirmPasswordController.text) {
        // Simulating successful registration (Replace with actual backend call)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully!')),
        );

        // Navigate to login page after successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LogIn()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Ensures no UI overflow on smaller screens
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image as Top Cover
              Container(
                width: double.infinity,
                height: 200, // Adjust height to cover top of screen
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('./src/images/signuptea.jpg'), // Your image
                    fit: BoxFit
                        .cover, // Make the image cover the top part of the screen
                  ),
                ),
              ),

              // Title
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Please enter the details below to add a new user.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Full Name Field
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Employee ID Field
              TextField(
                controller: employeeIDController,
                decoration: InputDecoration(
                  labelText: 'Employee ID Number',
                  prefixIcon: const Icon(Icons.badge, color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Designation Field
              TextField(
                controller: designationController,
                decoration: InputDecoration(
                  labelText: 'Designation',
                  prefixIcon: const Icon(Icons.work, color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password Field
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.grey),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  'Add User',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),

              // Login Navigation
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
