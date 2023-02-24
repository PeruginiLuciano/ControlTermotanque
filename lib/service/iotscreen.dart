import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba/service/userservice.dart';



class IotScreen  extends StatefulWidget {
  

  @override
  _IotScreenState createState()=> _IotScreenState();
}

class  _IotScreenState extends State <IotScreen > with TickerProviderStateMixin {
  final dbRef=FirebaseDatabase.instance.ref();
  late AnimationController progressController;
  late Animation<double> tempAnomation;
  late Animation<double> Maximmo;
  @override

  void initState(){
    super.initState();
    dbRef.child("Dispositivo4/Sensores").once().then(( event){
      double temp=(event.snapshot.value as Map)["Temperatura"];

      _DashboardInit(temp, 50.1);
      print("Entreee"+temp.toString());

    });


    
  }
  

    _DashboardInit (double temp, double maz){
    progressController=AnimationController(vsync: this,duration:  Duration(milliseconds: 5000));

    tempAnomation=Tween<double>(begin: -40,end: temp).animate(progressController)..addListener(() { setState(() {
      
    }); });
      progressController.forward();

    }
  
    
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      body: StreamBuilder(
        stream: dbRef.child("Dispositivo4/Sensores").onValue,
        
        builder: (context, snapshot) {
          _DashboardInit(1.0, 1.0);
          if(snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null){
            final datos= snapshot.data!.snapshot.value;
             final datoss= (snapshot.data!.snapshot.value as Map)["Temperatura"];
              
              _DashboardInit(datoss, 1.0);

            

            
          return Column(
            children: [
              Padding(padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.clear_all,color: Colors.black,),
                  Text("Mi dispositivo ", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                  ),
                 
                    
                  ),
                   Icon(Icons.settings)
                ],
      
              ),),
              
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CustomPaint(
                  
                  foregroundPainter: CircleProgress(tempAnomation.value, true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: <Widget>[
                            
                            Text('Temperaturas'),
                            Text('${tempAnomation.value.toInt()}',
                            style: TextStyle(
                              fontSize: 50,fontWeight: FontWeight.bold
                            ),),
                            Text("ºC", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold
                            ),),
                          ],
                        )
                      ),
                    )
                      // ignore: unused_local_variable
                    
                      //Padding(padding: const EdgeInsets.all(8.0),
                        //  child: 
                          
                        //  Text("Temperatura: "+(datos as Map)['Temperatura'].toString()                  
                      //,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
                      //),
                      
                      //SizedBox(height: 20,),
                      //Text("Temperatura maxima: "+(datos as Map)['TemperaturaMax'].toString()                  
                      //,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
                      //SizedBox(height: 20,),
                      //Text("Temperatura minima "+(datos as Map)['TemperaturaMin'].toString()                  
                      //,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
                      ),
                    ],
                  ),
                
              
              SizedBox(height: 20,),
            ],
          );
          } else{
            return Column(
              
            children: [
              
              Padding(padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.clear_all,color: Colors.black,),
                  Text("My dispositivo ", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                  ),
                 
                    
                  ),
                   Icon(Icons.settings)
                ],
      
              ),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Temperatura",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(padding: const EdgeInsets.all(8.0),
                      child: Text("...",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
                      ),
                      
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
            ],
          );
          }
        }
      ),



    );
  }

  

}