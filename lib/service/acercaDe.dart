import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/nav_bar.dart';


class AcercaDe extends StatefulWidget {
  final index;
  const AcercaDe(this.index ,{super.key});

  @override
  State<AcercaDe> createState() => _AcercaDeState();
}

class _AcercaDeState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(widget.index),
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Acerca de...", style: TextStyle(fontSize: 20)),
            ),
      body: Center(
        child:SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Fluttertoast.showToast(
                      msg: "Control de temperatura\nDesarrollo: Luciano Perugini",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 2,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: Image.asset('lib/assets/acercade.JPG',width: 200,height: 90,),
                
              ),
              //SizedBox(
              //height: 100.0,
              //width: 200.0,
              //child: Image.asset('lib/assets/acercade.JPG'),
              
              //),
            Text("HISTORIA",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              
              child: 
              
              
              Text("Nuestra empresa fue fundada en 2002 para brindar soluciones de energía renovables, conversión de energía eléctrica y control de sistemas eléctricos. Sin embargo, a través de los años, se ha ido generando un cambio de rumbo de la empresa frente a las nuevas necesidades del mercado, lo cual nos ha permitido ampliar notablemente nuestra oferta de productos. Desde nuestros comienzos el crecimiento ha sido continuo. Basado en la confianza duradera y el acompañamiento mutuo con nuestros clientes, muchos de los cuales nos siguen acompañando."),
            ),
             Text("VALORES",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              
              child: 
              
              
              Text("- Atención y asesoramiento profesional durante el proceso de venta y pos-venta.\n- Integridad y transparencia en nuestro accionar.\n- Curiosidad e investigación frente a futuras tecnologías.\n- Esfuerzo en dar forma a un futuro más sustentable.\n- Orgullo de formar parte de un cambio positivo a la convivencia con el medio ambiente."),
            ),
            Text("FILOSOFÍA",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              
              child: 
              
              
              Text("Mantenernos en constante investigación y desarrollo para proveer a nuestros clientes de soluciones energéticas diversificadas, confiables, competitivas y sustentables."),
            ),
            Text("MISIÓN",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              
              child: 
              
              
              Text("Proveer a nuestros clientes de todos los insumos necesarios para obtener energía desde fuentes renovables y amigables con el medio ambiente."),
            ),
            Text("VISIÓN",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              
              child: 
              
              
              Text("Ser una empresa líder en la provisión de insumos y desarrollo de proyectos de energías renovables."),
            ),
            SizedBox(height: 20,),
            Text(" Version 1.0.0", style:TextStyle(fontSize: 12))        
            ]
        ),
      ),



    ),
        
        );
  }
}