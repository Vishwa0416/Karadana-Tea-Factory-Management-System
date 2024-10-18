import 'package:flutter/material.dart';
import 'navbar.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page of KTF',
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('src/images/home.png'), // Background image path
            fit: BoxFit.cover, // Make sure the image covers the whole screen
          ),
        ),
        child: const Center(
          child: Text(
            'Home Page Content', // You can replace this with your page content
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(), // Add the bottom navigation bar here
    );
  }
}
