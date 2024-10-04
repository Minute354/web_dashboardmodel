import 'package:flutter/material.dart';
import 'package:school_web_app/screens/class_list_screen.dart';
import 'package:school_web_app/screens/course_list_screen.dart';
import 'package:school_web_app/screens/dashboard_screen.dart';
import 'package:school_web_app/screens/setting_screen.dart';
import 'package:school_web_app/screens/student_list_screen.dart';
import 'package:school_web_app/screens/subject_list_screen.dart';
import 'package:school_web_app/screens/teacher_list_screen.dart';

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
                  backgroundImage: NetworkImage(
                      "https://png.pngitem.com/pimgs/s/111-1114675_user-login-person-man-enter-person-login-icon.png"),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DashboardPage()));
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StudentListPage()));
            },
            isSelected: selectedItem == 'Student',
          ),
          _buildSidebarItem(
            label: 'Teacher',
            icon: Icons.book,
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Teacher';
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TeacherListPage()));
            },
            isSelected: selectedItem == 'Teacher',
          ),
          _buildSidebarItem(
            icon: Icons.settings,
            label: 'Settings',
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Settings';
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
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
          label: 'Class && Division',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Class && Division';
            });
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ClassListPage()));
          },
          isSelected: selectedItem == 'Class && Division',
        ),
        
        _buildSidebarItem(
          icon: Icons.book,
          label: 'Course',
          context: context,
          onTap: () {
            setState(() {
              selectedItem = 'Course';
            });
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CourseListPage()));
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SubjectListPage()));
          },
          isSelected: selectedItem == 'Subject',
        ),
      ],
    );
  }
}
