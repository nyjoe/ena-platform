// auth/register_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _roles = ['candidat', 'eleve', 'enseignant', 'admin', 'alumni'];
  String? _email, _password, _role;

  Future<void> _register() async {
    if (_formKey.currentState!.validate() && _role != null) {
      _formKey.currentState!.save();

      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email!, password: _password!);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': _email,
          'role': _role,
          'createdAt': FieldValue.serverTimestamp()
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Inscription réussie. Bienvenue !")));
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur : ${e.message}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Choisir votre rôle'),
                items: _roles
                    .map((role) =>
                        DropdownMenuItem(value: role, child: Text(role.toUpperCase())))
                    .toList(),
                onChanged: (val) => setState(() => _role = val),
                validator: (val) =>
                    val == null ? 'Veuillez sélectionner un rôle' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (val) => _email = val,
                validator: (val) =>
                    val!.contains('@') ? null : 'Email invalide',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                onSaved: (val) => _password = val,
                validator: (val) =>
                    val!.length >= 6 ? null : '6 caractères minimum',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('S’inscrire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
