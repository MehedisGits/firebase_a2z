import 'dart:ui';
import 'package:firebase_practice_project_a2z/ui/sign_up_ui.dart';
import 'package:firebase_practice_project_a2z/widgets/input_field.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class LoginPageUI extends StatefulWidget {
  const LoginPageUI({super.key});

  @override
  State<LoginPageUI> createState() => _LoginPageUIState();
}

class _LoginPageUIState extends State<LoginPageUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildGlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: _buildForm(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [TasklyColors.primaryBackground, TasklyColors.cardColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🌱',
            style: TextStyle(fontSize: 60, color: TasklyColors.primaryAccent),
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome back!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: TasklyColors.textColorDark,
            ),
          ),
          const SizedBox(height: 24),
          buildInputField(
            controller: _emailController,
            label: 'Email',
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || !value.contains('@gmail.com')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          buildInputField(
            controller: _passwordController,
            label: 'Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TasklyColors.secondaryAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: _submitForm,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: TasklyColors.textColorDark,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have am account?'),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Signing up...')));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpUi()),
                  );
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: TasklyColors.primaryAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logging in...')));
    }
  }
}
