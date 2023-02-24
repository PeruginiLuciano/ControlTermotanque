import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserApellido extends StatelessWidget {
  final String documentId;

  GetUserApellido({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users= FirebaseFirestore.instance.collection('Usuarios');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
      if (snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text("Apellido: ${data["Apellido"]}");
      }
      return Text('cargando..');
    } ));
  }
}