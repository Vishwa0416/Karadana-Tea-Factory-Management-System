import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://192.168.132.192:8000/api/';

  // GET Request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Failed to load data (Status ${response.statusCode})'};
      }
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // POST Request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'error': 'Failed to submit data (Status ${response.statusCode})'
        };
      }
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // PUT Request (Update)
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'error': 'Failed to update data (Status ${response.statusCode})'
        };
      }
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }

  // DELETE Request
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 204) {
        return null;
      } else {
        return {'error': 'Failed to delete (Status ${response.statusCode})'};
      }
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }
}
