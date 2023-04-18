import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba/pages/home_page.dart';
import 'package:prueba/service/userservice.dart';

import '../auth/nav_bar.dart';
import '../data_base/data_base.dart';
import '../data_base/temperaturas.dart';

class control extends StatefulWidget {
  final index;
  const control(this.index, {super.key});

  @override
  State<control> createState() => _controlState();
}

class _controlState extends State<control> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  final databaseReference = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;
  late AnimationController progressController;
  late Animation<num> tempAnomations;
  late Animation<num> tempMAx;
  late Animation<num> tempMin;
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
  int j = 0;
  @override
  void initState() {
    
    super.initState();
    _loadName().then((_) {
      cargaAnimales();
    });
  }

  cargaAnimales() async {
    //List<Dispositivos> auxAnimal = await DisDataBase.dispositovo();

    setState(() {
      /*for (var i = 0; i < auxAnimal.length; i++) {
        if (auxAnimal[i].Email.toString() == user.email.toString()) {
          disp.insert(j, auxAnimal[i]);
          j++;
        }
      }
      j = 0;*/
      try {
        databaseReference
            .child(disp[widget.index] + "/Sensores")
            .once()
            .then((event) {
          num tem = (event.snapshot.value as Map)["Temperatura"];
          num temX = (event.snapshot.value as Map)["TemperaturaMax"];
          num temM = (event.snapshot.value as Map)["TemperaturaMin"];
          isLoading = true;
          _DashboardInit(tem, temX, temM);
        });
      } catch (e) {
        isLoading = false;
      }
    });
  }

  _DashboardInit(num tem, num temX, num temM) {
    progressController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    tempAnomations =
        Tween<num>(begin: -50, end: tem).animate(progressController)
          ..addListener(() {
            setState(() {});
          });
    tempMAx = Tween<num>(begin: -50, end: temX).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    tempMin = Tween<num>(begin: -50, end: temM).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return WillPopScope(
        onWillPop: ()  async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(widget.index)));

          return true;
        },
        child: Scaffold(
            drawer: NavBar(widget.index),
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Control diario", style: TextStyle(fontSize: 20)),
            ),
            body: Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomPaint(
                          foregroundPainter: CircleProgress(tempMin.value, true),
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Temp Min"),
                                  Text(
                                    '${tempMin.value.toInt()}',
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  control(widget.index)));
                                    },
                                    child: Text(
                                      'Actualizar',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CustomPaint(
                          foregroundPainter: CircleProgress(tempMAx.value, false),
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Temp Max"),
                                  Text(
                                    '${tempMAx.value.toInt()}',
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  control(widget.index)));
                                    },
                                    child: Text(
                                      'Actualizar',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "No se selecciono ningun despositivo o el codigo de serie del dispositivo no existe",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
            )),
      );
    } catch (e) {
      return WillPopScope(
        onWillPop: () async  {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(widget.index)));
          return true;
        },
        child: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
}
