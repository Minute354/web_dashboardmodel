import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://localhost:3000/auth/login'; // Your API endpoint

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token']; // Assuming your API returns a token field
      } else {
        return null; // Login failure
      }
    } catch (e) {
      return null; // Error occurred
    }
  }
}
