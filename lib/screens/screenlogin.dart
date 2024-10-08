import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (currentLetterIndex < "WELCOME\n TO \n LOGIN...".length) {
        setState(() {
          letters.add("WELCOME\n TO \n LOGIN..."[currentLetterIndex]);
          currentLetterIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the screen size based on constraints
          if (constraints.maxWidth >= 1024) {
            // Desktop view
            return _buildDesktopView(constraints);
          } else if (constraints.maxWidth >= 600) {
            // Tablet view
            return _buildTabletView(constraints);
          } else {
            // Mobile view
            return _buildMobileView(constraints);
          }
        },
      ),
    );
  }

  // Common Form Widget
  Widget _buildLoginForm(double cardSize) {
    return SizedBox(
      width: cardSize, // Set the card size based on the input parameter
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
                // Your form fields here...
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
                  validator: _validateEmail,
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
                  ),
                  obscureText: true,
                  validator: _validatePassword,
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
                      // Handle login logic
                      Navigator.pushNamed(context, '/dashboard');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Only vertical padding
                    fixedSize: const Size(200, 50), // Fixed width and height
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
                      overflow: TextOverflow
                          .ellipsis, // Ensures text does not overflow
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
    const double textSize = 40.0;
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
                _buildImage(imageSize),
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
                _buildImage(imageSize),
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
    final double imageSize = MediaQuery.of(context).size.width * 0.5;
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
                  Flexible(child: _buildAnimatedText(textSize, cardSize * 0.8)),
                  Flexible(child: _buildImage(imageSize)),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade900, Colors.blueAccent.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildAnimatedText(double textSize, double width) {
    return Container(
      width: width, // Adjusts based on the screen size
      alignment: Alignment.centerLeft, // Ensures left alignment
      child: FittedBox(
        fit: BoxFit.scaleDown, // Scales the text down for smaller screens
        alignment:
            Alignment.centerLeft, // Ensures the text inside is left-aligned
        child: Text(
          letters.join(), // Combines the letters into a single string
          textAlign: TextAlign.left, // Ensures the text is left-aligned
          style: GoogleFonts.poppins(
            fontSize: textSize, // Text size is dynamic
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Image Widget
  Widget _buildImage(double imageSize) {
    return SizedBox(
      width: imageSize.clamp(200.0, 600.0),
      height: imageSize.clamp(200.0, 600.0),
      child: Image.asset(
        "assets/view-3d-young-school-student (1) (1).png",
        fit: BoxFit.cover,
      ),
    );
  }
}
