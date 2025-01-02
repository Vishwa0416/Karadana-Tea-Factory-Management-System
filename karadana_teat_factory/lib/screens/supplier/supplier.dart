import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Supplier extends StatefulWidget {
  const Supplier({super.key});

  @override
  State<Supplier> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Supplier> {
  //controller for form
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Supplier Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("suppler Name: ${_nameController}");
              },
              child: const Text('submit'),
            )
          ],
        ),
      ),
    );
  }
}
