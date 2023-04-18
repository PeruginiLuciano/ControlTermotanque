import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba/pages/agregarDispositivo.dart';
import 'package:prueba/pages/splash_out_page.dart';
//import 'package:prueba/read%20data/get_user_name.dart';
import 'package:prueba/auth/nav_bar.dart';
import 'package:prueba/service/barraNivel.dart';

import 'package:prueba/service/controlHome.dart';

import '../data_base/data_base.dart';
import '../data_base/temperaturas.dart';

late final auxiliar;
bool comenzar = false;

class HomePage extends StatefulWidget {
  final index;

  const HomePage(this.index, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int bandera=0;
  bool isInitialLoad = true;
  final dbTemp = FirebaseDatabase.instance.ref().child('Dispositivo6').onValue;
  
  final user = FirebaseAuth.instance.currentUser!;
  
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  num nivelAgua=40;
  final databaseReference = FirebaseDatabase.instance.ref();
  
  late num tem;
  late AnimationController progressController;
  late Animation<num> tempAnomations;
  late Animation<double> Humedad;
  int j = 0;
  final List<String> disp = [];
  final List<String> Nombres = [];
  Future<void> _loadName() async {
    final user = FirebaseAuth.instance.currentUser!;
    final CollectionReference dispCollection = FirebaseFirestore.instance.collection(user.email.toString());
    
    final querySnapshot = await dispCollection.get();
    querySnapshot.docs.forEach((document) {
      final data = document.data() as Map<String, dynamic>;
      final codigo = data['Nombre'] as String;
      final codigo2 = data['Codigo'] as String;
      Nombres.add(codigo);
      disp.add(codigo2);
    });
    
  }
  /*Future<void> _loadUsers(List<String> disp) async {
    final user = FirebaseAuth.instance.currentUser!;
    final CollectionReference dispCollection = FirebaseFirestore.instance.collection(user.email.toString());
     disp= [];
    QuerySnapshot querySnapshot = await dispCollection.get();
    final AllDataa=querySnapshot.docs.map((doc) => doc.data()).toList();
    print(AllDataa);
    disp.add((AllDataa as Map )["Codigo"]);
    
  }*/
  //List<Dispositivos> disp = [];
  @override
  void initState() {
    
    
    super.initState();
    //_loadUsers(disp);
    _loadName().then((_) {
    bandera++;
    if(bandera>1){
      isInitialLoad = false;

    }
    else{isInitialLoad = true;}
    cargaAnimales();
    }).catchError((error){
      print("ERROR es: $error");
    })   ;
  }
  @override
  
  void didUpdateWidget (HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    isInitialLoad = false;
    
  }
  cargaAnimales() async {
    //List<Dispositivos> auxAnimal = await DisDataBase.dispositovo();

    setState(() {
     
       /* for (var i = 0; i < auxAnimal.length; i++) {
          if (auxAnimal[i].Email.toString() == user.email.toString()) {
            disp.insert(j, auxAnimal[i]);
            j++;
          }
        }*/
      
      try {
        if (disp.length > 0) {
          comenzar = true;
          final path = disp[widget.index] + "/Sensores";
          final path2 = disp[widget.index]+"/Nivel";
          databaseReference.child(path).onValue.listen((event) {
             tem=(event.snapshot.value as Map)["Temperatura"];
              _DashboardInit(tem, 2.0);
            isLoading = true;
            setState((){});
            
            
            
          });
          
          databaseReference.child(path2).onValue.listen((event) {
            nivelAgua = (event.snapshot.value as Map)["Nivel"];

            isLoading = true;
            setState((){});
          });
        } else {}
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'El numero de serie del dispositivo no existe ',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(0)));
      }
    });
  }
  _DashboardInit(num tem, double humi) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    tempAnomations =
        Tween<num>(begin: -50, end: tem).animate(progressController)
          ..addListener(() {
            setState(() {});
          });
    progressController.forward();
  }
  

  @override

  //Document IDs
  List<String> docIDs = [];

  //get docIds
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('Usuarios').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            print(document.reference.id);
            print(userId);

            docIDs.add(document.reference.id);
          }),
        );
  }
  
  @override
  Widget build(BuildContext context) {
    if (comenzar) {
      try {
        if (CircleProgressActual(81.5).fondo()) {
          Colors.red;
        }
        return WillPopScope(
          onWillPop: ()=> _onBackButtonPress(context),
           
          
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => agregarDisp()));
                  }),
              drawer: NavBar(widget.index),
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text(Nombres[widget.index],
                    style: TextStyle(fontSize: 20)),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreenOut()));
                    },
                    child: Icon(Icons.logout),
                  ),
                ],
              ),
              body: Center(
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomPaint(
                              foregroundPainter:
                                  CircleProgressActual(isInitialLoad ? tempAnomations.value.toInt() : tem),
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Temperatura"),
                                      Text(
                                        isInitialLoad ? tempAnomations.value.toInt().toString() : tem.toString(),
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'ºC',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      

                                    ],
                                  ),
                                ),
                              ),
                            ),
                           
                            SizedBox(height: 60,),
                            Text("Nivel de agua",style: TextStyle(fontSize: 20)),
                            Center(
                              child: CustomPaint(
                                foregroundPainter: BarraNivelProgressActual(nivelAgua),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text("\n\n%0              %"+nivelAgua.toString()+"           %100",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                            )
                            
                            
                          ],
                          
                          
                        )
                        

                      : Center(
                          child: Text(
                          "El codigo de serie del dispositivo no existe",
                          style: TextStyle(fontSize: 20),
                        )))),
        );
      } catch (e) {
        if (e.toString().length > 0) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => agregarDisp()));
                }),
            drawer: NavBar(0),
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Agrega o cambia  dispositivo ",
                  style: TextStyle(fontSize: 20)),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreenOut()));
                  },
                  child: Icon(Icons.logout),
                ),
              ],
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "No se selecciono un dispositivo existente",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )),
          );
          ;
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "No se selecciono un dispositivo existente",
                style: TextStyle(fontSize: 20),
              )),
            ),
          );
        }
      }
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => agregarDisp()));
            }),
        drawer: NavBar(0),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Agrega o cambia  dispositivo ",
              style: TextStyle(fontSize: 20)),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreenOut()));
              },
              child: Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "No se selecciono un dispositivo existente",
            style: TextStyle(fontSize: 20),
          )),
        ),
      );
    }
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
