import 'package:flutter/material.dart';
import 'package:crewcall_flutter/authentication/googleauth.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';
import 'package:crewcall_flutter/pages/main_navigation.dart';
import 'package:crewcall_flutter/pages/talentprofile_setup.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'AccountSignIn.dart';

class TalentSignupPage extends StatefulWidget {
  const TalentSignupPage({super.key});

  @override
  State<TalentSignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<TalentSignupPage> {
  bool isTalent = true;
  bool isNonProfit = true;
  
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _agreedToTerms = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (value.length < 10) return 'Enter a valid phone number';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: SizedBox(
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
              ),
              const SizedBox(height: 10),
              const Center(child: Text("or")),
              const SizedBox(height: 10),

              // First Name field
              Text("First Name", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: firstNameController,
                validator: _validateName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Last Name field
              Text("Last Name", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: lastNameController,
                validator: _validateName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Email field
              Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: emailController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Phone Number field
              Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: phoneController,
                validator: _validatePhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Password field
              Text("Password", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: passwordController,
                validator: _validatePassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Confirm Password field
              Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                controller: confirmPasswordController,
                validator: _validateConfirmPassword,
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

              // Terms and Conditions Checkbox
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.primary;
                            }
                            return Colors.white;
                          },
                        ),
                        checkColor: MaterialStateProperty.all(Colors.white),
                        side: const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            const TextSpan(text: "I agree to the "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Terms of Use page would open here')),
                                  );
                                },
                                child: const Text(
                                  "Terms of Use",
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: " and "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Privacy Policy page would open here')),
                                  );
                                },
                                child: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Password Rules
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: const [
              //     PasswordRule(text: "At least 8 characters"),
              //     PasswordRule(text: "Contains a number"),
              //     PasswordRule(text: "Special character"),
              //   ],
              // ),
              // const SizedBox(height: 20),

              // Action Buttons Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  children: [
                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _isLoading ? null : () async {
                          if (_formKey.currentState!.validate() && _agreedToTerms) {
                            setState(() => _isLoading = true);
                            
                            await Future.delayed(Duration(seconds: 1));
                            
                            String fullName = '${firstNameController.text} ${lastNameController.text}'.trim();
                            UserData.setUserData(
                              fullName,
                              emailController.text,
                              phoneController.text,
                            );
                            
                            setState(() => _isLoading = false);
                            
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const TalentProfilePage()),
                            );
                          } else if (!_agreedToTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please agree to the Terms of Use and Privacy Policy'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Create Account",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.primary),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AccountSignInPage()),
                          );
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(fontSize: 16, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Images at bottom
              Container(
                padding: const EdgeInsets.all(12),
                child: GridView.count(
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
              ),
            ],
            ),
          ),
        ),
      ),
      )
    );
  }

  Widget _buildToggleButton(String text, bool selected) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? AppColors.primary : Colors.white,
          foregroundColor: selected ? Colors.white : Colors.black,
          side: const BorderSide(color: AppColors.primary),
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
          backgroundColor: selected ? AppColors.primary : Colors.white,
          foregroundColor: selected ? Colors.white : Colors.black,
          side: const BorderSide(color: AppColors.primary),
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
      padding: const EdgeInsets.all(4),
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TalentSignupPage(),
  ));
}