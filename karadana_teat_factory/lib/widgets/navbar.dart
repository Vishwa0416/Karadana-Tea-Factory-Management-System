import 'package:flutter/material.dart';
import '../screens/home/homepage.dart';
import '../screens/supplier/supplier.dart';
import '../screens/teaCollection/tea.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_nature),
          label: 'Tea Collection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_add),
          label: 'Suppliers',
        ),
      ],
      selectedItemColor: Colors.teal[700],
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.lightGreen[50],
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      iconSize: 24,
    );
  }
}
