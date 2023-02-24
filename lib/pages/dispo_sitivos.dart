import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba/data_base/temperaturas.dart';
import 'package:prueba/pages/editar_disp.dart';
import 'package:prueba/main.dart';
import 'package:prueba/pages/home_page.dart';
import '../data_base/data_base.dart';
import 'agregarDispositivo.dart';

class Listado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Dispositivos"),
        ),
        body: Container(child: Lista()));
  }
}

class Lista extends StatefulWidget {
  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Dispositivos> disp = [];
  int j=0;
  @override
  void initState() {
    cargaAnimales();
    super.initState();
  }
  final user = FirebaseAuth.instance.currentUser!;
  cargaAnimales() async {
    List<Dispositivos> auxAnimal = await DisDataBase.dispositovo();

    setState(() {
      
      for (var i=0; i<auxAnimal.length;i++){
          if (auxAnimal[i].Email.toString()==user.email.toString()){
            
            disp.insert(j, auxAnimal[i])  ;
            j++;
          }
      }
      j=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return 
   
    ListView.builder(
      
        itemCount: disp.length,
        itemBuilder: (context, i) => Dismissible(
            key: Key(i.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Colors.white))),
            onDismissed: (direction) {
              DisDataBase.delete(disp[i]);
            },
            
            child: Container(
              
              
              color: Colors.green[100],
              child: Padding(
                
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    
                    title: Text(disp[i].Nombre.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Text("Serie: "+disp[i].Codigo.toString()),
                    leading: Icon(Icons.perm_device_info),
                    
                    onTap: (){
                     
                      Fluttertoast.showToast(
                        msg: disp[i].Codigo.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(i)));
                    },
                    ),
              ),
            )));
            Scaffold(floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => agregarDisp()));
            }),);
  }
}
