import 'package:flutter/material.dart';
import '../screens/home/homepage.dart';
import '../screens/supplier/supplier.dart';
import '../screens/auth/loginpage.dart';
import '../screens/teaCollection/tea.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = <Widget>[
    const Home(), // Replace with your HomePage
    const Supplier(), // Replace with your SupplierPage
    const LogIn(), // Replace with your LoginPage
    const TeaCollection(), // Replace with your TeaPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(185, 183, 255, 185),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Supplier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.terrain_rounded), // You can change the icon
            label: 'Tea',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
