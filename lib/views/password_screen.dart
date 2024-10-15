import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart'; // Assuming you have this controller
import 'sidebars.dart';

class PasswordManagementPage extends StatefulWidget {
  @override
  _PasswordManagementPageState createState() => _PasswordManagementPageState();
}

class _PasswordManagementPageState extends State<PasswordManagementPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  bool _isChangingPassword = false; // Flag to toggle password change mode

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to save the new password
  void _saveNewPassword() {
    String currentPassword = _currentPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Simple validation
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New password and confirm password do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Here you can add the logic to change the password
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    profileController.changePassword(currentPassword, newPassword);

    // Reset fields
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    setState(() {
      _isChangingPassword = false; // Exit changing password mode
    });
  }

  // Method to show password change fields
  Widget _buildPasswordManagementContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600, // Adjust as needed for desired field size
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Avatar
              const CircleAvatar(
                radius: 120, // Adjust radius as needed
                backgroundImage: NetworkImage(
                    'assets/lock3.png'), // Change to your avatar image URL
              ),
              const SizedBox(height: 25),
              const Text(
                'Password Management',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 35),

              // Display buttons based on the editing state
              if (!_isChangingPassword) ...[
                SizedBox(
                  width: 300, // Set a fixed width for buttons
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Action for logged-in devices
                    },
                    icon: Icon(Icons.devices, color: Colors.white),
                    label: Text('Logged In Devices',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      padding: EdgeInsets.symmetric(vertical: 25),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Action for two-factor authentication
                    },
                    icon: Icon(Icons.security, color: Colors.white),
                    label: Text('Two Factor Authentication',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      padding: EdgeInsets.symmetric(vertical: 25),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isChangingPassword =
                            true; // Show password change fields
                      });
                    },
                    icon: Icon(Icons.lock, color: Colors.white),
                    label: Text('Change Password',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      padding: EdgeInsets.symmetric(vertical: 25),
                    ),
                  ),
                ),
              ] else ...[
                // Change Password Fields
                TextField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: false,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Align buttons in a row
                  children: [
                    SizedBox(
                      width: 150, // Set a fixed width for buttons
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isChangingPassword =
                                false; // Hide password change fields
                          });
                        },
                        icon:
                            Icon(Icons.dangerous_outlined, color: Colors.white),
                        label: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade900,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: ElevatedButton.icon(
                        onPressed: _saveNewPassword,
                        icon:
                            Icon(Icons.lock_reset_rounded, color: Colors.white),
                        label: Text(
                          'Change Password',
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      ),
       drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(), // Your sidebar widget
          Expanded(child: _buildPasswordManagementContent()),
        ],
      ),
    );
  }
}
