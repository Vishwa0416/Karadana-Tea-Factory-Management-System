import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'http://127.0.0.1:8000'; // Replace with your backend URL

  // Generic POST request method
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed with status code: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": "An error occurred: $e"};
    }
  }
}
