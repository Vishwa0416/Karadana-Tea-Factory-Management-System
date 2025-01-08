import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeaCollection extends StatefulWidget {
  const TeaCollection({super.key});

  @override
  State<TeaCollection> createState() => _TeaCollectionState();
}

class _TeaCollectionState extends State<TeaCollection> {
  // Controller for the single text field
  final TextEditingController _collectorNameController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();

  // API Base URL
  static const String baseUrl = 'http://192.168.132.192:8000/api/tealeaves/';

  // Method to submit form data to the backend
  Future<void> _submitData() async {
    final Map<String, dynamic> teaData = {
      'collector_name': _collectorNameController.text,
      'quantity': _quantityController.text,
      'quality': _qualityController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(teaData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data submitted successfully!')),
        );
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  // Clear form field
  void _clearForm() {
    _collectorNameController.clear();
    _quantityController.clear();
    _qualityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tea Collection Form"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _collectorNameController,
              decoration: const InputDecoration(
                labelText: 'Collector Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _collectorNameController,
              decoration: const InputDecoration(
                labelText: 'Quality',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
