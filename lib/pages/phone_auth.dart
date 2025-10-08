import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'EventPage.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthService _authService = AuthService();
  
  String? verificationId;
  bool otpSent = false;

  void sendOTP() async {
    await _authService.signInWithPhone(
      phoneController.text,
      (credential) async {
        // Auto verification completed
        final result = await _authService.verifyOTP(verificationId!, credential.smsCode!);
        if (result != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
        }
      },
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.message}')),
        );
      },
      (verificationId, resendToken) {
        setState(() {
          this.verificationId = verificationId;
          otpSent = true;
        });
      },
      (verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  void verifyOTP() async {
    if (verificationId != null) {
      final result = await _authService.verifyOTP(verificationId!, otpController.text);
      if (result != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            if (!otpSent) ...[
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "+1234567890",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: sendOTP,
                  child: const Text("Send OTP"),
                ),
              ),
            ] else ...[
              TextField(
                controller: otpController,
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: verifyOTP,
                  child: const Text("Verify OTP"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}