import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GpaProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _subjects = [];
  double _gpa = 0.0;

  List<Map<String, dynamic>> get subjects => _subjects;
  double get gpa => _gpa;

  final Map<String, double> gradePoints = {
    "A+": 4.0, "A": 4.0, "A-": 3.7,
    "B+": 3.3, "B": 3.0, "B-": 2.7,
    "C+": 2.3, "C": 2.0, "C-": 1.7,
    "D+": 1.3, "D": 1.0, "E": 0.7, "F": 0.0
  };

  GpaProvider() {
    loadSubjects();
  }

  Future<void> addSubject(String subject, int credits, String grade) async {
    _subjects.add({'subject': subject, 'credits': credits, 'grade': grade});
    saveSubjects();
    calculateGPA();
  }

  void calculateGPA() {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (var subject in _subjects) {
      double gradePoint = gradePoints[subject['grade']] ?? 0.0;
      int credits = subject['credits'];

      totalGradePoints += gradePoint * credits;
      totalCredits += credits;
    }

    _gpa = totalCredits > 0 ? totalGradePoints / totalCredits : 0.0;
    notifyListeners();
  }

  Future<void> saveSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('subjects', jsonEncode(_subjects));
  }

  Future<void> loadSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    String? subjectsString = prefs.getString('subjects');

    if (subjectsString != null) {
      _subjects = List<Map<String, dynamic>>.from(jsonDecode(subjectsString));
      calculateGPA();
      notifyListeners();
    }
  }

  Future<void> clearSubjects() async {
    _subjects.clear();
    _gpa = 0.0;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('subjects');
    notifyListeners();
  }
  void removeSubject(int index) {
  _subjects.removeAt(index);
  saveSubjects();
  calculateGPA();
  notifyListeners();
}

}
