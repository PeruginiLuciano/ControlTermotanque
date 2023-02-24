import 'package:flutter/material.dart';
import 'package:prueba/auth/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
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
              height: 250.0,
              width: 250.0,
              child: Image.asset('lib/assets/logo.jpg'),
            ),
            
            SizedBox(height: 30),
            //CircularProgressIndicator(),
            SizedBox(height: 30),
            
          ],
        ),
      ),

    );
  }
}