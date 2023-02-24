import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';



late TrackballBehavior _trackballBehavior;
void initState(){
_trackballBehavior= TrackballBehavior(
  enable: true,
  tooltipSettings:  InteractiveTooltip(
    
  )
);

}


class LinearCharts extends StatelessWidget {
  final valor1;
  final valor2;
  final valor3;
  final valor4;
  final valor5;
  final valor6;
  final valor7;
  final valor8;
  final valor9;
  final valor10;
  final valor11;
  final valor12;
  

  const LinearCharts(this.valor1,this.valor2,this.valor3,this.valor4,this.valor5,this.valor6,this.valor7,this.valor8,this.valor9,this.valor10,this.valor11,this.valor12,{super.key});
  
  

  @override
  
  Widget build(BuildContext context) {


    final data =[
      Expenses(00, valor1),
      Expenses(02, valor2),
      Expenses(04, valor3),
      Expenses(06, valor4),
      Expenses(08, valor5),
      Expenses(10, valor6),
      Expenses(12, valor7),
      Expenses(14, valor8),
      Expenses(16, valor9),
      Expenses(18, valor10),
      Expenses(20, valor11),
      Expenses(22, valor12),
      Expenses(24, valor12),
      
    ];

    List<charts.Series<Expenses, int>> series = [
      charts.Series<Expenses,int>(
        id: 'Lineal',
        
        domainFn: (v,i)=>v.hours,
        measureFn: (v,i)=>v.temp,
        data: data
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
    /*return SafeArea(child: Scaffold(
      body: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        series:<ChartSeries>[
        
        LineSeries<Expenses, int>(dataSource: data,
          xValueMapper: (v,i)=>v.hours,
          yValueMapper: (v,i)=>v.temp,
        )
      ]),

    ));*/


  }


  
}

class Expenses{
  final int hours;
  final num temp;

  Expenses(this.hours,this.temp);


}