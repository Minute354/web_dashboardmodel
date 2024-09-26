import 'package:flutter/material.dart';
import 'package:school_web_app/screens/student_list_screen.dart';

class SidebarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required BuildContext context,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(label, style: const TextStyle(color: Colors.black)),
      onTap: () {
        Future.delayed(const Duration(milliseconds: 100), () {
        });
        onTap();
      },
    );
  }
}
