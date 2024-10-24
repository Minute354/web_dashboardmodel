// services/profile_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileService {
  final String baseUrl = 'http://localhost:3000'; // Replace with your actual API endpoint

  Future<UserProfile?> fetchUserProfile() async {
    final url = '$baseUrl/user/'; // Adjust the endpoint as needed

    try {
      // Step 1: Retrieve the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenData = prefs.getString('token');

      // Step 2: Check if token is found
      if (tokenData == null) {
        log('Token not found');
        throw Exception('Token not found');
      }

      // Debugging: Log the token being sent
      log("Token: $tokenData");

      // Step 3: Make the API call with the token
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $tokenData', // Correct format for Bearer token
          'Content-Type': 'application/json',
        },
      );

      // Step 4: Handle the response
      if (response.statusCode == 200) {
        log("Profile fetched successfully");
        var userProfileData = jsonDecode(response.body); // Parse response
        log("User Profile: $userProfileData");
        return UserProfile.fromJson(userProfileData); // Adjust to your UserProfile model
      } else if (response.statusCode == 401) {
        log("Unauthorized - Token might be invalid or expired: ${response.body}");
        throw Exception('Unauthorized access');
      } else {
        log("Failed to fetch profile: ${response.statusCode}");
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      log("Error while fetching profile: $e");
      throw Exception('Error while fetching profile: $e');
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String email,
    required String phone,
    required String id,
    required Map<String, String> address,
    required TimeOfDay selectedTime,
    required DateTime selectedDate,
  }) async {
    final url = '$baseUrl/user/$id'; // Replace with your actual API endpoint
    final body = {
      'firstName': firstName,
      'email': email,
      'phone': phone,
      'address': address,
      'selectedTime': {
        'hour': selectedTime.hour,
        'minute': selectedTime.minute,
      },
      'selectedDate': selectedDate.toIso8601String(),
    };

    try {
      // Step 1: Retrieve the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenData = prefs.getString('token');

      // Step 2: Check if token is found
      if (tokenData == null) {
        log('Token not found');
        throw Exception('Token not found');
      }

      log('Update Profile button pressed');

      // Step 3: Make the API call with the token
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $tokenData', // Use the actual token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Step 4: Handle the response
      if (response.statusCode == 200) {
        log("Profile update success");
        // Optionally handle any additional logic after successful update
      } else {
        log("Profile update failed: ${response.statusCode}");
        log("Response body: ${response.body}");
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      log("Error: $e");
      throw Exception('Error while updating profile: $e');
    }
  }
}
