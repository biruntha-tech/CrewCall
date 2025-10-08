import 'package:crewcall_flutter/authentication/emailauth.dart';
import 'package:crewcall_flutter/authentication/googleauth.dart';
import 'package:crewcall_flutter/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:crewcall_flutter/pages/T&OAccountsignUp.dart';
import 'EventPage.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CrewCall"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.headphones, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                "Welcome to CrewCall",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Google Sign In
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const GoogleSignInPage()));
                  },
                  icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                  label: const Text("Sign in with Google"),
                ),
              ),
              const SizedBox(height: 15),

              // Email Sign In
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const EmailAuth()));
                  },
                  child: const Text("Sign in with Email"),
                ),
              ),
              const SizedBox(height: 20),

              // Navigate to Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TalentSignupPage()));
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// LOGIN PAGE
//
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateEventPage(),
                    ),
                  );
                },
                child: const Text("Login"),
              ),
            ),
            const SizedBox(height: 20),

            // Navigate to Signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const WelcomePage()));
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SignInPage(),
//   ));
// }
