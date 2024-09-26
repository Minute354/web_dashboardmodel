import 'package:flutter/material.dart';
import 'package:school_web_app/screens/student_list_screen.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String selectedItem = 'Dashboard'; // Default selected item

  @override
  Widget build(BuildContext context) {
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
          _buildSidebarItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Dashboard';
              });
            },
            isSelected: selectedItem == 'Dashboard',
          ),
          
          // Lookups dropdown with selected items
          _buildLookupsDropdown(context),

          _buildSidebarItem(
            icon: Icons.person,
            label: 'Student',
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Student';
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentListPage()));
            },
            isSelected: selectedItem == 'Student',
          ),
          _buildSidebarItem(
            icon: Icons.settings,
            label: 'Settings',
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Settings';
              });
            },
            isSelected: selectedItem == 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required BuildContext context,
    required Function onTap,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
      title: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
      ),
      onTap: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          onTap();
        });
      },
    );
  }

  Widget _buildLookupsDropdown(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.search, color: Colors.white),
      title: Text('Lookups', style: TextStyle(color: Colors.white)),
      children: [
        _buildSidebarItem(
          icon: Icons.class_,
          label: 'Class',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Class';
            });
          },
          isSelected: selectedItem == 'Class',
        ),
        _buildSidebarItem(
          icon: Icons.group,
          label: 'Division',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Division';
            });
          },
          isSelected: selectedItem == 'Division',
        ),
        _buildSidebarItem(
          icon: Icons.book,
          label: 'Course',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Course';
            });
          },
          isSelected: selectedItem == 'Course',
        ),
        _buildSidebarItem(
          icon: Icons.subject,
          label: 'Subject',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Subject';
            });
          },
          isSelected: selectedItem == 'Subject',
        ),
      ],
    );
  }
}
