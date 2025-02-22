import 'calculatedgpa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gpa_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController creditsController = TextEditingController();
  String? selectedGrade;

  // List of grade options
  final List<String> grades = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "E"];

  void addSubject(BuildContext context) {
    if (_formKey.currentState!.validate() && selectedGrade != null) {
      Provider.of<GpaProvider>(context, listen: false).addSubject(
        subjectController.text,
        int.parse(creditsController.text),
        selectedGrade!,
      );

      // Clear inputs
      subjectController.clear();
      creditsController.clear();
      setState(() {
        selectedGrade = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var gpaProvider = Provider.of<GpaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Welcome to GPA Calculator")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgcc1.jpg"), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: subjectController,
                          decoration: InputDecoration(
                            labelText: "Subject Name",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) => value!.isEmpty ? "Enter subject" : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: creditsController,
                          decoration: InputDecoration(
                            labelText: "Credits",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => value!.isEmpty ? "Enter credits" : null,
                        ),
                        SizedBox(height: 10),
                        // Dropdown for Grade Selection
                        DropdownButtonFormField<String>(
                          value: selectedGrade,
                          onChanged: (value) {
                            setState(() {
                              selectedGrade = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Select Grade",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          items: grades.map((grade) {
                            return DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            );
                          }).toList(),
                          validator: (value) => value == null ? "Select a grade" : null,
                        ),
                        SizedBox(height: 20),
                        // Aligning Buttons in a Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () => addSubject(context),
                              child: Text("Add Subject"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 28, 52, 94),
                                backgroundColor: const Color.fromARGB(255, 252, 253, 251),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CalculatedGpaScreen()),
                                );
                              },
                              child: Text("Go to GPA"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 28, 52, 94),
                                backgroundColor: const Color.fromARGB(255, 252, 253, 251),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // ListView for added subjects
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: gpaProvider.subjects.length,
                itemBuilder: (context, index) {
                  final subject = gpaProvider.subjects[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(subject['subject']),
                      subtitle: Text("Credits: ${subject['credits']}, Grade: ${subject['grade']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          gpaProvider.removeSubject(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
