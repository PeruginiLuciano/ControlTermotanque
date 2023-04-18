import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba/auth/linear_charts.dart';
import 'package:prueba/service/controlHome.dart';
import 'package:prueba/service/userservice.dart';
//import 'package:path/path.dart';
import '../auth/nav_bar.dart';
import '../data_base/data_base.dart';
import '../data_base/temperaturas.dart';
import '../pages/dispo_sitivos.dart';
import '../pages/home_page.dart';
import 'control.dart';

class historico extends StatefulWidget {
  final index;
  final  DateTime fechaComienzo;
  const historico(this.index,this.fechaComienzo, {super.key});
  
  @override
  State<historico> createState() => _historicoState();
}

class _historicoState extends State<historico>
    with SingleTickerProviderStateMixin {
  //Dia
  bool isLoading = false;
  final databaseReference = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;
  late AnimationController progressController;
  late Animation<num> tempAnomations;
  late Animation<num> tempMAx;
  late Animation<num> tempMin;
  num valor1=0;
   num valor2=0;
   num valor3=0;
   num valor4=0;
  num valor5=0;
   num valor6=0;
   num valor11=0;
   num valor12=0;
   num valor13=0;
   num valor14=0;
   num valor15=0;
   num valor16=0;
  num Promedios=0;
  num Temperatura=0;
  
  int j = 0;
  var _currentSelectdData;
  
  

  void callDatePicker() async {
    print("ENTREEEEE");
    var selectedDate=await getDatePickerWidget();
    setState(() {
      _currentSelectdData = selectedDate;
      Printfecha=_currentSelectdData.year.toString()+"-"+_currentSelectdData.month.toString()+"-"+_currentSelectdData.day.toString();
      Navigator.push(context,
                  MaterialPageRoute(builder: (context) => historico(widget.index,_currentSelectdData)));
    });
    
  } 
  Future<DateTime?> getDatePickerWidget(){
    return showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2025),
    
    builder: (context,child){
      return Theme(data: ThemeData.dark(), child: child!);
    },
    );
  }
  static String fecha = '2020/12/16';

  static String fecha2 = fecha.replaceAll('/', '-');
  late String Printfecha=""; 
    late  DateTime date = widget.fechaComienzo;
  late String Meses=date.month.toString();
  late String Dias=date.day.toString();
  final List<String> disp = [];
  final List<String> Nombres = [];
  Future<void> _loadName() async {
    final user = FirebaseAuth.instance.currentUser!;
    final CollectionReference dispCollection = FirebaseFirestore.instance.collection(user.email.toString());
    
    final querySnapshot = await dispCollection.get();
    querySnapshot.docs.forEach((document) {
      final data = document.data() as Map<String, dynamic>;
      final codigo = data['Nombre'] as String;
      final codigo2 = data['Codigo'] as String;
      Nombres.add(codigo);
      disp.add(codigo2);
    });
    
  }
 // ignore: non_constant_identifier_names


  late  String fechaActual = date.year.toString() +
      "-" +
      date.month.toString() +
      "-" +
      date.day.toString();
  @override
  void initState() {
    
    super.initState();
    _loadName().then((_) {
      cargaAnimales();
    });
  }
  
  cargaAnimales() async {
    //List<Dispositivos> auxAnimal = await DisDataBase.dispositovo();

    setState(() {
      /*for (var i = 0; i < auxAnimal.length; i++) {
        if (auxAnimal[i].Email.toString() == user.email.toString()) {
          disp.insert(j, auxAnimal[i]);
          j++;
        }
      }
      j = 0;*/
      try {
        if ((Meses.length)==1){
          Meses="0"+Meses;
          
        }
        if ((Dias.length)==1){
          Dias="0"+Dias;
          
        }
        fechaActual=date.year.toString() +
      "-" +
      Meses+
      "-" +
      Dias;
        databaseReference
            .child(
                disp[widget.index] + "/Fecha/" + fechaActual)
            .once()
            .then((event) {
          num tem = (event.snapshot.value as Map)["Temperatura"];
          num temX = (event.snapshot.value as Map)["TemperaturaMax"];
          num temM = (event.snapshot.value as Map)["TemperaturaMin"];
          cargaHorarios();
          Temperatura=_Promedios(valor1,valor11,valor2,valor12,valor3,valor13,valor4,valor14,valor5,valor15,valor6,valor16,tem);
          isLoading = true;
          
          _DashboardInit(Temperatura, temX, temM);
        });
      } catch (e) {
        isLoading = false;
      }
    });
  }
  cargaHorarios(){
    databaseReference
            .child(
                disp[widget.index] + "/Fecha/" + fechaActual+"/Hora" )
            .once()
            .then((event) {
          valor1=(event.snapshot.value as Map)["00"];
          valor11=(event.snapshot.value as Map)["02"];
          valor2=(event.snapshot.value as Map)["04"];
          valor12=(event.snapshot.value as Map)["06"];
          valor3=(event.snapshot.value as Map)["08"];
          valor13=(event.snapshot.value as Map)["10"];
          valor4=(event.snapshot.value as Map)["12"];
          valor14=(event.snapshot.value as Map)["14"];
          valor5=(event.snapshot.value as Map)["16"];
          valor15=(event.snapshot.value as Map)["18"];
          valor6=(event.snapshot.value as Map)["20"];
          valor16=(event.snapshot.value as Map)["22"];
        });
  }
  _DashboardInit(num tem, num temX, num temM) {
    progressController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    tempAnomations =
        Tween<num>(begin: -50, end: tem).animate(progressController)
          ..addListener(() {
            setState(() {});
          });
    tempMAx = Tween<num>(begin: -50, end: temX).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    tempMin = Tween<num>(begin: -50, end: temM).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    progressController.forward();
  }

  num _Promedios(num v1,num v2,num v3,num v4,num v5,num v6,num v7,num v8,num v9,num v10,num v11,num v12,num temp){
    num promedios=0;
    
    if(v1!=0){
      if(v2!=0){
        if(v3!=0){
          if(v4!=0){
            if(v5!=0){
              if(v6!=0){
                if(v7!=0){
                  if(v8!=0){
                    if(v9!=0){
                      if(v10!=0){
                        if(v11!=0){
                          if(v12!=0){
                            promedios=(v2+v1+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12)/12;
                          }else{
                            promedios=(v2+v1+v3+v4+v5+v6+v7+v8+v9+v10+v11)/11;
                          }
                        }else{
                          promedios=(v2+v1+v3+v4+v5+v6+v7+v8+v9+v10)/10;
                        }
                      }else{
                        promedios=(v2+v1+v3+v4+v5+v6+v7+v8+v9)/9;
                      }
                    }else{
                      promedios=(v2+v1+v3+v4+v5+v6+v7+v8)/8;
                    }
                  }else{
                    promedios=(v2+v1+v3+v4+v5+v6+v7)/7;
                  }
                }else{
                  promedios=(v2+v1+v3+v4+v5+v6)/6;
                }
              }else{
                promedios=(v2+v1+v3+v4+v5)/5;
              }
            }else{
              promedios=(v2+v1+v3+v4)/4;
            }
          }else{
            promedios=(v2+v1+v3)/3;
          }
        }else{
          promedios=(v2+v1)/2;
        }
      }else{
        promedios=v1;
      }
    }else{
      promedios=temp;
    }
    return promedios;
  }
  
  @override
  Widget build(BuildContext context) {
    Printfecha=widget.fechaComienzo.year.toString()+"-"+widget.fechaComienzo.month.toString()+"-"+widget.fechaComienzo.day.toString();
    try {
      cargaHorarios();
      Promedios=_Promedios(valor1,valor11,valor2,valor12,valor3,valor13,valor4,valor14,valor5,valor15,valor6,valor16,Temperatura);
      return WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(widget.index)));
          return true;
          
        },
        child: Scaffold(
          drawer: NavBar(widget.index),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Control historico", style: TextStyle(fontSize: 20)),
          ),
          body: Center(
            child:SingleChildScrollView(
            child: isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          Text("Fecha seleccionada: "+Printfecha,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          TextButton(
                              onPressed: (){callDatePicker();
                                
                                print("LLEgue aca");
                                print("$_currentSelectdData");
                              },
                              
                              child:
                                
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Center(
                                    
                                    child: 
                                    
                                    ListTile(
                                      
                                          leading: Icon(Icons.calendar_month),
                                          title: Text("Cambiar fecha",style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold),),
                                          onTap: () {
                                           callDatePicker();
                                          },
                                        ),
                                  ),
                                ),
                          )
                        ],
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Center(
                                
                                child: CustomPaint(
                                  foregroundPainter:
                                      CircleProgress(tempMin.value, true),
                                  child: Container(
                                    width: 120,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${tempMin.value.toInt()}' + ' ºC',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Minima",style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: CustomPaint(
                                  foregroundPainter:
                                      CircleProgressActual(tempAnomations.value),
                                  child: Center(
                                    child: Container(
                                      width: 120,
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${tempAnomations.value.toInt()}' +
                                                  ' ºC',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("Promedio",style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomPaint(
                                foregroundPainter:
                                    CircleProgress(tempMAx.value, false),
                                child: Container(
                                  width: 120,
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${tempMAx.value.toInt()}' + ' ºC',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Maxima",style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          
                        ),
                      ),
                      Center(
                        
                        child: 
                        
                        LinearCharts(valor1,valor11,valor2,valor12,valor3,valor13,valor4,valor14,valor5,valor15,valor6,valor16)
                      )
                      
                    ],
                  )
            
                : Center(
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,        
      
                          
                          children: [
                            Text("No Hay datos en la fecha seleccionada\n",style: TextStyle(fontSize: 20),),  
                            Text("Fecha seleccionada: "+Printfecha),
                            ListTile(
                                    
                                        
                                        
                                        title: Text("Cambiar fecha",style: TextStyle(fontSize: 18,color: Colors.blue),),
                                        leading: Icon(Icons.calendar_month),
                                        onTap: () {
                                         callDatePicker();
                                        },
                                      ),
                          ],
                        ),
                )
          ),
          )
        ),
      );
    } catch (e) {
      print("acaaaaaaaaa"+valor1.toString()+valor2.toString()+valor3.toString()+valor4.toString()+valor5.toString()+valor6.toString());
      return WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(widget.index)));
          return true;
        },
        child: Scaffold(
          body: Center(
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,        
      
                          
                          children: [
                            Text("No Hay datos en la fecha seleccionada\n",style: TextStyle(fontSize: 20),),  
                            Text("Fecha seleccionada: "+Printfecha),
                            ListTile(
                                    
                                        
                                        
                                        title: Text("Cambiar fecha",style: TextStyle(fontSize: 18,color: Colors.blue),),
                                        leading: Icon(Icons.calendar_month),
                                        onTap: () {
                                         callDatePicker();
                                        },
                                      ),
                          ],
                        ),
                )
        ),
      );
    }
  }
}
