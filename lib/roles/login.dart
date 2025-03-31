//import 'package:appli_ena/services/firebase/auth.dart';
import 'package:appli_ena/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _isLoading = false;
  bool _forLogin = false;

  // variable to store the selected role
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(_forLogin? widget.title : "Inscription", style: TextStyle(fontFamily: 'EB Garamond'),),)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'E-mail is required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Password is required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20,),
              if (!_forLogin) TextFormField(
                controller: _passwordConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password Confirmation",
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Confirmation is required';
                  } else if(value != _passwordController.text){
                    return 'The two phrases don\'t match';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              // Add the DropdownButtonFormField for roles
              if (!_forLogin) DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: "Rôle",
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Admin',
                  'Alumni',
                  'Candidat',
                  'Visiteur',
                  'Eleve',
                  'Enseignant',
                ].map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un rôle';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        _isLoading = true;
                      });
                      //login here
                      try {
                        if (_forLogin){
                          await AuthService().signIn(
                            _emailController.text, 
                            _passwordController.text
                          );
                        } else {
                            await AuthService().registerUser(
                            _emailController.text, 
                            _passwordController.text,
                            _selectedRole ?? "Student" // Default to "Student" if no role is selected
                          );
                        }
                        
                        setState(() {
                          _isLoading = false;
                        });
                      } on FirebaseAuthException catch(e){
                        setState(() {
                          _isLoading = false;
                        });
                        //display error message
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${(e.message)}"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            showCloseIcon: true,
                          )
                        );
                      }
                    }
                  }, 
                  child: _isLoading ? const CircularProgressIndicator() : Text(_forLogin ? "Se connecter" : "S'inscrire")
                ),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: (){
                    _emailController.text = "";
                    _passwordController.text = "";
                    _passwordConfirmController.text = "";

                    setState(() {
                      _forLogin = !_forLogin;
                    });
                  }, 
                  child: Text(
                    _forLogin ? 
                    "Je n'ai pas de compte. M'inscrire." 
                    : "Je possède déjà un compte. Me connecter.")
                ),
              ),

              const Divider(),

              ElevatedButton.icon(
                onPressed: (){
                  AuthService().signInWithGoogle();
                }, 
                icon: Image.asset("assets/images/google.png", height: 30,),
                label: const Text("Continuer avec Google")
              )
            ],
          ),
        ),
      ),
    );
  }
}