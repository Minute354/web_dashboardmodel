// lib/models/user_profile.dart

import 'package:flutter/material.dart';

class UserProfile {
  String firstName;
  String lastName;
  String email;
  String phone;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? profileImagePath; // Path to the profile image, if any

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.selectedDate,
    this.selectedTime,
    this.profileImagePath,
  });

  // Method to update profile fields
  void update({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? profileImagePath,
  }) {
    if (firstName != null) this.firstName = firstName;
    if (lastName != null) this.lastName = lastName;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
    if (selectedDate != null) this.selectedDate = selectedDate;
    if (selectedTime != null) this.selectedTime = selectedTime;
    if (profileImagePath != null) this.profileImagePath = profileImagePath;
  }

  // Convert UserProfile to Map (useful for persistence)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'selectedDate': selectedDate?.toIso8601String(),
      'selectedTime': selectedTime != null
          ? '${selectedTime!.hour}:${selectedTime!.minute}'
          : null,
      'profileImagePath': profileImagePath,
    };
  }

  // Factory constructor to create UserProfile from Map
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    TimeOfDay? time;
    if (map['selectedTime'] != null) {
      List<String> parts = (map['selectedTime'] as String).split(':');
      if (parts.length == 2) {
        time = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
    }
    return UserProfile(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      selectedDate:
          map['selectedDate'] != null ? DateTime.parse(map['selectedDate']) : null,
      selectedTime: time,
      profileImagePath: map['profileImagePath'],
    );
  }
}
