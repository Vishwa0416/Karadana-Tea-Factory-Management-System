import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/supplier/supplier.dart';
import 'package:karadana_tea_factory/screens/teaCollection/tea.dart';
import 'package:karadana_tea_factory/widgets/navbar.dart';
import 'package:karadana_tea_factory/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> teaCollections = [];
  List<Map<String, dynamic>> suppliers = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Fetch Tea Collection & Supplier Data
  Future<void> _fetchData() async {
    try {
      final ApiService apiService = ApiService();
      final teaResponse = await apiService.get('tealeaves/');
      final supplierResponse = await apiService.get('suppliers/');

      setState(() {
        teaCollections = (teaResponse is List)
            ? List<Map<String, dynamic>>.from(teaResponse)
            : mockTeaData;
        suppliers = (supplierResponse is List)
            ? List<Map<String, dynamic>>.from(supplierResponse)
            : mockSupplierData;
      });
    } catch (e) {
      setState(() {
        teaCollections = mockTeaData;
        suppliers = mockSupplierData;
      });
    }
  }

  // Mock Data (Used if API Fails)
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
  ];

  List<Map<String, dynamic>> mockSupplierData = [
    {"id": 1, "name": "Green Tea Suppliers", "contact": "+94 77 123 4567"},
    {"id": 2, "name": "Ceylon Leaf Traders", "contact": "+94 76 987 6543"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TeaCollection()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Supplier()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dashboard')),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🍃 Tea Collection Summary
            _buildSectionHeader("Recent Tea Collections", TeaCollection()),
            _buildTeaCollectionCards(),

            const SizedBox(height: 20),

            // 📦 Supplier Summary
            _buildSectionHeader("Top Suppliers", Supplier()),
            _buildSupplierCards(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // 🔹 Section Header with View All Button
  Widget _buildSectionHeader(String title, Widget page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: const Text("View All"),
        ),
      ],
    );
  }

  // 🍃 Tea Collection Cards
  Widget _buildTeaCollectionCards() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: teaCollections.length,
        itemBuilder: (context, index) {
          final tea = teaCollections[index];
          return _buildTeaCard(
              tea['collector_name'], tea['quantity'], tea['quality']);
        },
      ),
    );
  }

  Widget _buildTeaCard(String collector, double quantity, String quality) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset('assets/images/tea.png', height: 80, fit: BoxFit.cover),
            const SizedBox(height: 5),
            Text(collector,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Quantity: $quantity kg",
                style: const TextStyle(fontSize: 14)),
            Text("Quality: $quality", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // 📦 Supplier Cards
  Widget _buildSupplierCards() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return _buildSupplierCard(supplier['name'], supplier['contact']);
        },
      ),
    );
  }

  Widget _buildSupplierCard(String name, String contact) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset('assets/images/supplier.png',
                height: 80, fit: BoxFit.cover),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Contact: $contact", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
