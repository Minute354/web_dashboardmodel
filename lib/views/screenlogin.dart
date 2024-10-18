import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  bool _isPasswordVisible = false;

  List<String> letters = [];
  int currentLetterIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    startLetterAnimation();
    _checkLoginStatus();
  }

  void startLetterAnimation() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (currentLetterIndex < "Let's\nLogin...".length) {
        setState(() {
          letters.add("Let's\nLogin......"[currentLetterIndex]);
          currentLetterIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    const url = "http://localhost:3000/auth/login";
    final body = {
      "email": username,
      "password": password,
    };

    try {
      log('Login button pressed');
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        log("Login success");

        final responseData = jsonDecode(response.body);
        String token = responseData['token'];

        await _saveToken(token);
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        log("Login failed: ${response.statusCode}");
        log("Response body: ${response.body}");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    String pattern = r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-z0-9-]+\.[a-z]{2,}$";
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address with only lowercase letters';
    }

    if (!value.endsWith('.com')) {
      return 'Email must end with .com';
    }

    if (value.contains('..')) {
      return 'Email contains consecutive dots, which is invalid';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 5) {
      return 'Password must be at least 5 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            return _buildDesktopView(constraints);
          } else if (constraints.maxWidth >= 600) {
            return _buildTabletView(constraints);
          } else {
            return _buildMobileView(constraints);
          }
        },
      ),
    );
  }

  Widget _buildLoginForm(double cardSize) {
    return SizedBox(
      width: cardSize,
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blue.shade700),
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.blue.shade700),
                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle "Forgot Password?" logic
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                          color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await login(
                        username: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    fixedSize: const Size(200, 50),
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileView(BoxConstraints constraints) {
    const double textSize = 300.0;
    final double imageSize = MediaQuery.of(context).size.width * 0.5;
    final double cardSize = MediaQuery.of(context).size.width * 0.8;

    return Stack(
      children: [
        _buildBackground(),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedText(textSize, cardSize),
                const SizedBox(height: 20),
                _buildImage(imageSize, "assets/3d-cartoon-back-school (1).png"),
                _buildLoginForm(cardSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletView(BoxConstraints constraints) {
    const double textSize = 50.0;
    final double imageSize = MediaQuery.of(context).size.width * 0.5;
    final double cardSize = MediaQuery.of(context).size.width * 0.5;

    return Stack(
      children: [
        _buildBackground(),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedText(textSize, cardSize),
                const SizedBox(height: 20),
                _buildImage(imageSize, "assets/3d-cartoon-back-school (1).png"),
                _buildLoginForm(cardSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopView(BoxConstraints constraints) {
    const double textSize = 300.0;
    final double imageSize = 600.0;
    final double cardSize = 400.0;

    return Stack(
      children: [
        _buildBackground(),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedText(textSize, cardSize),
                  const SizedBox(height: 20),
                ],
              ),
              _buildImage(imageSize, "assets/3d-cartoon-back-school (1).png"),
              _buildLoginForm(cardSize),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 143, 137, 137),Color.fromARGB(255, 91, 118, 133), ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildImage(double size, String imagePath) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
    );
  }

  Widget _buildAnimatedText(double textSize, double cardSize) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: SizedBox(
        width: cardSize,
        child: Text(
          letters.join(),
          
          style: GoogleFonts.alata(
            fontSize: textSize / 6,
            fontWeight: FontWeight.bold,
            
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
