import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/main_navigation.dart';

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
        "/main": (context) => const MainNavigation(fromLogin: true),
      },
    );
  }
}