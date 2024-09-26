import 'package:flutter/material.dart';
import 'package:school_web_app/screens/dashboardcard.dart';
import 'package:school_web_app/screens/screenlogin.dart';
import 'package:school_web_app/screens/sidebars.dart';
import 'package:school_web_app/screens/sidedrawer.dart';

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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade900, Colors.black54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: const Text(
                'Admin Panel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          if (isSmallScreen)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
        ],
      ),
      drawer: isSmallScreen
          ? SidebarDrawer()
          : null, // Use SidebarDrawer for small screens
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isSmallScreen) Sidebar(), // Use Sidebar for larger screens
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 1200 ? 6 : 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isSmallScreen ? 1.0 : 1.1,
                      children: [
                        DashboardCard(
                            icon: Icons.person_add,
                            label: 'Add Student',
                            color: Colors.blueAccent,
                            onTap: () {}),
                        DashboardCard(
                            icon: Icons.group,
                            label: 'Manage Students',
                            color: Colors.green,
                            onTap: () {}),
                        DashboardCard(
                            icon: Icons.payment,
                            label: 'Payments',
                            color: Colors.orangeAccent,
                            onTap: () {}),
                        DashboardCard(
                            icon: Icons.bar_chart,
                            label: 'Analytics',
                            color: Colors.purpleAccent,
                            onTap: () {}),
                        DashboardCard(
                            icon: Icons.schedule,
                            label: 'Attendance',
                            color: Colors.redAccent,
                            onTap: () {}),
                        DashboardCard(
                            icon: Icons.help,
                            label: 'Help',
                            color: Colors.teal,
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
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
}
