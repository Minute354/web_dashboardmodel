import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/views/password_screen.dart';
import 'package:school_web_app/views/payment_screen.dart';
import 'package:school_web_app/views/profile_screen.dart';
import 'package:school_web_app/views/screenlogin.dart';
import 'package:school_web_app/views/sidebars.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  // Circular Avatar Section
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        'assets/student logo.png'), // Placeholder image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin', // Placeholder for the user name
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'admin@gmail.com', // Placeholder for the user email
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      color: Colors.grey,
                    ),
                  ),
                 SizedBox(height: 5),

                  // List of Settings Options
                  Expanded(
                    child: Center( // Center the entire list
                      child: Column(
                       
                        children: [
                          _buildCenteredListTile(
                            context,
                            icon: Icons.person,
                            title: 'Profile',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                            },
                          ),
                          _buildCenteredListTile(
                            context,
                            icon: Icons.lock,
                            title: 'Security',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PasswordManagementPage()));
                            },
                          ),
                          _buildCenteredListTile(
                            context,
                            icon: Icons.payment,
                            title: 'Payments',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PaymentScreen()));
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                              // Implement log out functionality
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated method for centered list tile with border, fixed size, and centered alignment
  Widget _buildCenteredListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    bool isHovered = false;

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (_) {
          isHovered = true;
        },
        onExit: (_) {
          isHovered = false;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Animation duration
          height: 40, // Reduced height for buttons
          width: MediaQuery.of(context).size.width / 2, // Width set to half of the screen
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400), // Border color
            borderRadius: BorderRadius.circular(8), // Rounded corners
            color: isHovered
                ? Colors.blueGrey.shade100
                : Colors.white, // Change background color on hover
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0), // Vertical spacing
          padding: EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Space between items
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
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
