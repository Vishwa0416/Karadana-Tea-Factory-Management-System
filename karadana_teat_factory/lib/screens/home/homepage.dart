import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';

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
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('src/images/home.png'), // Background image path
                fit:
                    BoxFit.cover, // Make sure the image covers the whole screen
              ),
            ),
          ),

          // "Hello User" text
          const Align(
            alignment:
                Alignment.topLeft, // Align the text to the top left corner
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

          // "Add Leaf Weight" box
          Positioned(
            top: 140, // Position the box from the top
            left: 50, // Position the box from the right
            child: GestureDetector(
              onTap: () {
                // Add the functionality for what happens when the box is tapped
                print('Add Leaf Weight box tapped!');
              },
              child: Container(
                padding: const EdgeInsets.all(10), // Box padding
                decoration: BoxDecoration(
                  color: Colors.green, // Box color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keep the box size minimal
                  children: const [
                    Icon(Icons.add, color: Colors.white), // Plus icon
                    SizedBox(width: 5), // Space between icon and text
                    Text(
                      'Add Leaf Weight',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Add location box
          Positioned(
            top: 200, // Position the box from the top
            left: 50, // Position the box from the right
            child: GestureDetector(
              onTap: () {
                // Add the functionality for what happens when the box is tapped
                print('Add Location box tapped!');
              },
              child: Container(
                padding: const EdgeInsets.all(10), // Box padding
                decoration: BoxDecoration(
                  color: Colors.green, // Box color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keep the box size minimal
                  children: const [
                    Icon(Icons.add, color: Colors.white), // Plus icon
                    SizedBox(width: 5), // Space between icon and text
                    Text(
                      'Add Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const NavBar(), // Add the bottom navigation bar here
    );
  }
}
