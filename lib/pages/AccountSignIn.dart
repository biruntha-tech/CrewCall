import 'package:crewcall_flutter/pages/AccountSignUP.dart';
import 'package:flutter/material.dart';
import 'package:crewcall_flutter/pages/main_navigation.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';

class AccountSignInPage extends StatefulWidget {
  const AccountSignInPage({super.key});

  @override
  State<AccountSignInPage> createState() => _AccountSignInPageState();
}

class _AccountSignInPageState extends State<AccountSignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.headphones, color: AppColors.primary, size: 30),
            const SizedBox(width: 8),
            Text(
              "CrewCall",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 2),
          ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 20),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Sign in to your account",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              // Email field
              Text("Email", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: usernameController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your email",
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              Text("Password", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: passwordController,
                validator: _validatePassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password",
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 20),

              // Login Actions Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _isLoading ? null : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            
                            // Simulate login process
                            await Future.delayed(Duration(seconds: 1));
                            
                            setState(() => _isLoading = false);
                            Navigator.pushReplacementNamed(context, '/main');
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Login",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Forgot Password
                    Center(
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Forgot password feature coming soon!')),
                          );
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Navigate to Signup
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TalentSignupPage()));
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ),
              ],
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountSignInPage(),
  ));
}