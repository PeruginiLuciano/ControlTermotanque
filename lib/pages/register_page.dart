import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) :super(key: key);
   
    
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _finalpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _nameLastController = TextEditingController();
  final _edadController = TextEditingController();
  final _temperatura =TextEditingController();
  
  

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _finalpasswordController.dispose();
    _firstNameController.dispose();
    _nameLastController.dispose();
    _edadController.dispose();
    _temperatura.dispose();
    super.dispose();
  }

  Future singUp() async{


    //Auth usuario
    if (passConfirmado()){
      //Crear usuario
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password:_passwordController.text.trim(),
      );


      //agregar datos usuarios
      addUserDetails(
        _firstNameController.text.trim(),
        _nameLastController.text.trim(),
        _emailController.text.trim(),
       int.parse( _edadController.text.trim()));
       

    }

  }

  Future addUserDetails(String nombre, String apellido, String email, int edad ) async{
    await FirebaseFirestore.instance.collection('Usuarios').add({
      'Nombre':nombre,
      'Apellido':apellido,
      
      'Email':email,
      'Edad':edad,
      'Temperatura': 0,

    });
  }
  Future cambioTemperatura(int valor)async{
    
  }
  bool passConfirmado(){
    if (_finalpasswordController.text.trim()==_passwordController.text.trim()){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea( 
        child: Center(
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(height: 40),
          // Hello again
          Text('Hola ¿eres nuevo?', style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),

          SizedBox(height: 10),
          Text('Crea tu usuario ', style:  TextStyle(fontSize: 20),),
          SizedBox(height: 20),
          //first textfield
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Nombre',
            fillColor: Colors.grey[200],
            filled: true,
            ),
          ),
          ),
          SizedBox(height: 10),
          //last textfield
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _nameLastController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Apellido',
            fillColor: Colors.grey[200],
            filled: true,
            ),
          ),
          ),
          SizedBox(height: 10),
          //first textfield
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _edadController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Edad',
            fillColor: Colors.grey[200],
            filled: true,
            ),
          ),
          ),
          SizedBox(height: 10),
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
          //confirmar password
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _finalpasswordController,
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
            hintText: 'Confirmar Password',
            fillColor: Colors.grey[200],
            filled: true,
            ),
          ),
          ),

          SizedBox(height: 20),
          //sing in button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: singUp,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Crear', 
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Ya eres miembro? '),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text('Ingresa ahora', style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
      ])
        ),),
    ),
    );
  }
}