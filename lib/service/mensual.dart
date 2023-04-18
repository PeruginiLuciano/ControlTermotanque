import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba/auth/linear_charts_mes.dart';

import '../auth/nav_bar.dart';
import '../data_base/data_base.dart';
import '../data_base/temperaturas.dart';

class mensual extends StatefulWidget {
  final index;
  final List Datoscomienzo;
  const mensual(this.index,this.Datoscomienzo, {super.key});

  @override
  State<mensual> createState() => _mensualState();
}

class _mensualState extends State<mensual> {
  @override
  final databaseReference = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;
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

  void initState() {
    
    super.initState();
    _loadName().then((_) {
      
    });
  }
  late Stream<dynamic> Prom2;
  bool isLoading=true;
  int j = 0;
 

  var _currentSelectdData;
  var _currentSelectdDataFinal;

  

  void recorrer() {
    DateTime inicio = _currentSelectdData;
    DateTime fin = _currentSelectdDataFinal;
    var INTERVALO = 1000 * 60 * 60 * 24 * 7;

    for (var i = inicio; i == fin;) {
      print(i);
    }
  }
  void GradicaMensualProm()  async {
    String fecha = "";
    String Dia;
    String Mes;
    String Ano;
    String Dias;
    int Longitud_lista;
    if (Ano2 - Ano1 == 0) {
      Ano = Ano1.toString();
      if (mes2 - mes1 == 0) {
        Mes = mes1.toString();
        Datos = dia2 - dia1;
        Dia = dia1.toString();
        int i=0;
        for ( i = 0; i < Datos + 1; i++) {
          Dias = (int.parse(Dia) + i).toString();
          if (Mes.length == 1) {
            Mes = "0" + Mes;
          }
          if (Dias.length == 1) {
            Dias = "0" + Dias;
          }
          fecha = Ano + "-" + Mes + "-" + Dias;
          await databaseReference
              .child(disp[widget.index] + "/Fecha/" + fecha)
              .once()
              .then((event) {
                num  Temp2=     (event.snapshot.value as Map)["TemperaturaMax"];
                num  Temp=     (event.snapshot.value as Map)["TemperaturaMin"];
                num temp3=(Temp+Temp2)/2;
              Prom.insert(i, temp3);
          });
          
          print(Prom);
        }
        
        i=0;
        print("Correcto los dias son " + Datos.toString());
        isLoading=true;
        setState(() {
      
      Ano1 = int.parse(_currentSelectdData.year.toString());
      mes1 = int.parse(_currentSelectdData.month.toString());
      dia1 = int.parse(_currentSelectdData.day.toString());
      Printfecha = _currentSelectdData.year.toString() +
          "-" +
          _currentSelectdData.month.toString() +
          "-" +
          _currentSelectdData.day.toString();
    });
        //Navigator.push(context,
          //        MaterialPageRoute(builder: (context) => (mensual(widget.index,Prom))));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Debe elegir fecha en el mismo mes"),
              );
            });
        print("Debe elegir fecha en el mismo mes");
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Debe elegir fecha en el mismo año"),
            );
          });
      print("Debe elegir fecha en el mismo año");
    }
    
  }

  void GradicaMensualMax()  async {
    String fecha = "";
    String Dia;
    String Mes;
    String Ano;
    String Dias;
    int Longitud_lista;
    if (Ano2 - Ano1 == 0) {
      Ano = Ano1.toString();
      if (mes2 - mes1 == 0) {
        Mes = mes1.toString();
        Datos = dia2 - dia1;
        Dia = dia1.toString();
        int i=0;
        for ( i = 0; i < Datos + 1; i++) {
          Dias = (int.parse(Dia) + i).toString();
          if (Mes.length == 1) {
            Mes = "0" + Mes;
          }
          if (Dias.length == 1) {
            Dias = "0" + Dias;
          }
          fecha = Ano + "-" + Mes + "-" + Dias;
          await databaseReference
              .child(disp[widget.index]+ "/Fecha/" + fecha)
              .once()
              .then((event) {
                num  Temp=     (event.snapshot.value as Map)["TemperaturaMax"];
              Prom.insert(i, Temp);
          });
          
          print(Prom);
        }
        
        i=0;
        print("Correcto los dias son " + Datos.toString());
        isLoading=true;
        setState(() {
      
      Ano1 = int.parse(_currentSelectdData.year.toString());
      mes1 = int.parse(_currentSelectdData.month.toString());
      dia1 = int.parse(_currentSelectdData.day.toString());
      Printfecha = _currentSelectdData.year.toString() +
          "-" +
          _currentSelectdData.month.toString() +
          "-" +
          _currentSelectdData.day.toString();
    });
        //Navigator.push(context,
          //        MaterialPageRoute(builder: (context) => (mensual(widget.index,Prom))));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Debe elegir fecha en el mismo mes"),
              );
            });
        print("Debe elegir fecha en el mismo mes");
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Debe elegir fecha en el mismo año"),
            );
          });
      print("Debe elegir fecha en el mismo año");
    }
    
  }

  void GradicaMensual()  async {
    String fecha = "";
    String Dia;
    String Mes;
    String Ano;
    String Dias;
    int Longitud_lista;
    if (Ano2 - Ano1 == 0) {
      Ano = Ano1.toString();
      if (mes2 - mes1 == 0) {
        Mes = mes1.toString();
        Datos = dia2 - dia1;
        Dia = dia1.toString();
        int i=0;
        for ( i = 0; i < Datos + 1; i++) {
          Dias = (int.parse(Dia) + i).toString();
          if (Mes.length == 1) {
            Mes = "0" + Mes;
          }
          if (Dias.length == 1) {
            Dias = "0" + Dias;
          }
          fecha = Ano + "-" + Mes + "-" + Dias;
          await databaseReference
              .child(disp[widget.index] + "/Fecha/" + fecha)
              .once()
              .then((event) {
                num  Temp=     (event.snapshot.value as Map)["TemperaturaMin"];
              Prom.insert(i, Temp);
          });
          
          print(Prom);
        }
        
        i=0;
        print("Correcto los dias son " + Datos.toString());
        isLoading=true;
        setState(() {
      
      Ano1 = int.parse(_currentSelectdData.year.toString());
      mes1 = int.parse(_currentSelectdData.month.toString());
      dia1 = int.parse(_currentSelectdData.day.toString());
      Printfecha = _currentSelectdData.year.toString() +
          "-" +
          _currentSelectdData.month.toString() +
          "-" +
          _currentSelectdData.day.toString();
    });
        //Navigator.push(context,
          //        MaterialPageRoute(builder: (context) => (mensual(widget.index,Prom))));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Debe elegir fecha en el mismo mes"),
              );
            });
        print("Debe elegir fecha en el mismo mes");
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Debe elegir fecha en el mismo año"),
            );
          });
      print("Debe elegir fecha en el mismo año");
    }
    
  }
  
  void callDatePicker() async {
    print("ENTREEEEE");
    var selectedDate = await getDatePickerWidget();
    /*_currentSelectdData = selectedDate;
    Ano1 = int.parse(_currentSelectdDataFinal.year.toString());
    mes1 = int.parse(_currentSelectdDataFinal.month.toString());
    dia1 = int.parse(_currentSelectdDataFinal.day.toString());
    Printfecha = _currentSelectdData.year.toString() +
        "-" +
        _currentSelectdData.month.toString() +
        "-" +
        _currentSelectdData.day.toString();
    */
    setState(() {
      _loadName().then((_){
      _currentSelectdData = selectedDate;
      Ano1 = int.parse(_currentSelectdData.year.toString());
      mes1 = int.parse(_currentSelectdData.month.toString());
      dia1 = int.parse(_currentSelectdData.day.toString());
      Printfecha = _currentSelectdData.year.toString() +
          "-" +
          _currentSelectdData.month.toString() +
          "-" +
          _currentSelectdData.day.toString();
    });
    });
  }
 
  void callDatePicker2() async {
    print("ENTREEEEE");
    var selectedDate = await getDatePickerWidget2();

    setState(() {
      _loadName().then((_){
      _currentSelectdDataFinal = selectedDate;
      Ano2 = int.parse(_currentSelectdDataFinal.year.toString());
      mes2 = int.parse(_currentSelectdDataFinal.month.toString());
      dia2 = int.parse(_currentSelectdDataFinal.day.toString());
      Printfecha2 = _currentSelectdDataFinal.year.toString() +
          "-" +
          _currentSelectdDataFinal.month.toString() +
          "-" +
          _currentSelectdDataFinal.day.toString();
      });
    });
  }

  Future<DateTime?> getDatePickerWidget2() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _currentSelectdData,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );
  }

  late String Printfecha = "";
  late String Printfecha2 = "";
  late int Ano1 = 0;
  late int mes1 = 0;
  late int dia1 = 0;
  late int Ano2 = 0;
  late int mes2 = 0;
  late int dia2 = 0;
  late int Datos = 0;
  List Prom=[0];
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(widget.index),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Control Mensual", style: TextStyle(fontSize: 20)),
      ),
      body: Center(
        child: isLoading
        ?  Column(
          children: [
             SizedBox(height: 20),
            Text("Fecha inicial: " + Printfecha,
                style: TextStyle(fontSize: 20)),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                "Elegir fecha",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                
                callDatePicker();
              },
            ),
            Text("Fecha final: " + Printfecha2, style: TextStyle(fontSize: 20)),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                "Elegir fecha",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                
                callDatePicker2();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      
                      int Longitud_lista=Prom.length;
                      for (var j = Longitud_lista-1; j >=0  ; j--) {
                        Prom.removeAt(j);
                      }
                      print(Prom);
                      GradicaMensual();
                    print(Prom);
                    print(isLoading);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Minimo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        
              
              
                          int Longitud_lista=Prom.length;
                      for (var j = Longitud_lista-1; j >=0  ; j--) {
                        Prom.removeAt(j);
                      }
                      print(Prom);
                      GradicaMensualProm();
                    print(Prom);
                    print(isLoading);
                           
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Promedio',
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
                  GestureDetector(
                    onTap: (){
                      int Longitud_lista=Prom.length;
                      for (var j = Longitud_lista-1; j >=0  ; j--) {
                        Prom.removeAt(j);
                      }
                      print(Prom);
                      GradicaMensualMax();
                    print(Prom);
                    print(isLoading);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Maximo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           Center(
            child:LinearChartMes(Prom, dia1)
           )
          ],
        )
        : Column(
          children: [
             SizedBox(height: 20),
            Text("Fecha inicial: " + Printfecha,
                style: TextStyle(fontSize: 20)),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                "Elegir fecha",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                
                callDatePicker();
              },
            ),
            Text("Fecha final: " + Printfecha2, style: TextStyle(fontSize: 20)),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                "Elegir fecha",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                
                callDatePicker2();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){GradicaMensual();
                    print(Prom);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Minimo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        
              
              
                           print(Prom);
                           Center(
                          child:LinearChartMes(Prom, dia1),
                           );
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Promedio',
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
                  GestureDetector(
                    onTap: (){
                      int Longitud_lista=Prom.length;
                      for (var j = Longitud_lista-1; j >=0  ; j--) {
                        Prom.removeAt(j);
                      }
                      print(Prom);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Maximo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
