import 'package:flutter/material.dart';
import 'package:school_web_app/data/aboute_content.dart';
import 'package:school_web_app/views/sidebars.dart';

class AboutPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
     About about = About();
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
              padding:const EdgeInsets.all(70), // Added padding
              child: Center( // Align content to the center
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About the App Section
                     const Text(
                        'About the App',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const  SizedBox(height: 16),
                      Text(
                       about.content ,
                        style:const TextStyle(fontSize: 18),
                      ),
                     const SizedBox(height: 24),
                     const Divider(),
                      SizedBox(height: 16),

                      // Privacy Policy Section
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Data Collection
                      Text(
                        '1. Data Collection',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "We collect student information, teacher records, class schedules, attendance data, and payment records. This information is essential for providing the app's core services and managing educational workflows.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),

                      // Data Usage
                      Text(
                        '2. Data Usage',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "The data collected is used strictly for school-related management purposes. We do not share any personal information with third parties unless required by law. The data is used to improve the efficiency of school operations, including attendance tracking and fee management.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),

                      // Data Security
                      Text(
                        '3. Data Security',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "We take the security of your data seriously. We implement encryption and secure storage methods to ensure that personal information is protected. Our app undergoes regular updates to maintain a high standard of data security.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),

                      // User Rights
                      Text(
                        '4. User Rights',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "You have the right to access, update, or delete your data at any time. If you need assistance in exercising these rights, please contact your school's administration or app support.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),

                      // Changes to Policy
                      Text(
                        '5. Changes to this Policy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "We may update this privacy policy from time to time. Any changes will be reflected in this section of the app. We recommend regularly checking this page for any updates to ensure you are aware of how your data is being used.",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 24),

                      // Contact Information
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "If you have any questions about this Privacy Policy or how we handle your data, feel free to contact us at support@schoolmanagementapp.com.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
