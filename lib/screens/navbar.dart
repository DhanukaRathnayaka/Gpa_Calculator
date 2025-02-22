import 'home.dart'; // Importing the Home screen
import 'profile.dart'; // Importing the Profile screen
import 'calculatedgpa.dart'; // Importing the Calculated GPA screen
import 'package:flutter/material.dart'; // Importing Flutter material package
import 'package:convex_bottom_bar/convex_bottom_bar.dart'; // Importing Convex Bottom Bar package

// Main class for the navigation bar
class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

// State class for the navigation bar
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0; // Index to keep track of the selected tab

  // List of screens to display based on the selected tab
  final List<Widget> _screens = [
    HomeScreen(), // Home screen widget
    CalculatedGpaScreen(), // Calculated GPA screen widget
    ProfileScreen(), // Profile screen widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react, // Stylish animation for the tab bar
        backgroundColor: Colors.blue.shade800, // Background color of the tab bar
        color: Colors.white, // Color of the inactive icons
        activeColor: Colors.yellowAccent, // Color of the active icon
        items: [
          TabItem(icon: Icons.home, title: 'Home'), // Home tab
          TabItem(icon: Icons.calculate, title: 'GPA'), // GPA tab
          TabItem(icon: Icons.person, title: 'Profile'), // Profile tab
        ],
        initialActiveIndex: _selectedIndex, // Initial selected tab index
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected tab index
          });
        },
      ),
    );
  }
}