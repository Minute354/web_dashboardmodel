import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/student_controller.dart';
import 'screens/Login_screen.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:'/login' ,
        routes: {
          '/dashboard': (context) => StudentListPage(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
