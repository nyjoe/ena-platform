// role_manager.dart
import 'package:flutter/material.dart';

import 'candidates/candidate_home.dart';
import 'students/student_home.dart';
import 'teachers/teacher_home.dart';
import 'admin/admin_home.dart';
import 'alumni/alumni_home.dart';
import 'guests/guest_home.dart';

class RoleManager extends StatelessWidget {
  final String role;

  const RoleManager({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    switch (role.toLowerCase()) {
      case 'candidat':
        return CandidateHome();
      case 'eleve':
        return StudentHome();
      case 'enseignant':
        return TeacherHome();
      case 'admin':
        return AdminHome();
      case 'alumni':
        return AlumniHome();
      default:
        return GuestHome();
    }
  }
}
