import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeaCollection extends StatefulWidget {
  const TeaCollection({super.key});

  @override
  State<TeaCollection> createState() => _TeaCollectionState();
}

class _TeaCollectionState extends State<TeaCollection> {
  // Controllers for form fields
  final TextEditingController _collectorNameController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();

  // API Base URL
  static const String baseUrl = 'http://192.168.132.192:8000/api/tealeaves/';
  List<Map<String, dynamic>> teaCollections = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    _fetchTeaCollections();
  }

  // Sample JSON Data (Used when API is unavailable)
  List<Map<String, dynamic>> mockTeaData = [
    {
      "id": 1,
      "collector_name": "John Doe",
      "quantity": 15.5,
      "quality": "High"
    },
    {
      "id": 2,
      "collector_name": "Jane Smith",
      "quantity": 20.0,
      "quality": "Medium"
    },
    {
      "id": 3,
      "collector_name": "Samuel Adams",
      "quantity": 18.2,
      "quality": "Low"
    },
    {
      "id": 4,
      "collector_name": "Emily Johnson",
      "quantity": 25.0,
      "quality": "High"
    },
    {
      "id": 5,
      "collector_name": "Michael Brown",
      "quantity": 10.5,
      "quality": "Medium"
    }
  ];

  // Fetch tea collections from API
  Future<void> _fetchTeaCollections() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        setState(() {
          teaCollections =
              List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        _showSnackbar('Error: ${response.statusCode}. Using sample data.');
        setState(() {
          teaCollections = mockTeaData; // Use mock data if API fails
        });
      }
    } catch (e) {
      _showSnackbar('Failed to load data. Using sample data.');
      setState(() {
        teaCollections = mockTeaData; // Use mock data when API fails
      });
    }
  }

  // Submit (Create/Update)
  Future<void> _submitData() async {
    final Map<String, dynamic> teaData = {
      'collector_name': _collectorNameController.text,
      'quantity': _quantityController.text,
      'quality': _qualityController.text,
    };

    try {
      final response = isEditing
          ? await http.put(Uri.parse('$baseUrl$editingId/'),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(teaData))
          : await http.post(Uri.parse(baseUrl),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(teaData));

      if (response.statusCode == 201 || response.statusCode == 200) {
        _showSnackbar(
            isEditing ? 'Updated successfully!' : 'Added successfully!');
        _clearForm();
        _fetchTeaCollections();
      } else {
        _showSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackbar('An error occurred: $e');
    }
  }

  // Delete a tea collection entry
  Future<void> _deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$id/'));
      if (response.statusCode == 204) {
        _showSnackbar('Deleted successfully!');
        _fetchTeaCollections();
      } else {
        _showSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackbar('An error occurred: $e');
    }
  }

  // Show snackbar message
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Populate form fields for editing
  void _editTeaCollection(Map<String, dynamic> tea) {
    setState(() {
      isEditing = true;
      editingId = tea['id'];
      _collectorNameController.text = tea['collector_name'];
      _quantityController.text = tea['quantity'].toString();
      _qualityController.text = tea['quality'];
    });
  }

  // Clear form
  void _clearForm() {
    _collectorNameController.clear();
    _quantityController.clear();
    _qualityController.clear();
    setState(() {
      isEditing = false;
      editingId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tea Collection Management"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tea Collection Form
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
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
                    const SizedBox(height: 15),
                    TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _qualityController,
                      decoration: const InputDecoration(
                        labelText: 'Quality',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _submitData,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text(isEditing ? 'Update' : 'Submit'),
                        ),
                        if (isEditing)
                          ElevatedButton(
                            onPressed: _clearForm,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text('Cancel'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tea Collection List
            Expanded(
              child: teaCollections.isEmpty
                  ? const Center(child: Text('No tea collection records found'))
                  : ListView.builder(
                      itemCount: teaCollections.length,
                      itemBuilder: (context, index) {
                        final tea = teaCollections[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: Text(tea['collector_name'][0],
                                  style: const TextStyle(color: Colors.green)),
                            ),
                            title: Text(tea['collector_name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                'Quantity: ${tea['quantity']} kg | Quality: ${tea['quality']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () => _editTeaCollection(tea),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteData(tea['id']),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
