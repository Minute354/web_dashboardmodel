// lib/views/profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking (optional)
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart';
import 'sidebars.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for the TextFields
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  bool _isEditing = false; // Flag to toggle edit mode

  File? _profileImage; // For storing selected profile image (optional)

  @override
  void initState() {
    super.initState();
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    final userProfile = profileController.userProfile;

    // Initialize controllers with existing data
    _firstNameController = TextEditingController(text: userProfile.firstName);
    _lastNameController = TextEditingController(text: userProfile.lastName);
    _emailController = TextEditingController(text: userProfile.email);
    _phoneController = TextEditingController(text: userProfile.phone);
    _selectedTime = userProfile.selectedTime;
    _selectedDate = userProfile.selectedDate; // Assuming you have this field
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Function to show the TimePicker
  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay initialTime = _selectedTime ?? TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime, // Set initial time
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime; // Update the selected time
      });
    }
  }

  // Function to show the DatePicker
  Future<void> _pickDate(BuildContext context) async {
    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate, // Set initial date
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate; // Update the selected date
      });
    }
  }

  // Method to save changes
  void _saveProfile() {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);

    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    TimeOfDay? time = _selectedTime;
    DateTime? date = _selectedDate;

    // Simple validation
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        date == null ||
        time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Update the profile using the controller
    profileController.updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      selectedTime: time,
      selectedDate: date,
    );

    // Show a confirmation SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile Updated Successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Exit edit mode after saving
    setState(() {
      _isEditing = false;
    });
  }

  // Method to cancel editing
  void _cancelEdit() {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    final userProfile = profileController.userProfile;

    // Reset controllers with existing data
    _firstNameController.text = userProfile.firstName;
    _lastNameController.text = userProfile.lastName;
    _emailController.text = userProfile.email;
    _phoneController.text = userProfile.phone;
    _selectedTime = userProfile.selectedTime;
    _selectedDate = userProfile.selectedDate;
    _profileImage = null; // Reset profile image if any

    setState(() {
      _isEditing = false;
    });
  }

  // Method to change profile image (optional)
  Future<void> _changeProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  // Helper method to build profile content
  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        // Center the content horizontally
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600, // Adjust as needed for desired field size
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center align the column
            children: [
              // Header
              Text(
                'My Profile',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Profile Image
              GestureDetector(
                onTap: _isEditing
                    ? _changeProfileImage
                    : null, // Enable tap only in edit mode
                child: CircleAvatar(
                  radius: 90, // Increased size from 30 to 45
                  backgroundImage: AssetImage('assets\student logo.png'),
                ),
              ),
              SizedBox(height: 24),

              // Check if in Edit Mode
              _isEditing ? _buildEditFields() : _buildViewFields(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build fields in Edit Mode
  Widget _buildEditFields() {
    return ListTile(
      title: Column(
        children: [
          // First Name Field
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.5, // Half of screen width
            child: TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              enabled: _isEditing,
            ),
          ),
          SizedBox(height: 16),

          // Last Name Field
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.5, // Half of screen width
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              enabled: _isEditing,
            ),
          ),
          SizedBox(height: 16),

          // Email ID Field
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.5, // Half of screen width
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              enabled: _isEditing,
            ),
          ),
          SizedBox(height: 16),

          // Phone Number Field
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.5, // Half of screen width
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              enabled: _isEditing,
            ),
          ),
          SizedBox(height: 16),

          // Date Picker Field
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.5, // Half of screen width
          ),
          SizedBox(height: 16),

          // Time Picker Field

          SizedBox(height: 24),

          // Save and Cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 150,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              SizedBox(width: 150,
                child: ElevatedButton(
                  onPressed: _cancelEdit,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget to build fields in View Mode
  Widget _buildViewFields() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueGrey.shade700),
            title: Text(
              'First Name',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            subtitle: Text(
              _firstNameController.text.trim(),
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          Divider(),
      
          // Last Name
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.blueGrey.shade700),
            title: Text(
              'Last Name',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            subtitle: Text(
              _lastNameController.text.trim(),
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          Divider(),
      
          // Email ID
          ListTile(
            leading: Icon(Icons.email, color: Colors.blueGrey.shade700),
            title: Text(
              'Email ID',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            subtitle: Text(
              _emailController.text.trim(),
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          Divider(),
      
          // Phone Number
          ListTile(
            leading: Icon(Icons.phone, color: Colors.blueGrey.shade700),
            title: Text(
              'Phone Number',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            subtitle: Text(
              _phoneController.text.trim(),
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
      
          // Display selected date and time
          ListTile(
            title: Text(
              "Last Modified Date: ${_selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "No Date Selected"}",
            ),
          ),
      
          // Edit button
          SizedBox(height: 24),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEditing = true; // Enable editing mode
                });
              },
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Row(
        children: [
          Sidebar(),
          Expanded(child: _buildProfileContent()),
        ],
      ),
      // Assuming you have a SideBar widget defined
    );
  }
}
