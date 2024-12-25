import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:karadana_tea_factory/screens/home/homepage.dart';

import 'signuppage.dart'; // Import TapGestureRecognizer

void main() {
  runApp(const LogIn());
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogIn page of KTF',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'src/images/page02.png'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content (text and buttons) on top of the image
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LogIn Text
                    const Text(
                      'LogIn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Please LogIn to continue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Employee ID',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Add User',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// SignUp Page
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the SignUp Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
