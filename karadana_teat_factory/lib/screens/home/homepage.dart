import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/profile/profile.dart';
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
    } else if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home')),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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

            // 🔹 Dashboard Summary Grid
            _buildDashboardSummary(),

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

  // 🔹 Dashboard Summary Grid
  Widget _buildDashboardSummary() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildSummaryCard(
            "Total Suppliers", "${suppliers.length}", Icons.group, Colors.blue),
        _buildSummaryCard(
            "Top Supplier", _getTopSupplier(), Icons.star, Colors.orange),
        _buildSummaryCard("TeaCollection", "${_calculateTeaTotal()} kg",
            Icons.eco, Colors.green),
        _buildSummaryCard(
            "Reminders", "3 Pending", Icons.notifications, Colors.red),
      ],
    );
  }

  // 📌 Summary Card Widget
  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(value, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // 🔢 Calculate Today's Tea Collection Total
  double _calculateTeaTotal() {
    return teaCollections.fold(0.0, (sum, tea) => sum + (tea['quantity'] ?? 0));
  }

  // 🌟 Get Top Supplier
  String _getTopSupplier() {
    if (teaCollections.isEmpty) return "N/A";
    teaCollections.sort((a, b) => b['quantity'].compareTo(a['quantity']));
    return teaCollections.first['collector_name'];
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
            Image.asset('./src/images/man1.webp',
                height: 80, fit: BoxFit.cover),
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
        height: 140,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset('./src/images/man3.jpg', height: 60, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("$contact", style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
