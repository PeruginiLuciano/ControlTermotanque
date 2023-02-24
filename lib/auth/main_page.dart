import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba/auth/auth_page.dart';
import 'package:prueba/pages/login_page.dart';
import 'package:prueba/service/control.dart';

import '../pages/home_page.dart';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot){
          if (snapshot.hasData){
            return HomePage(0);


          }else{
            return AuthPage();
          }
        }
      ),

    );
  }
}