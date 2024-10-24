import 'package:flutter/material.dart';

class UserProfile {
  String firstName;
  String email;
  String phone;
  String id;
  Address? address;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  UserProfile({
    required this.firstName,
    required this.email,
    required this.phone,
    required this.id,
    this.address,
    this.selectedTime,
    this.selectedDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'],
      email: json['email'],
      phone: json['phone'],
      id: json['id'],
      address: Address.fromJson(json['address']),
      selectedTime: TimeOfDay(
          hour: json['selectedTime']['hour'], 
          minute: json['selectedTime']['minute']
      ),
      selectedDate: DateTime.parse(json['selectedDate']),
    );
  }
}

class Address {
  String street;
  String city;
  String state;
  String district;
  String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.district,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      district: json['district'],
      zipCode: json['zipCode'],
    );
  }
}
