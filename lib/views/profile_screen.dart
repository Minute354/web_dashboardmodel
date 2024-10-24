import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_web_app/controllers/profile_controller.dart';
import 'package:school_web_app/models/profile_model.dart'; // Import the model
import 'package:provider/provider.dart'; // Make sure to import provider

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = Provider.of<ProfileController>(context, listen: false);
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      await _profileController.fetchUserProfile();
      if (mounted) {
        setState(() {}); // Safely update the state
      }
    } catch (e) {
      // Handle the error gracefully
      log("Error fetching user profile: $e");
      // Optionally show an alert dialog to inform the user
      _showErrorDialog('Error fetching user profile: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? userProfile = _profileController.userProfile;

    if (userProfile == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('My Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircleAvatar(radius: 90, backgroundColor: Colors.black54),
            SizedBox(height: 20),
            _buildProfileInfo(userProfile),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add edit functionality
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(UserProfile userProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('First Name: ${userProfile.firstName}'),
        Text('Email: ${userProfile.email}'),
        Text('Phone: ${userProfile.phone}'),
        Text('ID: ${userProfile.id}'),
        Text('Street: ${userProfile.address?.street}'),
        Text('City: ${userProfile.address?.city}'),
        Text('State: ${userProfile.address?.state}'),
        Text('District: ${userProfile.address?.district}'),
        Text('Zip Code: ${userProfile.address?.zipCode}'),
        // Add time and date info if needed
      ],
    );
  }
}
