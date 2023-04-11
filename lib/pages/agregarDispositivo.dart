import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba/data_base/custom.dart';
import 'package:prueba/data_base/data_base.dart';
import 'package:prueba/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';

import '../data_base/temperaturas.dart';

class agregarDisp extends StatefulWidget {
  const agregarDisp({super.key});

  @override
  State<agregarDisp> createState() => _agregarDispState();
}
final dbTemp = FirebaseDatabase.instance.ref().child('Dispositivo6').once().then((event){
  print(event.snapshot.value.toString());
});
void agregarDispositivos() async {
  List<DisDataBase> auxDispo = await DisDataBase.dispositovo();
  
  //try {
  //databaseReference.child(Path).once().then((event) {
  //  print(event.snapshot.value);
  // });
  //} on FirebaseAuthException catch (e) {
  // print(e);
  //}
  //;

} 

final user = FirebaseAuth.instance.currentUser!;
final firebaseRealtime = FirebaseDatabase.instance.ref();
Future<void> agregarD(dynamic _nombre,dynamic _codigo, String _fecha,String _fechaCambio,context) async {
  String temp="";
  try{
    
  if(_codigo.text.length==12){
   
    try{
        await FirebaseFirestore.instance.collection('Usuarios').doc(user.uid.toString()+"/Dispositivos/Disp").set({
          "Fecha" : _nombre.text.trim(),
          "FechaCambio": _codigo.text.trim()
        });
        firebaseRealtime.child(_codigo.text.trim()).child("Anodo").set({
        "Fecha" : _fecha,
        "FechaCambio": _fechaCambio
        });
        
    

          DisDataBase.insert(Dispositivos(
                    Nombre: _nombre.text.trim(), Codigo: _codigo.text.trim(), Email: user.email.toString()));
                    Fluttertoast.showToast(
                    msg: 'El dispositivo "' +
                        _nombre.text.trim() +
                        '" se agrego con exito y el mail es: '+user.email.toString()+' este',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 2,
                    textColor: Colors.white,
                    fontSize: 16.0);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
    }catch(e){
      print("No Existe el codigo");
    }
  }else{Fluttertoast.showToast(
                    msg: "Error el codigo debe ser de 12 digitos",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);}
  }catch (e){
        Fluttertoast.showToast(
                    msg: "Error el codigo ingresado no corresponde a ningun dispositivo",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(0)));


    }
}

class _agregarDispState extends State<agregarDisp> {
  final firebaseRealtime =FirebaseDatabase.instance.ref();
  List<String> dispositivos = [];
  final _nombre = TextEditingController();
  final _codigo = TextEditingController();
  final user2 = FirebaseAuth.instance.currentUser!;
  final email2 = user.email.toString().replaceAll(".", "A");
  late Database resultado;
  void agregarDispFire(dynamic _nombre,dynamic _codigo,String _fecha){

    try{
      if(_codigo.text.length==12){
        firebaseRealtime.child("Usuarios").child(email2).child(_nombre.text.trim()).set({
          "Nombre": _nombre.text.trim(),
          "Codigo": _codigo.text.trim(),
        
        });
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(0)));
      }else{Fluttertoast.showToast(
                      msg: "Error el codigo debe ser de 12 digitos",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);}
    }catch(e){
      

    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(0)));

  }

  void leerUsuarios(){
    var list=[];
    firebaseRealtime.child("Usuarios").child(email2).once().then((resultado){
      //late var  clave;
      var hola =(resultado.snapshot.value  as Map) ;
      hola.forEach((k,v)=> list.add(Customer(k,v)));
      for (var i in list){
      print(i);
      }
      print(hola);
    });
  }
  var _currentSelectData;
  var _currentSelectData2;

  late String  PrintFech="";
  late String PrintFechCambio="";
  late String MesAnodo;
  late String AgnoAnodo;
  late String DiaAnodo;
  void callDatePi() async{
    var selected = await getDatePickerWid();
    setState(() {
      _currentSelectData = selected;
      _currentSelectData2 = selected!.add((Duration(days: 90)));
      MesAnodo=_currentSelectData.month.toString();
      AgnoAnodo=_currentSelectData.year.toString();
      DiaAnodo=_currentSelectData.day.toString();
      PrintFech = _currentSelectData.year.toString() +
          "-" +
          _currentSelectData.month.toString() +
          "-" +
          _currentSelectData.day.toString();
      PrintFechCambio=_currentSelectData2.year.toString() +
          "-" +
          _currentSelectData2.month.toString() +
          "-" +
          _currentSelectData2.day.toString();
      
    });
  }

  Future<DateTime?> getDatePickerWid(){
    return showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2021), 
    lastDate: DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    shrinkWrap:
    true;
    physics:
    ScrollPhysics();
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Nuevo Dispositivo"),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Elegir Fecha de instalacion del anodo de sacrificio",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){
                callDatePi(); 
            }, child: Text("Elegir Fecha",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Introduci  el nombre y el codigo de tu dispositivo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            //email textfield
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _nombre,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _codigo,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Codigo',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
           
            SizedBox(height: 10),

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap:() { 
                 if(PrintFech.length>0){
                print("Se agrego");
                agregarD(_nombre,_codigo,PrintFech,PrintFechCambio,context);
                 }
                 else{Fluttertoast.showToast(
                      msg: "Debe introducir fecha de cambio de anodo para agregar dispositivo",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 3,
                      textColor: Colors.white,
                      fontSize: 16.0);}
                },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text('Cargar dispositivo', 
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









            
          ],
        ));
    ;
  }
}
