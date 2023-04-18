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
class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final CollectionReference dispCollection = FirebaseFirestore.instance.collection(user.email.toString());
    
    return StreamBuilder<QuerySnapshot>(
      stream: dispCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error al cargar los usuarios');
        }
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final Object? data = document.data();
            
            final list = snapshot.data!.docs.toList();
            final map = list.asMap();
            final index = map.entries.firstWhere((entry) => entry.value.id == document.id).key ;
            return  Dismissible(
              key: Key(document.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                dispCollection.doc(document.id).delete();
              },
              child: Card(
                color: Colors.green[100],
                child: ListTile(
                  title: Text((data as Map)['Nombre'],style: TextStyle(fontSize: 20),),
                  subtitle: Text("Serie: "+(data as Map)['Codigo']),
                  onTap:() {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(index)));
                    print(index);
                    },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
class UserListScreen extends StatelessWidget {
  static const String routeName = '/user-list';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.green,
                title: Text("Lista de dispositivos",
                    style: TextStyle(fontSize: 20)),
                actions: [
                  
                ],
              ),
      
      body: UserList(),
    );
  }
}