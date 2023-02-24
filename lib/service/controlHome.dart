
import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressActual extends CustomPainter{
  num value;

  CircleProgressActual(this.value);

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
  @override
  void paint(Canvas canvas, Size size){
    Paint tempArc= Paint();
    int maximumValue =  110 ;
    Paint outerCircle = Paint()
    ..strokeWidth=14
    ..color=Colors.grey
    ..style = PaintingStyle.stroke;
    if (value>80){
    
    tempArc
    ..strokeWidth=14
    ..color=Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
    }else if( value>60){
    tempArc
    ..strokeWidth=14
    ..color=Colors.yellow 
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
    }else if( value>10){
    tempArc
    ..strokeWidth=14
    ..color=Colors.green 
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;}
    else{
    tempArc
    ..strokeWidth=14
    ..color=Colors.blue 
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;}
    Offset center = Offset(size.width /2,size.height/2);
    double radius = min(size.width /2,size.height/2)-14;
    canvas.drawCircle(center, radius,outerCircle);
    double angle = 2*pi*(value/maximumValue);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),-pi/2, angle, false, tempArc);
    
  }
  @override
  bool fondo (){
    if (value >70){
      return true;
    }else{return false;}

  }


}