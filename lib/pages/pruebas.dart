import 'package:flutter/material.dart';
import 'package:prueba/service/barraNivel.dart';

class Nivel extends StatefulWidget {
  const Nivel({super.key});

  @override
  State<Nivel> createState() => _NivelState();
}

class _NivelState extends State<Nivel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        CustomPaint(
          foregroundPainter:BarraNivelProgressActual(1) ),
         ],
        )
        
     
      )
    );
  }
}