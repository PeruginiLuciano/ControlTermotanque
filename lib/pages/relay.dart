import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba/auth/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_base/data_base.dart';
import '../data_base/temperaturas.dart';
class relay extends StatefulWidget {
  final index;
  const relay(this.index,{super.key});

  @override
  State<relay> createState() => _relayState();
}

class _relayState extends State<relay> {
  late bool estadoTemp=false;
  late bool estadoNivel=false;
  late bool automaticoTemp=false;
  late bool automaticoNivel=false;
  late int Temp=0;
  late int TempMax=0;
  late int Nivel=0;
  late int NivelMax=0;
  late bool NivelActivo=false;
  late String _currentTempActivo="Activar";
  late String  _currentNivelActivo="Activar";
  late String _Fecha="";
  late String _FechaCambio="";
  Future<SharedPreferences> prefss =  SharedPreferences.getInstance();
  final user = FirebaseAuth.instance.currentUser!;
  final firebaseRealtime = FirebaseDatabase.instance.ref();
  
  List<Dispositivos> disp=[];
  int j=0;
  @override
  void initState(){
    super.initState();
    _loadCounter();
  }
 
  

  final prefs = SharedPreferences.getInstance();
  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Dispositivos> auxAnimal = await DisDataBase.dispositovo();
    setState(() {
      _currentTempActivo=prefs.getString('currentTemp')!;
      _currentNivelActivo=prefs.getString('currentNivel')!;
      /*automaticoTemp=prefs.getBool('autoTemp')!;
      automaticoNivel=prefs.getBool('autoNivel')!;
      estadoTemp=(prefs.getBool('estadoTemp')?? false);
      estadoNivel=prefs.getBool('estadoNivel')!;
      Nivel=prefs.getInt('counterNivel')!;
      Temp=prefs.getInt('counterTemp')!;
      NivelMax=prefs.getInt('counterNivelMax')!;
      TempMax=prefs.getInt('counterTempMax')!;
      NivelActivo=prefs.getBool('NivelActivo')!;*/
      for (var i = 0; i < auxAnimal.length; i++) {
        if (auxAnimal[i].Email.toString() == user.email.toString()) {
          disp.insert(j, auxAnimal[i]);
          j++;
        }
      }

      j = 0;

      try{
        if (disp.length>0){
          final path = disp[widget.index].Codigo.toString()+"/Anodo";
          firebaseRealtime.child(path).once().then((event){
            String _fecha = (event.snapshot.value as Map)["Fecha"];
            String _fechaCambio = (event.snapshot.value as Map)["FechaCambio"];
            _Fecha=_fecha;
            _FechaCambio=_fechaCambio;
          });
        }
        RecuperarDatosIniciales();
      }catch(e){

      }
    });
  }
  
  void anadirFirebase(){
    firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("Nivel").set({
      "Nivel" : Nivel,
    });
    firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlANivel").set({
      "Estado" : automaticoNivel,
      "Inicio" : Nivel,
    });
  }
  void _guardaValores() async{
    SharedPreferences prefst =await SharedPreferences.getInstance();
    setState(() {
      prefst.setString('currentTemp',_currentTempActivo);
      prefst.setString('currentNivel',_currentNivelActivo);
      
    });
  }
  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      if((Temp+20)<TempMax){
      Temp++;}
      prefs.setInt('counterTemp', Temp);
      firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlATemp").set({
          "Inicio" : Temp,
          "Fin" : TempMax,
          "Estado" : automaticoTemp
          });
    });
  
  }
  void _incrementCounterMax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      

      TempMax++;
      if(TempMax==95){
        showDialog(context: context,builder: (BuildContext context){
                                        return AlertDialog(
                                          title: const Text("ALERTA"),
                                          content:  Text("Setear una temperatura por arriba de los 95 grados podria dañar el equipo, al aceptar esta advertencia se hace cargo de los posibles inconvenientes"),
                                          actions:<Widget> [
                                            TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                                            
                                          ],
                                        );
                                      });
      }

      firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlATemp").set({
          "Inicio" : Temp,
          "Fin" : TempMax,
          "Estado" : automaticoTemp
          });
    });
  
  }
  void _decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
    
      Temp--;
      prefs.setInt('counterTemp', Temp);
      
      firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlATemp").set({
          "Inicio" : Temp,
          "Fin" : TempMax,
          "Estado" : automaticoTemp
          });
    
    });
  
  }
   void _decrementCounterMax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      if((TempMax-20)>Temp){
      TempMax--;}
      if(TempMax<0){
        TempMax=0;
      }
     
      firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlATemp").set({
          "Inicio" : Temp,
          "Fin" : TempMax,
          "Estado" : automaticoTemp
          });
    });
  
  }
  void _incrementNivelCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      if(!automaticoNivel){
      Nivel=Nivel+25;}
     
      anadirFirebase();
    });
  
  }
  void _incrementNivelCounterMax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
    
      NivelMax=NivelMax+25;
      prefs.setInt('counterNivelMax', NivelMax);
      anadirFirebase();
    });
  
  }
  void _decrementNivelCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
      if(!automaticoNivel){
      Nivel=Nivel-25;}
      prefs.setInt('counterNivel', Nivel);
      anadirFirebase();
    });
  
  }
  void _decrementNivelCounterMax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
    
      NivelMax=NivelMax-25;
      prefs.setInt('counterNivelMax', NivelMax);
      anadirFirebase();
    });
  
  }
  void setTempManual(){

  }
  var _currentSelectData;
  var _currentSelectData2;

  late String  PrintFech="";
  late String PrintFechCambio="";
  late String MesAnodo;
  late String AgnoAnodo;
  late String DiaAnodo;
  void callDatePi() async{
    var selected = await getDatePickerWid();
     
    setState(() {
      _currentSelectData = selected;
      _currentSelectData2 = selected!.add((Duration(days: 180)));
      MesAnodo=_currentSelectData.month.toString();
      AgnoAnodo=_currentSelectData.year.toString();
      DiaAnodo=_currentSelectData.day.toString();
      PrintFech = _currentSelectData.year.toString() +
          "-" +
          _currentSelectData.month.toString() +
          "-" +
          _currentSelectData.day.toString();
      PrintFechCambio=_currentSelectData2.year.toString() +
          "-" +
          _currentSelectData2.month.toString() +
          "-" +
          _currentSelectData2.day.toString();
      _Fecha=PrintFech;
      _FechaCambio=PrintFechCambio;
      firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("Anodo").set({
        "Fecha" : PrintFech,
        "FechaCambio": PrintFechCambio
        });
    });
  }
  Future<DateTime?> getDatePickerWid(){
    return showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2021), 
    lastDate: DateTime.now());
  }

  void RecuperarDatosIniciales() async {

    try{
        if (disp.length>0){
          final pathAnodo = disp[widget.index].Codigo.toString()+"/Anodo";
          final pathANivel = disp[widget.index].Codigo.toString()+"/ControlANivel";
          final pathATemp = disp[widget.index].Codigo.toString()+"/ControlATemp";
          final pathNivel = disp[widget.index].Codigo.toString()+"/Nivel";
          final pathRelay = disp[widget.index].Codigo.toString()+"/NivelRelay";
          final pathREsistencia = disp[widget.index].Codigo.toString()+"/Resistencia";
          firebaseRealtime.child(pathAnodo).once().then((event){
            String _fecha = (event.snapshot.value as Map)["Fecha"];
            String _fechaCambio = (event.snapshot.value as Map)["FechaCambio"];
            _Fecha=_fecha;
            _FechaCambio=_fechaCambio;
          });
          firebaseRealtime.child(pathANivel).once().then((event){
            automaticoNivel = (event.snapshot.value as Map)["Estado"];
            Nivel = (event.snapshot.value as Map)["Inicio"];
            
          });
          firebaseRealtime.child(pathATemp).once().then((event){
            automaticoTemp = (event.snapshot.value as Map)["Estado"];
            Temp = (event.snapshot.value as Map)["Inicio"];
            TempMax = (event.snapshot.value as Map)["Fin"];
            
          });
          
          firebaseRealtime.child(pathREsistencia).once().then((event){
            estadoTemp = (event.snapshot.value as Map)["Estado"];
            
            
          });
          firebaseRealtime.child(pathRelay).once().then((event){
            estadoNivel = (event.snapshot.value as Map)["Estado"];
            
            
          });
        }
      }catch(e){

      }

  }
  @override
  Widget build(BuildContext context) {
    String userEmail = user.email.toString();
    _loadCounter();
    return Scaffold(
      drawer: NavBar(widget.index),
      appBar: AppBar(
        
        backgroundColor: Colors.green,
        title: Text("Control de sistema", style: TextStyle(fontSize: 20)),
      ),
      body: Center(
        child:SingleChildScrollView(
        
        child: Column(
          
          children: [
            SizedBox(height: 20,),
            Text("Control Anodo de sacrificio",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            Card(
              color: Colors.grey[300],
              
              child: SizedBox(
                width: 350,
                height: 50,
                child: Center(child: Text("El anodo fue cambiado el día: "+_Fecha+"\nEl siguiente cambio es el dia: "+_FechaCambio,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                
                ),
                
              
              ),
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[Text("Notifica cambio de anodo",style: TextStyle(fontWeight: FontWeight.bold),),
                        TextButton(onPressed: (){
                      callDatePi();
            },child: Text("Aqui")),]
            
            ),
            Divider(color: Colors.green,thickness: 2,),
            SizedBox(height: 20,),
            Text("Control Manual",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            Card(
              color: Colors.grey[300],
              child:SizedBox(
                width: 350,
                height: 125,
                child: Center(child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Relay temperatura", style: TextStyle(fontSize: 20)),
                            ),
                              Transform.scale(scale: 1.5,
                              child:Switch(value: estadoTemp, onChanged: (bool valueIn){
                                if(valueIn){
                                  showDialog(context: context,builder: (BuildContext context){
                                        return AlertDialog(
                                          title: const Text("Resistencia"),
                                          content:  Text("Acaba de de encender la resistencia\nEl estado del tanque es del %"+Nivel.toString()+"\nEs importante que el nivel del tanque este al menos en un 25%"),
                                          actions:<Widget> [
                                            TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                                            
                                          ],
                                        );
                                      });
                                }
                                setState(() {
                                  estadoTemp=valueIn;
                                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("Resistencia").set({
                                    "Estado" : estadoTemp,
                                    });
                                  _guardaValores();
                                });
                              },activeColor: Colors.green,)),
                            
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Relay Nivel", style: TextStyle(fontSize: 20)),
                            ),
                              Transform.scale(scale: 1.5,
                              child:Switch(value: estadoNivel, onChanged: 
                              
                              
                              (bool valueIn2){ 
                                
                                if(valueIn2){
                                  showDialog(context: context,builder: (BuildContext context){
                                      return AlertDialog(
                                        title: const Text("Bomba activada"),
                                        content: const Text("Acaba de encender la bomba de llenado del tanque"),
                                        actions:<Widget> [
                                          TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                                          
                                        ],
                                      );
                                    });
                                }

                                estadoNivel=valueIn2;
                                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("NivelRelay").set({
                                    "Estado" : estadoNivel,
                                    });
                                  _guardaValores();
                                
                                
                                
                              },activeColor: Colors.green,)),
                            
                        ],
                      ),
                    )
                    
                    ],
                  ) ),
                )
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.green,thickness: 2,),
            SizedBox(height: 20,),
             Text("Control automatico temperatura",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            Card(
              color: Colors.grey[300],
              child:SizedBox(
                width: 350,
                height: 360,
                child: Center(child:Column(
                  children: [
                    SizedBox(height: 15,),
                    Text("Minimo",style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          TextButton.icon(
                            icon: const Icon(Icons.expand_more,size: 100,color: Colors.green,),
                            label: const Text(""),
                            onPressed: (){

                              _decrementCounter();
                              
                              _guardaValores();
                              
                            },
                          ),
                          Text(Temp.toString(), style: TextStyle(fontSize: 50)),
                          TextButton.icon(
                            icon: const Icon(Icons.expand_less,size: 100,color: Colors.green,),
                            label: const Text(""),
                            onPressed: (){
                             _incrementCounter();
                             _guardaValores();
                            },
                          ),

                      ],
                    ),
                    Text("Maximo",style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          TextButton.icon(
                            icon: const Icon(Icons.expand_more,size: 100,color: Colors.green,),
                            label: const Text(""),
                            onPressed: (){
                              _decrementCounterMax();
                              _guardaValores();
                              
                            },
                          ),
                          Text((TempMax).toString(), style: TextStyle(fontSize: 50)),
                          TextButton.icon(
                            icon: const Icon(Icons.expand_less,size: 100,color: Colors.green,),
                            label: const Text(""),
                            onPressed: (){
                             _incrementCounterMax();
                             _guardaValores();
                            },
                          ),

                      ],
                    ),
                    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(_currentTempActivo, style: TextStyle(fontSize: 20)),
                ),
              Transform.scale(scale: 2.0,
              child:Switch(value: automaticoTemp, onChanged: (bool valueIn){
                if(valueIn){
                  showDialog(context: context,builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Resistencia automatica"),
                      content:  Text("Acaba de setear el control automatico de temperatura\nEl estado del tanque es del %"+Nivel.toString()+"\nEs importante que el nivel del tanque este al menos en un 25% "),
                      actions:<Widget> [
                        TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                        
                      ],
                    );
                  });
                }
                setState(() {
                  if(!automaticoTemp){
                  _currentTempActivo="Desactivar";}
                  else{_currentTempActivo="Activar";}
                  automaticoTemp=valueIn;
                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlATemp").set({
                  "Estado" : automaticoTemp,
                  "Inicio": Temp,
                  "Fin": TempMax,
                  });
                  _guardaValores();
                });
              },activeColor: Colors.green,)),
                ],
              ),
                    ],
                  ) ),
                )
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.green,thickness: 2,),
            SizedBox(height: 10,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text("Control automatico Nivel",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              Switch(value: NivelActivo, onChanged:(bool activo){
                setState(() {
                  NivelActivo=activo;
                  if(!NivelActivo){
                  automaticoNivel=NivelActivo;
                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlANivel").set({
                  "Estado" : automaticoNivel,
                  "Inicio":Nivel,
                  
                   });
                  }
                  _guardaValores();
                  
                });
                
              },activeColor: Colors.green, )
            ]
            ),
            Card(
              color: Colors.grey[300],
              child:SizedBox(
                width: 350,
                height: 200,
                child: Center(child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          TextButton.icon(
                            icon: const Icon(Icons.expand_more,size: 100,color: Colors.green),
                            label: const Text(""),
                            onPressed: (){
                              if(NivelActivo){
                              setState(() {
                                if(Nivel>1){
                              _decrementNivelCounter();
                              anadirFirebase();
                              _guardaValores();
                                }
                              
                              });
                              }else{
                                print("object");
                              }
                            },
                          ),
                          Text("%"+Nivel.toString(), style: TextStyle(fontSize: 40)),
                          TextButton.icon(
                            icon: const Icon(Icons.expand_less,size: 100,color: Colors.green,),
                            label: const Text(""),
                            onPressed: (){
                              if(NivelActivo){
                                setState(() {
                              
                                  if(Nivel<100){
                                _incrementNivelCounter();
                                
                                _guardaValores();
                                  }
                              });}else{print("Hola");}
                            },
                          ),

                      ],
                    ),
                    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(_currentNivelActivo, style: TextStyle(fontSize: 20)),
                ),
              Transform.scale(scale: 2.0,
              child:Switch(value: automaticoNivel, onChanged: (bool valueIn3){
                if (valueIn3 & NivelActivo){
                  if(Nivel<95){
                  showDialog(context: context,builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Nivel automatico"),
                      content: const Text("Acaba de setear el llenado automatico del tanque"),
                      actions:<Widget> [
                        TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                       
                      ],
                    );
                  });}else{
                    setState(() {
                      valueIn3=false;
                      automaticoNivel=false;
                    _currentNivelActivo="Activar";
                    });
                    
                    showDialog(context: context,builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Nivel automatico"),
                      content: const Text("No se puede enceder bomba con tanque a mas de un 95%"),
                      actions:<Widget> [
                        TextButton(onPressed:(){Navigator.of(context).pop(false);} , child: const Text("Entendido")),
                       
                      ],
                    );
                  });
                  }
                }else{
                  
                  
                }
                if(NivelActivo) {
                setState(() {
                  if(Nivel<95){
                  if(!automaticoNivel){
                    
                  _currentNivelActivo="Desactivar";}
                  else{_currentNivelActivo="Activar";}}
                  automaticoNivel=valueIn3;
                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlANivel").set({
                  "Estado" : automaticoNivel,
                  "Inicio":Nivel,
                  
                   });
                  _guardaValores();
                });}else{
                  setState(() {
                  automaticoNivel=false;
                  valueIn3=false;
                  _currentNivelActivo="Activar";
                  firebaseRealtime.child(disp[widget.index].Codigo.toString()).child("ControlANivel").set({
                  "Estado" : automaticoNivel,
                  "Inicio":Nivel,
                  
                   });
                  _guardaValores();  
                  });
                  
                }
              },activeColor: Colors.green,)),
                ],
              ),
                    ],
                  ) ),
                )
            ),
           SizedBox(height: 20,)
          ],
          
        ),
        
        ),
      ),
    );
  }
}