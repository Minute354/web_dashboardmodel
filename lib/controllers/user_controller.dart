import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:school_web_app/services/user_api_services.dart';
import '../models/user_model.dart';

class UserController with ChangeNotifier {
  final UserService _apiService = UserService();
  List<User> _users = [];
  List<User> _filteredUsers = [];

  List<User> get users => _filteredUsers.isNotEmpty ? _filteredUsers : _users;

  // Fetch users from the API
  Future<void> fetchUsers() async {
    try {
      log("Fetching users...");
      _users = await _apiService.fetchUsers();
      _filteredUsers = [];
      notifyListeners(); // Notify listeners when data is updated
    } catch (error) {
      log('Failed to load users: $error');
      throw Exception('Failed to load users: $error');
    }
  }

  // Filter users based on the search query
  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = [];
    } else {
      _filteredUsers = _users
          .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners when filtering is done
  }

  // Add a new user using API
  Future<void> addUser(User user) async {
    try {
      await _apiService.addUser(user);
      await fetchUsers(); // Refresh the user list after adding
    } catch (error) {
      throw Exception('Failed to add user: $error');
    }
  }

  // Edit a user using API
  Future<void> editUser(User user) async {
    try {
      await _apiService.editUser(user);
      await fetchUsers(); // Refresh the user list after editing
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  // Delete a user using API
  Future<void> deleteUser(String userId) async {
    try {
      await _apiService.deleteUser(userId);
      await fetchUsers(); // Refresh the user list after deletion
    } catch (error) {
      throw Exception('Failed to delete user: $error');
    }
  }
}
