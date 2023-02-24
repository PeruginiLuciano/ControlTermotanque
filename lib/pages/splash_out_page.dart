import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prueba/auth/main_page.dart';

class SplashScreenOut extends StatefulWidget {
  const SplashScreenOut({super.key});

  @override
  State<SplashScreenOut> createState() => _SplashScreenOutState();
}

class _SplashScreenOutState extends State<SplashScreenOut> {
  @override
  void initState(){  
    FirebaseAuth.instance.signOut();
    Future.delayed(Duration(milliseconds: 3000),()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>MainPage())));
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: Image.asset('lib/assets/logo.jpg'),
            ),
            SizedBox(height: 30),
            Text("Gracias",style: TextStyle(
                    
                    
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    ),),
            
            SizedBox(height: 30),
            //CircularProgressIndicator(),
            SizedBox(height: 30),
            
          ],
        ),
      ),

    );
  }
}