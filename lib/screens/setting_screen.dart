import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/screens/screenlogin.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Circular Avatar Section
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'student logo.png'), // Placeholder image
            ),
            SizedBox(height: 16),
            Text(
              'Admin', // Placeholder for the user name
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'admin@gmail.com', // Placeholder for the user email
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),

            // List of Settings Options
            Expanded(
              child: ListView(
                children: [
                  _buildCenteredListTile(
                    context,
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () {
                      // Navigate to Profile Page
                    },
                  ),
                  _buildCenteredListTile(
                    context,
                    icon: Icons.lock,
                    title: 'Security',
                    onTap: () {
                      // Navigate to Security Page
                    },
                  ),
                  _buildCenteredListTile(
                    context,
                    icon: Icons.payment,
                    title: 'Payments',
                    onTap: () {
                      // Navigate to Payments Page
                    },
                  ),
                  _buildCenteredListTile(
                    context,
                    icon: Icons.help,
                    title: 'Help',
                    onTap: () {
                      // Navigate to Feedback Page
                    },
                  ),
                  _buildCenteredListTile(
                    context,
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      // Implement log out functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated method for centered list tile with border, fixed size, and centered alignment
  Widget _buildCenteredListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    bool isHovered = false; // State variable to track hover status

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (_) {
          isHovered = true; // Set hovered state to true
        },
        onExit: (_) {
          isHovered = false; // Set hovered state to false
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Animation duration
          height: 40, // Reduced height for buttons
          width: MediaQuery.of(context).size.width / 3, // Width set to one-third of the screen
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400), // Border color
            borderRadius: BorderRadius.circular(8), // Rounded corners
            color: isHovered ? Colors.blueGrey.shade100 : Colors.white, // Change background color on hover
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0), // Vertical spacing
          padding: EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: Colors.blue), // Reduced icon size
                  SizedBox(width: 10), // Space between icon and title
                  Text(
                    title,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
