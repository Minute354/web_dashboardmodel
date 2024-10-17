import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

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
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
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
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle login logic here
                      Navigator.pushNamed(context, '/dashboard');
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
                _buildImage(imageSize,
                    "assets/view-3d-young-school-student (1) (1).png"),
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
                _buildImage(imageSize,
                    "assets/view-3d-young-school-student (1) (1).png"),
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
    const double textSize = 60.0;
    final double imageSize = MediaQuery.of(context).size.width * 1;
    const double cardSize = 500;

    return Stack(
      children: [
        _buildBackground(),
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: _buildAnimatedText(textSize, cardSize)),
                  Flexible(
                      child: _buildImage(
                          imageSize, "assets/3d-cartoon-back-school (1).png")),
                  Flexible(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: _buildLoginForm(cardSize))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Background Gradient
  Widget _buildBackground() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 58, 102, 172),
      highlightColor: const Color.fromARGB(255, 76, 111, 168),
      period: Duration(milliseconds: 2000),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 78, 91, 226),
              const Color.fromARGB(255, 88, 134, 207)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText(double textSize, double width) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          letters.join(),
          textAlign: TextAlign.left,
          style: GoogleFonts.acme(
            fontSize: textSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Image Widget
  Widget _buildImage(double imageSize, String image) {
    return SizedBox(
      width: imageSize.clamp(200.0, 600.0),
      height: imageSize.clamp(200.0, 600.0),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
