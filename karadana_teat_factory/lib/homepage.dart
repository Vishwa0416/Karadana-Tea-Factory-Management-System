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
        child: const Align(
          alignment: Alignment.topLeft, // Align the text to the top left corner
          child: Padding(
            padding:
                EdgeInsets.only(top: 50, left: 20), // Add padding if needed
            child: Text(
              'Hello User!', // You can replace this with your page content
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

      bottomNavigationBar: const NavBar(), // Add the bottom navigation bar here
    );
  }
}
