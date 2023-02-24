import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba/auth/Authenticador.dart';
import 'package:prueba/pages/forgot_pw_page.dart';


class LoginPage extends StatefulWidget{
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future SignIn() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim(),);
    }on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Usuario o password incorrecto"),
        );
      });
    }
  }
  @override
  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Widget build (BuildContext context){
    Firebase.initializeApp();
    return WillPopScope(
      onWillPop: ()=> _onBackButtonPress(context),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea( 
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                height: 100.0,
                width: 100.0,
                child: Image.asset('lib/assets/logoblk.png'),
                
              ),
              SizedBox(height: 20),
    
            // Hello again
            
    
            
            Text('Bienvenidos a Enertik', style:  TextStyle(fontSize: 20),),
            
            SizedBox(height: 20),
            //email textfield
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
            //password texfield
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Password',
              fillColor: Colors.grey[200],
              filled: true,
              ),
            ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ForgotPasswordPage();
                        }));
                    },
                    child: Text('¿Olvidaste la contraseña?', style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //sing in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: SignIn,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text('Ingresar', 
                    style: TextStyle(
                      
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      ),
                      
                  ),
              
                  ),
                ),
              ),
            
            ),
            SizedBox(height: 20,),
            Text("O ingresa con Google",style: TextStyle(fontWeight: FontWeight.bold),),
            TextButton(
              
              onPressed:()async{
                User? user = await Authenticator.iniciarSesion(
                  context: context
                );
                print(user?.displayName);
              },
            
              
              child:  Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.google,color: Colors.blue),
                    Text("o",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("o",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("g",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("l",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("e",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
              ),
              
              
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¿No tenes cuenta? '),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: Text('Registrate ahora', style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
        ])
        ),
      ),
      ),
    );
  }
}

_onBackButtonPress(BuildContext context) async  {
  bool exitApp = await showDialog(context: context,builder: (BuildContext context){
    return AlertDialog(
      title: const Text("Cerrar Aplicacion"),
      content: const Text("¿Esta seguro que quiere cerrar la aplicación?"),
      actions:<Widget> [
        TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Cancelar")),
        TextButton(onPressed:(){exit(0);} , child: const Text("Si"))
      ],
    );
  });
}