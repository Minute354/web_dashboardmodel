import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:school_web_app/services/user_api_services.dart';
import '../models/user_model.dart';

class UserController with ChangeNotifier {
  final UserService _apiService = UserService();
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = false; // Loading state variable

  List<User> get users => _filteredUsers.isNotEmpty ? _filteredUsers : _users;
  bool get isLoading => _isLoading; // Getter for loading state

  // Fetch users from the API
  Future<void> fetchUsers() async {
    _setLoading(true); // Set loading state to true
    try {
      log("Fetching users...");
      _users = await _apiService.fetchUsers();
      _filteredUsers.clear(); // Clear the filtered list
      notifyListeners(); // Notify listeners when data is updated
    } catch (error) {
      log('Failed to load users: $error');
      // Optionally, show an error message to the user
      throw Exception('Failed to load users: $error');
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  // Filter users based on the search query
  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers.clear(); // Clear filtered users if query is empty
    } else {
      _filteredUsers = _users
          .where((user) =>
              user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners when filtering is done
  }

  // Add a new user using API
  Future<void> addUser(User user) async {
    _setLoading(true); // Set loading state to true
    try {
      await _apiService.addUser(user);
      await fetchUsers(); // Refresh the user list after adding
    } catch (error) {
      log("Error while adding user: $error");
      throw Exception('Failed to add user: $error');
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  // Edit a user using API
  Future<void> editUser(User user) async {
    _setLoading(true); // Set loading state to true
    try {
      await _apiService.editUser(user);
      await fetchUsers(); // Refresh the user list after editing
    } catch (error) {
      log("Error while updating user: $error");
      throw Exception('Failed to update user: $error');
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  // Delete a user using API
  Future<void> deleteUser(String userId) async {
    _setLoading(true); // Set loading state to true
    try {
      await _apiService.deleteUser(userId);
      await fetchUsers(); // Refresh the user list after deletion
    } catch (error) {
      log("Error while deleting user: $error");
      throw Exception('Failed to delete user: $error');
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners(); // Notify listeners when loading state changes
  }

  void updateUser(User newUser) {}
}
