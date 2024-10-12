import 'package:flutter/material.dart';

void main() {
  runApp(const LogIn());
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Background Image Demo',
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
              padding: const EdgeInsets.symmetric(
                horizontal: 40, // Add some horizontal padding
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Welcome to The Karadana Tea Factory\nManagement System',
                    textAlign: TextAlign
                        .center, // Center align the text for better fit
                    style: TextStyle(
                      fontSize: 20, // Increased font size for better visibility
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjusted color for readability
                    ),
                  ),
                  const SizedBox(
                      height: 80), // Increased spacing between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Add button functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70,
                          vertical: 15), // Adjust button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded button
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18, // Adjusted button text size
                        color: Colors.white, // White text for visibility
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
