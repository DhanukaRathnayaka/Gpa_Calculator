import 'screens/navbar.dart';
import 'providers/gpa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Entry point of the application
void main() {
  runApp(
    MultiProvider(
      providers: [
        // Providing GpaProvider to the widget tree
        ChangeNotifierProvider(create: (_) => GpaProvider()),
      ],
      child: GpaCalculatorApp(),
    ),
  );
}

// Main application widget
class GpaCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'GPA Calculator', // Title of the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color theme
      ),
      home: NavBar(), // Sets the home widget to NavBar
    );
  }
}