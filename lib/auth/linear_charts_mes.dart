import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prueba/auth/linear_charts.dart';

class LinearChartMes extends StatelessWidget{
  final Dia;
  final List Valores;
  const LinearChartMes(this.Valores,this.Dia,{super.key});
  
  @override
  
  
  Widget build(BuildContext context){
    
    
    List<Expenses2> data2=[];
    int valorest;
    int Diass=Dia;
    int i=0;
    for( i=0;i<Valores.length;i++){
        
        data2.add(Expenses2(Diass+i,Valores[i]));
        
          
           
        
        
    }
    i=0;
    List<charts.Series<Expenses2,int>> series = [
      charts.Series<Expenses2,int>(
        id: 'Line',

        domainFn: (v,i)=>v.dia,
        measureFn: (v,i)=>v.valor,
        data: data2
        )
    ];



    return Center(
      child: SizedBox(
        height: 270.0,
        child: charts.LineChart(
            series
        ),
      ),

    );
  }


  


}
class Expenses2{
    final int dia;
    final num valor;

    Expenses2(this.dia,this.valor);
  }