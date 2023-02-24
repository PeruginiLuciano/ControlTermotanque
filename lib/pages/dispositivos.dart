import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba/data_base/data_base.dart';
import 'package:prueba/data_base/temperaturas.dart';

class dispositivos extends StatefulWidget {
  const dispositivos({super.key});

  @override
  State<dispositivos> createState() => _dispositivosState();
}

class _dispositivosState extends State<dispositivos> {
  List<Dispositivos> disp = [];
  @override
  void initState() {
    cargaDispositivo();
    super.initState();
  }
  final user = FirebaseAuth.instance.currentUser!;
  cargaDispositivo() async {
    List<Dispositivos> auxDispositivo = await DisDataBase.dispositovo();
    setState(() {
      int j=0;
      for (var i=0; i<auxDispositivo.length;i++){
          if (auxDispositivo[i].Email.toString()==user.email.toString()){
            
            disp[j] = auxDispositivo[i];
            j++;
          }
      }
      
    });
  }



  Widget build(BuildContext context) {
    return ListView.builder(
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
            child: ListTile(
                title: Text(disp[i].Nombre.toString()),
                trailing: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/editar",
                          arguments: disp[i]);
                    },
                    child: Icon(Icons.edit)))));
  }
}
