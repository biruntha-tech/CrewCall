import 'package:crewcall_flutter/pages/T&OAccountsignIn.dart';
import 'package:flutter/material.dart';
import 'pages/T&OAccountSignUP.dart';
import 'pages/welcome.dart';
// import 'pages/EventPage.dart';

void main() {
  runApp(const CrewCallApp());
}


class CrewCallApp extends StatelessWidget {
  const CrewCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrewCall',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: "/welcome",
      routes: {
        "/welcome": (context) => const WelcomePage(),
        "/signin": (context) => const SignInPage(),
        "/signup": (context) => const TalentSignupPage(),
      },
    );
  }
}