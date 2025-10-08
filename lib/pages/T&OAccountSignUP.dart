import 'package:flutter/material.dart';
import 'package:crewcall_flutter/authentication/googleauth.dart';

class TalentSignupPage extends StatefulWidget {
  const TalentSignupPage({super.key});

  @override
  State<TalentSignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<TalentSignupPage> {
  bool isTalent = true;
  bool isNonProfit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.headphones, color: Colors.orange, size: 30),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create a Talent Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Create an account to start connecting",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Talent / Organizer Toggle
            Row(
              children: [
                _buildToggleButton("Talent", isTalent),
                const SizedBox(width: 8),
                _buildToggleButton("Organizer", !isTalent),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "You are signing up as a ${isTalent ? "talent" : "organizer"}.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

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
                label: const Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(child: Text("or")),
            const SizedBox(height: 10),

            // First Name field
            Text("First Name", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Last Name field
            Text("Last Name", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Email field
            Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Phone Number field
            Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),



            // Password field
            Text("Password", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Confirm Password field
            Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Organization Type (only show for organizers)
            if (!isTalent) ...[
              Text("Organization Type", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Row(
                children: [
                  _buildOrganizerTypeButton("NGO/Non-Profit", isNonProfit),
                  const SizedBox(width: 8),
                  _buildOrganizerTypeButton("For Profit", !isNonProfit),
                ],
              ),
              const SizedBox(height: 10),
              
              Text("Your Role in the Organization", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Hiring Manager, Producer...",
                ),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 5),

            // Password Rules
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                PasswordRule(text: "At least 8 characters"),
                PasswordRule(text: "Contains a number"),
                PasswordRule(text: "Special character"),
              ],
            ),
            const SizedBox(height: 20),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Images at bottom
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildImage("https://picsum.photos/200/300?1"),
                _buildImage("https://picsum.photos/200/300?2"),
                _buildImage("https://picsum.photos/200/300?3"),
                _buildImage("https://picsum.photos/200/300?4"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool selected) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.orange : Colors.white,
          foregroundColor: selected ? Colors.white : Colors.black,
          side: const BorderSide(color: Colors.orange),
        ),
        onPressed: () {
          setState(() {
            isTalent = (text == "Talent");
          });
        },
        child: Text(text),
      ),
    );
  }

  Widget _buildOrganizerTypeButton(String text, bool selected) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.orange : Colors.white,
          foregroundColor: selected ? Colors.white : Colors.black,
          side: const BorderSide(color: Colors.orange),
        ),
        onPressed: () {
          setState(() {
            isNonProfit = (text == "NGO/Non-Profit");
          });
        },
        child: Text(text),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PasswordRule extends StatelessWidget {
  final String text;
  const PasswordRule({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Text(text),
      ],
    );
  }
}


// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TalentSignupPage(),
//   ));
// }
