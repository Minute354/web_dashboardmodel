import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/class_controller.dart';
import 'package:school_web_app/controllers/course_controller.dart';
import 'package:school_web_app/controllers/subject_controller.dart';
import 'package:school_web_app/controllers/teacher_controller.dart';
import 'controllers/student_controller.dart';
import 'screens/screenlogin.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentController()),
        ChangeNotifierProvider(create: (_) => ClassController()),
        ChangeNotifierProvider(create: (_) => SubjectController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => TeacherController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/dashboard': (context) => DashboardPage(),
          '/login': (context) => const LoginScreen(),
         

        },
      ),
    );
  }
}
