import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/home/homepage.dart';
import 'package:karadana_tea_factory/screens/supplier/supplier.dart';
import 'package:karadana_tea_factory/screens/teaCollection/tea.dart';
import 'package:karadana_tea_factory/widgets/navbar.dart';
import 'package:karadana_tea_factory/screens/auth/loginpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // ✅ Profile Tab Index in Navbar

  // User Details (Mock Data for Now)
  String userName = "John Doe";
  String userEmail = "johndoe@example.com";
  String userContact = "+94 77 123 4567";

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          if (index == 0) return const HomePage();
          if (index == 1) return const TeaCollection();
          if (index == 2) return const Supplier();
          return const ProfilePage();
        }),
      );
    }
  }

  // Function to Log Out
  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('Profile')),
          backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/user.png')),
                  const SizedBox(height: 10),
                  Text(userName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(userEmail, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Profile Options
            _buildProfileOption(Icons.edit, "Edit Profile", _editProfile),
            _buildProfileOption(Icons.lock, "Change Password", _changePassword),
            _buildProfileOption(Icons.logout, "Logout", _logout,
                isLogout: true),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  // Function to Edit Profile
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController =
            TextEditingController(text: userName);
        TextEditingController emailController =
            TextEditingController(text: userEmail);
        TextEditingController contactController =
            TextEditingController(text: userContact);

        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name")),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email")),
              TextField(
                  controller: contactController,
                  decoration: const InputDecoration(labelText: "Contact")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userEmail = emailController.text;
                  userContact = contactController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to Change Password
  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController oldPassController = TextEditingController();
        TextEditingController newPassController = TextEditingController();

        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: oldPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Old Password")),
              TextField(
                  controller: newPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "New Password")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Password Changed Successfully!")));
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // Profile Options
  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.green),
        title: Text(title,
            style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
        onTap: onTap,
      ),
    );
  }
}
