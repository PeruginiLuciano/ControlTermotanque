
import 'dart:math';

import 'package:flutter/material.dart';

class BarraNivelProgressActual extends CustomPainter{
  num value;

  BarraNivelProgressActual(this.value);
@override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
void paint(Canvas canvas, Size size){
Paint nivel=Paint();
double maximumValue=200;
Paint fondoNivel = Paint()
                  ..strokeWidth=40
                  ..color=Colors.grey
                  ..style=PaintingStyle.stroke
                  ..strokeCap = StrokeCap.round;
    
    if (value>75){
    
    nivel
    ..strokeWidth=40
    ..color=Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
    
    }
    
    else if (value>50){
    
    nivel
    ..strokeWidth=40
    ..color=Colors.yellow
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
    
    }else if( value>25){
    nivel
    ..strokeWidth=40
    ..color=Colors.green 
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;}
    else{
    nivel
    ..strokeWidth=40
    ..color=Colors.blue 
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;}
    Offset center3 =Offset(0,0);
    Offset center4= Offset(maximumValue, 0);
    canvas.drawLine(center3, center4, fondoNivel);
    Offset center =Offset(0,0);
    Offset center2 = Offset(value*2, 0);
    canvas.drawLine(center, center2, nivel);
    
}
}