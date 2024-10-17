import 'package:flutter/material.dart';
import 'package:school_web_app/views/add_student_screen.dart';
import 'package:school_web_app/views/analytics_screen.dart';
import 'package:school_web_app/views/attendance_screen.dart';
import 'package:school_web_app/views/dashboardcard.dart';
import 'package:school_web_app/views/payment_screen.dart';
import 'package:school_web_app/views/setting_screen.dart';
import 'package:school_web_app/views/sidebars.dart';
import 'package:school_web_app/views/student_list_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // Determine if the screen is considered small
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isSmallScreen),
      drawer: isSmallScreen ? Sidebar() : null,
      
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isSmallScreen) Sidebar(),
                Expanded(child: _buildResponsiveContent(isSmallScreen)),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  /// Builds the AppBar with a profile dropdown and a menu icon for small screens
  AppBar _buildAppBar(bool isSmallScreen) {
    return AppBar(
      backgroundColor: Colors.blueGrey.shade900,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
       automaticallyImplyLeading:isSmallScreen?true: false,
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: isSmallScreen ? 20 : 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        _buildProfileDropdown(),
        
      ],
    );
  }

  /// Builds the profile dropdown menu
  Widget _buildProfileDropdown() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(Icons.person_2_rounded, color: Colors.white, size: 28),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: const Color.fromARGB(255, 87, 86, 86),
          items: <String>['Profile', 'Logout']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue == 'Logout') {
              _handleLogout();
            }
            if (newValue == 'Profile') {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            }
          },
        ),
      ),
    );
  }

  /// Builds the responsive content using LayoutBuilder to adjust the grid layout
  Widget _buildResponsiveContent(bool isSmallScreen) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the number of columns based on screen width
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth > 1200) {
          crossAxisCount = 6;
          childAspectRatio = 1.1;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 4;
          childAspectRatio = 1.1;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
          childAspectRatio = 1.1;
        } else {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        }

        return Padding(
          padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
          child: GridView.builder(
            itemCount: _buildDashboardCards().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return _buildDashboardCards()[index];
            },
          ),
        );
      },
    );
  }

  /// Generates the list of dashboard cards
  List<Widget> _buildDashboardCards() {
    return [
      DashboardCard(
        icon: Icons.person_add,
        label: 'Add Student',
        color: Colors.blueAccent,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddStudentPage()));
        },
      ),
      DashboardCard(
        icon: Icons.group,
        label: 'Manage Students',
        color: Colors.green,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => StudentListPage()));
        },
      ),
      DashboardCard(
        icon: Icons.payment,
        label: 'Payments',
        color: Colors.orangeAccent,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
        },
      ),
      DashboardCard(
        icon: Icons.bar_chart,
        label: 'Analytics',
        color: Colors.purpleAccent,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AnalyticsPage()));
        },
      ),
      DashboardCard(
        icon: Icons.library_add_check_outlined,
        label: 'Attendance',
        color: Colors.redAccent,
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AttendanceScreen()));
        },
      ),
      DashboardCard(
        icon: Icons.help,
        label: 'Help',
        color: Colors.teal,
        onTap: () {
          // Navigate to Help page
          // Implement navigation if you have a HelpPage
        },
      ),
    ];
  }

  /// Builds the footer at the bottom of the screen
  Widget _buildFooter() {
    return Container(
      color: Colors.blueGrey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: const Center(
        child: Text(
          '© 2024 School Management System',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  /// Handles the logout action by navigating to the login screen
  void _handleLogout() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => true);
  }
}
