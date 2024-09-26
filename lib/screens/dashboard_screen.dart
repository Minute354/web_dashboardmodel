import 'package:flutter/material.dart';
import 'package:school_web_app/screens/screenlogin.dart';
import 'package:school_web_app/screens/student_list_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
        title: Row(
          children: [
            Expanded(flex: 1,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'), // Your logo
                radius: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: const Text(
                'Admin Panel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white, // Changed color to white
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
          if (isSmallScreen) // Menubar for small screens
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
        ],
      ),
      drawer: isSmallScreen ? _buildDrawer(context) : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isSmallScreen) _buildSidebar(context),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 6 : 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isSmallScreen ? 1.0 : 1.1, // Adjust aspect ratio for small screens
                      children: [
                        DashboardCard(icon: Icons.person_add, label: 'Add Student', color: Colors.blueAccent, onTap: () {}),
                        DashboardCard(icon: Icons.group, label: 'Manage Students', color: Colors.green, onTap: () {}),
                        DashboardCard(icon: Icons.payment, label: 'Payments', color: Colors.orangeAccent, onTap: () {}),
                        DashboardCard(icon: Icons.bar_chart, label: 'Analytics', color: Colors.purpleAccent, onTap: () {}),
                        DashboardCard(icon: Icons.schedule, label: 'Attendance', color: Colors.redAccent, onTap: () {}),
                        DashboardCard(icon: Icons.help, label: 'Help', color: Colors.teal, onTap: () {}),
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

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey.shade900,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  radius: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white54),
          _buildSidebarItem(icon: Icons.dashboard, label: 'Dashboard', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.class_, label: 'Class', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.group, label: 'Division', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.school, label: 'Teacher', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.person, label: 'Student', context: context, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentListPage()));
          }),
          _buildSidebarItem(icon: Icons.settings, label: 'Settings', context: context, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            accountName: const Text('Admin'),
            accountEmail: const Text('admin@school.com'),
          ),
          _buildSidebarItem(icon: Icons.dashboard, label: 'Dashboard', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.class_, label: 'Class', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.group, label: 'Division', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.school, label: 'Teacher', context: context, onTap: () {}),
          _buildSidebarItem(icon: Icons.person, label: 'Student', context: context, onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentListPage()));
          }),
          _buildSidebarItem(icon: Icons.settings, label: 'Settings', context: context, onTap: () {}),
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

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required BuildContext context,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Future.delayed(const Duration(milliseconds: 100), () {
        });
        onTap();
      },
    );
  }
}

class DashboardCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
     bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: BoxConstraints(
                minHeight: 100, // Minimum height to prevent overflow
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [widget.color.withOpacity(0.7), widget.color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 isSmallScreen? Icon(widget.icon, size: isHovered ?  60 : 50, color: Colors.white): Icon(widget.icon, size: isHovered ?  40 : 30, color: Colors.white), // Adjust icon size on hover
                  
                  FittedBox(
                    child: Text(
                      widget.label,
                      style:  TextStyle(
                        fontSize:isSmallScreen?10: 16, // Reduced font size for small screens
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 2, // Set max lines
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
