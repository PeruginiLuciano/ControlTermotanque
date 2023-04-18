import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';
import 'package:prueba/data_base/temperaturas.dart';
import 'package:prueba/pages/dispo_sitivos.dart';
import 'package:prueba/pages/dispositivos.dart';
import 'package:prueba/pages/dispositivosFirebase.dart';
import 'package:prueba/pages/home_page.dart';
import 'package:prueba/pages/pruebas.dart';
import 'package:prueba/pages/relay.dart';

import 'package:prueba/pages/splash_out_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba/service/acercaDe.dart';
import 'package:prueba/service/control.dart';
import 'package:prueba/service/historico.dart';
import 'package:prueba/service/iotscreen.dart';
import 'package:prueba/service/mensual.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavBar extends StatelessWidget {
  final index;
  NavBar(this.index);
  final user = FirebaseAuth.instance.currentUser!;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final List data=[];
  gett(String Nombre) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("Usuarios")
          .where('Email', isEqualTo: Nombre)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print("GHddf");
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(
              "",
              style: TextStyle(color: Colors.black),
            ),
            /*currentAccountPicture: CircleAvatar(
            child: ClipOval(
              
              child: Image.asset('lib/assets/logoblk.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,)
            ),
          ),*/
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://ci6.googleusercontent.com/proxy/ZoOWUdXR65iTiBzj9Aophu9aYCOIivxLCo4hOzhbRe7OKd49WvvWtZfA5yskPnlPPs6ODEI5Ag=s0-d-e1-ft#https://enertik.ar/firma/enertik.gif'),
                    fit: BoxFit.contain)),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.green,),
            title: Text("Inicio"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(index)));
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt,color: Colors.green,),
            title: Text("Diario"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => control(index)));
            },
          ),
          ListTile(
            leading: Icon(Icons.poll,color: Colors.green,),
            title: Text("Estadisticas"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => historico(index,DateTime.now())));
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>IotScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone_android,color: Colors.green,),
            title: Text("Dispositivos"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (UserListScreen())));
            },
          ),
          ListTile(
            leading: Icon(Icons.apartment_sharp,color: Colors.green,),
            title: Text("Mensual"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (mensual(index,data))));
              //launchUrlString("https://enertik.ar/la-empresa");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_input_component, color: Colors.green,),
            title: Text("Automatizacion"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (relay(index))));
              //launchUrlString("https://enertik.ar/la-empresa");
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_stories,color: Colors.green,),
            title: Text("Acerca de..."),
            onTap: ((){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (AcercaDe(index))));
            })
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app,),
            title: Text("Salir"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SplashScreenOut()));
            },
          ),
        ],
      ),
    );
  }
}
