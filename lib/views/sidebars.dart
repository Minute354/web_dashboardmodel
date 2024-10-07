import 'package:flutter/material.dart';
import 'package:school_web_app/views/class_list_screen.dart';
import 'package:school_web_app/views/course_list_screen.dart';
import 'package:school_web_app/views/dashboard_screen.dart';
import 'package:school_web_app/views/division_list_screen.dart';

import 'package:school_web_app/views/setting_screen.dart';
import 'package:school_web_app/views/student_list_screen.dart';
import 'package:school_web_app/views/subject_list_screen.dart';
import 'package:school_web_app/views/syllabus_scteen.dart';
import 'package:school_web_app/views/teacher_list_screen.dart';

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
      child: ListView(
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

          // Lookups dropdown with Teacher and Student sections
          _buildLookupsDropdown(context),
          ExpansionTile(
          leading: Icon(Icons.person_outline, color: Colors.white),
          title: Text('Teacher', style: TextStyle(color: Colors.white)),
          children: [
            _buildSidebarItem(
              icon: Icons.subject,
              label: 'Subject',
              context: context,
              onTap: () {
                setState(() {
                  selectedItem = 'Teacher Subject';
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SubjectListPage()));
              },
              isSelected: selectedItem == 'Teacher Subject',
              
            ),
            _buildSidebarItem(
              icon: Icons.woman_rounded,
              label: 'Add Teacher',
              context: context,
              onTap: () {
                setState(() {
                  selectedItem = 'Teacher ';
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TeacherListPage()));
              },
              isSelected: selectedItem == 'Teacher Subject',
            ),
          ],
        ),

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
            icon: Icons.grading_rounded,
            label: 'Syllabus',
            context: context,
            onTap: () {
              setState(() {
                selectedItem = 'Syllabus';
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SyllabusPage()));
            },
            isSelected: selectedItem == 'Settings',
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
        // Student section
        ExpansionTile(
          leading: Icon(Icons.person, color: Colors.white),
          title: Text('Student', style: TextStyle(color: Colors.white)),
          children: [
            _buildSidebarItem(
              icon: Icons.class_,
              label: 'Class',
              context: context,
              onTap: () {
                setState(() {
                  selectedItem = 'Class';
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ClassListPage()));
              },
              isSelected: selectedItem == 'Class',
            ),
             _buildSidebarItem(
              icon: Icons.insert_drive_file_outlined,
              label: 'Division',
              context: context,
              onTap: () {
                setState(() {
                  selectedItem = 'Division';
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DivisionListPage()));
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
        ),
        // Teacher section
      ]
    );
  }
}
