import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/views/dashboard_screen.dart';
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

  bool _isPasswordVisible = false; // Track visibility of password

  List<String> letters = [];
  int currentLetterIndex = 0;

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
      // Set headers to indicate JSON content
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body), // Encode body as JSON
      );

      if (response.statusCode == 200) {
        log("login success");

        // Navigate to the dashboard and replace the login screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        log("login failed ${response.statusCode}");
        log("Response body: ${response.body}"); // Log the response body for more details
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    startLetterAnimation();
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
    _emailController.clear();  // Clear the email field
    _passwordController.clear();  // Clear the password field
    _controller.dispose();  // Dispose of the animation controller
    super.dispose();
  }

  // Validate email input
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Regex to disallow uppercase and require ending with @gmail.com
    String pattern = r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-z0-9-]+\.[a-z]{2,}$";
    RegExp regex = RegExp(pattern);

    // Check if email matches regex pattern
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address with only lowercase letters';
    }

    // Additional validation: Ensure the email ends with '@gmail.com'
    if (!value.endsWith('.com')) {
      return 'Email must end with .com';
    }

    // Additional validation: Check for consecutive dots in the email
    if (value.contains('..')) {
      return 'Email contains consecutive dots, which is invalid';
    }

    return null;
  }

  // Validate password input
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Enhanced password rules
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

  // Common Form Widget
  Widget _buildLoginForm(double cardSize) {
    return SizedBox(
      width: cardSize,
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.indigo.shade700),
                    prefixIcon: const Icon(Icons.email, color: Colors.indigo),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.indigo, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: _validateEmail, // Added email validation
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.indigo.shade700),
                    prefixIcon: const Icon(Icons.lock, color: Colors.indigo),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.indigo, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Eye icon to toggle password visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText:
                      !_isPasswordVisible, // Toggle password visibility
                  validator: _validatePassword, // Added password validation
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle "Forgot Password?" logic
                    },
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                            color: Colors.indigo, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                     if (_formKey.currentState!.validate()) {
                      // Handle login logic here
                      await login(
                        username: _emailController.text,
                        password: _passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    fixedSize: const Size(200, 50),
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
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

  // Mobile View
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
                _buildImage(imageSize, "assets\3d-cartoon-back-school (1).png"),
                _buildLoginForm(cardSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Tablet View
  Widget _buildTabletView(BoxConstraints constraints) {
    const double textSize = 50.0;
    final double imageSize = MediaQuery.of(context).size.width * 0.5;
    const double cardSize = 500;

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
                _buildImage(imageSize, "assets\3d-cartoon-back-school (1).png"),
                _buildLoginForm(cardSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Desktop View
  Widget _buildDesktopView(BoxConstraints constraints) {
    const double textSize = 50.0;
    const double imageSize = 400;
    const double cardSize = 600;

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
                _buildImage(imageSize, "assets\3d-cartoon-back-school (1).png"),
                _buildLoginForm(cardSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Animated Text
  Widget _buildAnimatedText(double textSize, double cardSize) {
    return Shimmer.fromColors(
      baseColor: Colors.indigo,
      highlightColor: Colors.blueAccent,
      child: Text(
        letters.join(""),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Background Image Widget
  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        "assets\3d-cartoon-back-school (1).png",
        fit: BoxFit.cover,
      ),
    );
  }

  // Image Widget
  Widget _buildImage(double imageSize, String imagePath) {
    return Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
    );
  }
}
