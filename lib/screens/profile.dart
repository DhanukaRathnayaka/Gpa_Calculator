import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gpa_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gpaProvider = Provider.of<GpaProvider>(context);
    double currentGpa = gpaProvider.gpa; // Fetch latest GPA

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade300], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/profile.jpg"), // Placeholder image
              ),
              SizedBox(height: 15),

              // Name & Email
              Text(
                "Dhanuka Rathnayaka", // Replace with dynamic user data later
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "dhanukarathnayaka658@gmail.com", // Replace with user email
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              
              SizedBox(height: 30),

              // Profile Info Card
              Card(
                margin: EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ProfileInfoRow(icon: Icons.school, label: "University", value: "SLTC Research University"),
                      ProfileInfoRow(icon: Icons.computer, label: "Department", value: "Computer Science"),
                      ProfileInfoRow(icon: Icons.calculate, label: "Current GPA", value: currentGpa.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Logout Button (Optional)
              ElevatedButton.icon(
                onPressed: () {
                  // Logout logic (if needed)
                },
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Info Row Widget
class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileInfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding for each row
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700), // Icon for the row
          SizedBox(width: 10), // Space between icon and text
          Expanded(child: Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))), // Label text
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black54)), // Value text
        ],
      ),
    );
  }
}