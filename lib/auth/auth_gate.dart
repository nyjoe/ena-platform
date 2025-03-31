// auth_gate.dart
import 'package:appli_ena/roles/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appli_ena/auth/auth_service.dart';
import 'package:appli_ena/roles/role_manager.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoginPage(title: "Connexion");
        return FutureBuilder<String?>(
          future: AuthService().getUserRole(snapshot.data!.uid),
          builder: (context, roleSnapshot) {
            if (!roleSnapshot.hasData) return CircularProgressIndicator();
            return RoleManager(role: roleSnapshot.data!);
          },
        );
      },
    );
  }
}
