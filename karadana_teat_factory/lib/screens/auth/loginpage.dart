import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/auth/signuppage.dart';
import 'package:karadana_tea_factory/screens/home/homepage.dart';
// import 'package:karadana_tea_factory/screens/auth/signup.dart'; // Placeholder for sign-up navigation

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login - KTF',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController employeeIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void temporaryLogin() {
    if (employeeIDController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      // TODO: Implement authentication API call here
      // Example:
      // String token = await loginAPI(employeeIDController.text, passwordController.text);
      // if (token.isValid) { navigate to HomePage } else { show error message }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Log in to manage tea production efficiently',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Employee ID Field
                TextField(
                  controller: employeeIDController,
                  decoration: InputDecoration(
                    hintText: 'Employee ID',
                    filled: true,
                    prefixIcon: const Icon(Icons.person, color: Colors.grey),
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
                    hintText: 'Password',
                    filled: true,
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Remember Me & Forgot Password Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Remember Me Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        const Text("Remember Me"),
                      ],
                    ),

                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password navigation
                        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: temporaryLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15),

                // Sign Up Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
