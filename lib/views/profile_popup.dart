import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownScreen extends StatefulWidget {
  const DropdownScreen({super.key});

  @override
  DropdownScreenState createState() => DropdownScreenState();
}

class DropdownScreenState extends State<DropdownScreen> {
  bool isDropdownOpen = false; // Track the dropdown state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Row: Circular Avatar and Admin Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30, // Radius for the circular avatar
                  backgroundImage: NetworkImage(
                      'https://png.pngitem.com/pimgs/s/111-1114675_user-login-person-man-enter-person-login-icon.png'), // Replace with your image URL
                ),
                const SizedBox(width: 10), // Space between avatar and button
                TextButton(
                  onPressed: () {
                    // Add any action for the admin button if needed
                  },
                  child: Text(
                    'Admin',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between rows

            // Profile Dropdown Box
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen; // Toggle dropdown
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.poppins(),
                    ),
                    Icon(isDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (isDropdownOpen) ...[
              // Show dropdown items
              const SizedBox(height: 10), // Space before dropdown items
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile Button
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://png.pngitem.com/pimgs/s/111-1114675_user-login-person-man-enter-person-login-icon.png'),
                      ),
                      title: Text('View Profile', style: GoogleFonts.poppins()),
                      onTap: () {
                        // Handle profile view action
                      },
                    ),
                    const Divider(height: 1),
                    // Logout Button
                    ListTile(
                      leading:
                          const Icon(Icons.logout, color: Colors.redAccent),
                      title: Text('Logout', style: GoogleFonts.poppins()),
                      onTap: () {
                        // Handle logout action
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20), // Space between rows
          ],
        ),
      ),
    );
  }
}
