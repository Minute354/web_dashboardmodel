import 'package:flutter/material.dart';
import 'package:school_web_app/views/add_student_screen.dart';
import 'package:school_web_app/views/analytics_screen.dart';
import 'package:school_web_app/views/attendance_screen.dart';
import 'package:school_web_app/views/dashboardcard.dart';
import 'package:school_web_app/views/payment_screen.dart';
import 'package:school_web_app/views/screenlogin.dart';
import 'package:school_web_app/views/setting_screen.dart';
import 'package:school_web_app/views/sidebars.dart';
import 'package:school_web_app/views/sidedrawer.dart';
import 'package:school_web_app/views/student_list_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isSmallScreen),
      drawer: isSmallScreen ? SidebarDrawer() : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isSmallScreen) Sidebar(),
                Expanded(child: _buildDashboardGrid(isSmallScreen)),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(bool isSmallScreen) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        _buildProfileDropdown(),
        if (isSmallScreen)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
      ],
    );
  }

  Widget _buildProfileDropdown() {
    return Container(
      margin: const EdgeInsets.only(
        right: 50.0,
      ), // Adjust the right margin as needed
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon:
              const Icon(Icons.person_2_rounded, color: Colors.white, size: 28),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: const Color.fromARGB(
              255, 87, 86, 86), // Dropdown background color

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
                    color: Colors.white, // Dropdown item text color
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ));
            }
            // Add other profile-related actions here as needed
          },
        ),
      ),
    );
  }

  Widget _buildDashboardGrid(bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 6 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isSmallScreen ? 1.0 : 1.1,
        children: _buildDashboardCards(),
      ),
    );
  }

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
          // Navigate to Analytics page
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AnalyticsPage()));
        },
      ),
      DashboardCard(
        icon: Icons.schedule,
        label: 'Attendance',
        color: Colors.redAccent,
        onTap: () {
          // Navigate to Attendance page
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AttendanceScreen()));
        },
      ),
      DashboardCard(
        icon: Icons.help,
        label: 'Help',
        color: Colors.teal,
        onTap: () {
          // Navigate to Help page
        },
      ),
    ];
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.blueGrey.shade900,
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        '© 2024 School Management System',
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleLogout() {
  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
}

}
