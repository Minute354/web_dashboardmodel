// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Replace with your actual backend URL
  static const String baseUrl = 'http://localhost:3000/auth/login';
  final storage = FlutterSecureStorage();

  // Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Successful login
        return {'success': true, 'data': responseBody};
      } else {
        // Login failed
        return {
          'success': false,
          'errors': responseBody['errors'] ?? [
            {'msg': 'Unknown error occurred'}
          ],
        };
      }
    } catch (e) {
      // Handle network or other errors
      return {
        'success': false,
        'errors': [
          {'msg': 'An error occurred. Please try again.'}
        ],
      };
    }
  }

  // Save token securely
  Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  // Retrieve token
  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  // Delete token (Logout)
  Future<void> deleteToken() async {
    await storage.delete(key: 'jwt_token');
  }
}
