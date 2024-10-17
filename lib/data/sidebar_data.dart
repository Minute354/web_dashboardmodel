// lib/data/sidebar_data.dart
import 'package:flutter/material.dart';
import 'package:school_web_app/models/sidebar_model.dart';
import 'package:school_web_app/views/attendance_screen.dart';
import 'package:school_web_app/views/calender_page.dart';
import 'package:school_web_app/views/permissions.dart';
import 'package:school_web_app/views/role_screen.dart';
import 'package:school_web_app/views/syllabus_screen.dart';
import '../views/dashboard_screen.dart';
import '../views/LookUp_Screens/class_list_screen.dart';
import '../views/LookUp_Screens/division_list_screen.dart';
import '../views/LookUp_Screens/course_list_screen.dart';
import '../views/LookUp_Screens/subject_list_screen.dart';
import '../views/student_list_screen.dart';
import '../views/teacher_list_screen.dart';
import '../views/setting_screen.dart';

List<SidebarItem> sidebarItems = [
  SidebarItem(
    icon: Icons.dashboard,
    label: 'Dashboard',
    // ignore: prefer_const_constructors
    page: DashboardPage(),
  ),
  SidebarItem(
    icon: Icons.search,
    label: 'Lookups',
    page: DashboardPage(), // Placeholder, as Lookups has subItems
    subItems: [
      SidebarItem(
        icon: Icons.collections_bookmark_sharp,
        label: 'Class',
        page: ClassListPage(),
      ),
      SidebarItem(
        icon: Icons.insert_drive_file_outlined,
        label: 'Division',
        page: DivisionListPage(),
      ),
      SidebarItem(
        icon: Icons.note_add_outlined,
        label: 'Course',
        page: CourseListPage(),
      ),
      SidebarItem(
        icon: Icons.subject,
        label: 'Subject',
        page: SubjectListPage(),
      ),
    ],
  ),
  SidebarItem(
    icon: Icons.person_outline,
    label: 'Teacher',
    page: TeacherListPage(), // Placeholder, as Teacher has subItems
    subItems: [
      SidebarItem(
        icon: Icons.woman_rounded,
        label: 'Add Teacher',
        page: TeacherListPage(),
      ),
    ],
  ),
  SidebarItem(
    icon: Icons.person,
    label: 'Student',
    page: StudentListPage(),
  ),
  SidebarItem(
    icon: Icons.calendar_month_outlined,
    label: 'Calender',
    page: HolidayCalendarPage(),
  ),
  SidebarItem(
    icon: Icons.currency_bitcoin_outlined,
    label: 'Fees',
    page: TeacherListPage(), // Placeholder, as Teacher has subItems
    subItems: [
      SidebarItem(
        icon: Icons.directions_bus_sharp,
        label: 'Bus Fees',
        page: DashboardPage(),
      ),
      SidebarItem(
        icon: Icons.youtube_searched_for_sharp,
        label: 'Annual Fees',
        page: DashboardPage(),
      ),
    ],
  ),
  SidebarItem(
    icon: Icons.library_add_check_outlined,
    label: 'Attendence',
    page: AttendanceScreen(),
  ),
  SidebarItem(
    icon: Icons.security_outlined,
    label: 'Role && Permission',
    page: TeacherListPage(), // Placeholder, as Teacher has subItems
    subItems: [
      SidebarItem(
        icon: Icons.flash_on_rounded,
        label: 'Role',
        page: RoleScreen(),
      ),
      SidebarItem(
        icon: Icons.grading_rounded,
        label: 'permissions',
        page: PermissionPage(),
      ),
      // SidebarItem(
      //   icon: Icons.move_down_outlined,
      //   label: 'Module Permission',
      //   page: DashboardPage(),
      // ),
    ],
  ),
  SidebarItem(
    icon: Icons.my_library_books_outlined,
    label: 'Syllabus',
    page: SyllabusPage(),
  ),
  SidebarItem(
    icon: Icons.settings,
    label: 'Settings',
    page: SettingsPage(),
  ),
];
