import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gpa_provider.dart';

class CalculatedGpaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the GPA value from the provider
    var gpa = Provider.of<GpaProvider>(context).gpa;

    // Function to get a message based on the GPA value
    String getGpaMessage(double gpa) {
      if (gpa >= 3.7) return "🌟 Excellent!";
      if (gpa >= 3.0) return "👍 Great Job!";
      if (gpa >= 2.0) return "🙂 Keep Improving!";
      return "⚠️ Needs Work!";
    }

    return Scaffold(
      appBar: AppBar(title: Text("Your GPA")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgc1.jpg"), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text("Your GPA is:",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 10),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: gpa),
                          duration: Duration(seconds: 2),
                          builder: (context, value, child) {
                            return Text(
                              value.toStringAsFixed(2),
                              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        // Display the GPA message
                        Text(
                          getGpaMessage(gpa),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}