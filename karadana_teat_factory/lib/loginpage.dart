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
                horizontal: 40), // Add some horizontal padding
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 80.0), // Adjust this value as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LogIn Text
                  const Text(
                    'LogIn',
                    textAlign: TextAlign
                        .center, // Center align the text for better fit
                    style: TextStyle(
                      fontSize: 30, // Increased font size for better visibility
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjusted color for readability
                    ),
                  ),
                  const Text(
                    'Please LogIn to continue.',
                    textAlign: TextAlign
                        .center, // Center align the text for better fit
                    style: TextStyle(
                      fontSize: 15, // Increased font size for better visibility
                      color: Color.fromARGB(
                          255, 157, 157, 157), // Adjusted color for readability
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      fillColor: Colors.white, // Set fill color to white
                      filled: true, // Enable fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Optional border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white, // Set fill color to white
                      filled: true, // Enable fill color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Optional border color
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),

                  const SizedBox(
                      height: 90), // Adjust this height to change the distance
                  // Get Started Button
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
                      'LogIn',
                      style: TextStyle(
                        fontSize: 18, // Adjusted button text size
                        color: Colors.white, // White text for visibility
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
