import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String loginUrl =
      'https://citi-ryder-api-node.vercel.app/v1/api/driver/login';

  Future<bool> login(String mobileNo, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobileno': mobileNo,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful
        final data = jsonDecode(response.body);
        print('Login successful: ${data['token']}');
        // Process token or any additional response as needed
        return true;
      } else {
        // Login failed
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }
}
