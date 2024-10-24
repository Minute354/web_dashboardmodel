// controllers/profile_controller.dart
import 'package:flutter/material.dart';
import 'package:school_web_app/services/profile_services.dart';
import '../models/profile_model.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  UserProfile? userProfile;

  Future<void> fetchUserProfile() async {
    try {
      userProfile = await _profileService.fetchUserProfile();
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      // Handle any errors if necessary
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
    try {
      await _profileService.updateProfile(
        firstName: firstName,
        email: email,
        phone: phone,
        id: id,
        address: address,
        selectedTime: selectedTime,
        selectedDate: selectedDate,
      );
      await fetchUserProfile(); // Refresh the user profile after updating
    } catch (e) {
      // Handle any errors if necessary
    }
  }
}
