import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  final String baseUrl = 'http://localhost:3000'; // Replace with your actual API endpoint

  // Common function to retrieve token from SharedPreferences
  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenData = prefs.getString('token');

    if (tokenData == null) {
      log('Token not found');
      throw Exception('Token not found');
    }

    log("Token retrieved: $tokenData"); // Log the token retrieved

    return {
      'Authorization': 'Bearer $tokenData',
      'Content-Type': 'application/json',
    };
  }

  // Login method to authenticate user and fetch token
  Future<void> login(String email, String password) async {
    final url = '$baseUrl/auth/login'; // Adjust the endpoint for login
    final body = {
      'email': email,
      'password': password,
    };

    try {
      log('Attempting to log in');
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        log("Login successful");

        final responseData = jsonDecode(response.body);
        String token = responseData['token'];

        log("Token received: $token"); // Log the received token

        // Save the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        log("Token saved to SharedPreferences");
      } else {
        log("Login failed: ${response.statusCode}");
        log("Response body: ${response.body}");
        throw Exception('Failed to login');
      }
    } catch (e) {
      log("Error during login: $e");
      throw Exception('Error during login: $e');
    }
  }

  // Fetch users
  Future<List<User>> fetchUsers() async {
    final url = '$baseUrl/user'; // Adjust the endpoint as needed

    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        log("Users fetched successfully");

        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];

        try {
          return data.map((user) => User.fromJson(user)).toList();
        } catch (e) {
          log("Error parsing users: $e");
          throw Exception("Error decoding user data");
        }
      } else {
        log("Failed to fetch users: ${response.statusCode}");
        log("Response body: ${response.body}"); // Log the response body for more details
        throw Exception('Failed to load users');
      }
    } catch (e) {
      log("Error while fetching users: $e");
      throw Exception('Error while fetching users: $e');
    }
  }

  // Add a new user
  Future<void> addUser(User user) async {
    final url = '$baseUrl/user'; // Replace with your actual API endpoint
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(user.toJson()), // Use user.toJson() to include all fields
      );
      log('User data: ${user.toJson()}');

      if (response.statusCode == 201) {
        log("User added successfully");
      } else {
        log("Failed to add user: ${response.statusCode}");
        log("Response body: ${response.body}"); // Log the response body for more details
        throw Exception('Failed to add user');
      }
    } catch (e) {
      log("Error while adding user: $e");
      throw Exception('Error while adding user: $e');
    }
  }

  // Edit an existing user
  Future<void> editUser(User user) async {
    final url = '$baseUrl/user/${user.id}'; // Replace with your actual API endpoint
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(user.toJson()), // Use user.toJson() to include all fields
      );

      if (response.statusCode == 200) {
        log("User updated successfully");
      } else {
        log("Failed to update user: ${response.statusCode}");
        log("Response body: ${response.body}"); // Log the response body for more details
        throw Exception('Failed to update user');
      }
    } catch (e) {
      log("Error while updating user: $e");
      throw Exception('Error while updating user: $e');
    }
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    final url = '$baseUrl/user/$userId'; // Replace with your actual API endpoint
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 204||response.statusCode == 200) {
        log("User deleted successfully");
      } else {
        log("Failed to delete user: ${response.statusCode}");
        log("Response body: ${response.body}"); // Log the response body for more details
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      log("Error while deleting user: $e");
      throw Exception('Error while deleting user: $e');
    }
  }
}
