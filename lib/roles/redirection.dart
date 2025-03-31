import 'package:appli_ena/roles/home.dart';
import 'package:appli_ena/roles/login.dart';
import 'package:appli_ena/services/firebase/auth.dart';
import 'package:flutter/material.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RedirectionPageState();
  }
}

class _RedirectionPageState extends State<RedirectionPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasData){
          return const MyHomePage(title: "Accueil");
        }else{
          return const LoginPage(title: "Connexion",);
        }
      }
    );
  }
}