import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/services/api_services.dart';
import 'dart:convert';

class Supplier extends StatefulWidget {
  const Supplier({super.key});

  @override
  State<Supplier> createState() => _SupplierState();
}

class _SupplierState extends State<Supplier> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // API Base URL
  static const String baseUrl = 'http://192.168.132.192:8000/api/suppliers/';
  List<Map<String, dynamic>> suppliers = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  // Sample JSON Data (Used when API is unavailable)
  List<Map<String, dynamic>> mockSupplierData = [
    {
      "id": 1,
      "name": "Green Tea Suppliers",
      "address": "123 Tea Street, Colombo",
      "contact": "+94 77 123 4567",
      "email": "greentea@example.com"
    },
    {
      "id": 2,
      "name": "Ceylon Leaf Traders",
      "address": "456 Main Road, Kandy",
      "contact": "+94 76 987 6543",
      "email": "ceylonleaf@example.com"
    },
    {
      "id": 3,
      "name": "Tea Master Pvt Ltd",
      "address": "789 Market Avenue, Galle",
      "contact": "+94 71 555 1234",
      "email": "teamaster@example.com"
    }
  ];

  // Fetch suppliers from API
  Future<void> _fetchSuppliers() async {
    try {
      final ApiService apiService = ApiService();
      final response = await apiService.get('suppliers/');
      if (response is List) {
        setState(() {
          suppliers = List<Map<String, dynamic>>.from(response);
        });
      } else {
        _showSnackbar('Error fetching data. Using sample data.');
        setState(() {
          suppliers = mockSupplierData; // Use mock data if API fails
        });
      }
    } catch (e) {
      _showSnackbar('Failed to load data. Using sample data.');
      setState(() {
        suppliers = mockSupplierData; // Use mock data when API fails
      });
    }
  }

  // Submit (Create/Update)
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Map<String, dynamic> supplierData = {
      'name': _nameController.text,
      'address': _addressController.text,
      'contact': _contactController.text,
      'email': _emailController.text,
    };

    try {
      final ApiService apiService = ApiService();
      final response = isEditing
          ? await apiService.put('suppliers/$editingId/', supplierData)
          : await apiService.post('suppliers/', supplierData);

      if (response.containsKey('error')) {
        _showSnackbar('Error: ${response["error"]}');
      } else {
        _showSnackbar(
            isEditing ? 'Updated successfully!' : 'Added successfully!');
        _clearForm();
        _fetchSuppliers();
      }
    } catch (e) {
      _showSnackbar('An error occurred: $e');
    }
  }

  // Delete a supplier entry
  Future<void> _deleteSupplier(int id) async {
    try {
      final ApiService apiService = ApiService();
      final response = await apiService.delete('suppliers/$id/');
      if (response == null) {
        _showSnackbar('Deleted successfully!');
        _fetchSuppliers();
      } else {
        _showSnackbar('Error deleting supplier');
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

  // Populate form fields for updating
  void _editSupplier(Map<String, dynamic> supplier) {
    setState(() {
      isEditing = true;
      editingId = supplier['id'];
      _nameController.text = supplier['name'];
      _addressController.text = supplier['address'];
      _contactController.text = supplier['contact'];
      _emailController.text = supplier['email'];
    });
  }

  // Clear form
  void _clearForm() {
    _nameController.clear();
    _addressController.clear();
    _contactController.clear();
    _emailController.clear();
    setState(() {
      isEditing = false;
      editingId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier Management"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Supplier Form
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Supplier Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter supplier name' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Supplier Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter address' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _contactController,
                        decoration: const InputDecoration(
                          labelText: 'Supplier Contact',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter contact number' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Supplier Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)
                                ? 'Enter valid email'
                                : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(isEditing ? 'Update' : 'Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Supplier List
            Expanded(
              child: ListView.builder(
                itemCount: suppliers.length,
                itemBuilder: (context, index) {
                  final supplier = suppliers[index];
                  return ListTile(
                    title: Text(supplier['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle:
                        Text('${supplier['address']}\n${supplier['contact']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editSupplier(supplier)),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteSupplier(supplier['id'])),
                      ],
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
