import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController=TextEditingController();

  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("El password a sido reseteado, enviamos un link a su email"),
        );
      });
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("El Usuario no existe"),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: Text('Introduci tu email para resetear tu password',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),),
        ),
        //email textfield
        SizedBox(height: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Email',
            fillColor: Colors.grey[200],
            filled: true,
            ),
          ),
          ),
          SizedBox(height: 10),
          MaterialButton(onPressed: passwordReset,
          child: Text('Resetear password',style: TextStyle(
                    
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    ),),
          color: Colors.green,)
      ],)
    );
  }
}