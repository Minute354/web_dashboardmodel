// lib/controllers/profile_controller.dart

import 'package:flutter/material.dart';
import 'package:school_web_app/models/profile_model.dart';

class ProfileController with ChangeNotifier {
  UserProfile _userProfile;

  // Constructor initializes with default or existing user data
  ProfileController()
      : _userProfile = UserProfile(
          firstName: 'Adimin',
          lastName: 'Only',
          email: 'admin@gmail.com',
          phone: '9207176654',
          selectedDate: DateTime.now(),
          selectedTime: TimeOfDay.now(),
          profileImagePath: null,
        );

  // Getter to access the user profile
  UserProfile get userProfile => _userProfile;

  // Method to update profile information
  void updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? profileImagePath,
  }) {
    _userProfile.update(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      profileImagePath: profileImagePath,
    );
    notifyListeners(); // Notify listeners to rebuild UI
  }

  // Method to update only the profile image
  void updateProfileImage(String imagePath) {
    _userProfile.update(profileImagePath: imagePath);
    notifyListeners();
  }

  // Optional: Methods to load/save profile from persistent storage
  // For example, using SharedPreferences or a database
}
