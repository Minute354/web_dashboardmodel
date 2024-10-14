import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/calendar_holiday_controller.dart';
import 'package:school_web_app/controllers/class_controller.dart';
import 'package:school_web_app/controllers/course_controller.dart';
import 'package:school_web_app/controllers/division_controller.dart';
import 'package:school_web_app/controllers/profile_controller.dart';
import 'package:school_web_app/controllers/sidebar_controller.dart';
import 'package:school_web_app/controllers/subject_controller.dart';
import 'package:school_web_app/controllers/syllabus_controller.dart';
import 'package:school_web_app/controllers/teacher_controller.dart';
 import 'controllers/student_controller.dart';
import 'views/screenlogin.dart';
import 'views/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HolidayController()),
        ChangeNotifierProvider(create: (_) => StudentController()),
        ChangeNotifierProvider(create: (_) => ClassController()),
        ChangeNotifierProvider(create: (_) => DivisionController()),
        ChangeNotifierProvider(create: (_) => SubjectController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => TeacherController()),
        ChangeNotifierProvider(create: (_) => SyllabusController()),
        ChangeNotifierProvider(create: (_) => SidebarController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardPage(),
          // '/students':(context)=> AddStudentPage(),
          // '/classes':(context)=> ClassListPage(),
          // '/divisions':(context)=> DivisionListPage(),
          // '/courses':(context)=> CourseListPage(),
          // '/subjects':(context)=> SubjectListPage(),
          // '/settings':(context)=> SettingsPage(),
        },
      ),
    );
  }
}
