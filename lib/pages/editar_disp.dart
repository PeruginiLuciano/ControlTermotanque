import 'package:flutter/material.dart';
import 'package:prueba/data_base/data_base.dart';
import 'package:prueba/data_base/temperaturas.dart';

class Editar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final especieController = TextEditingController();

  Editar(List<Dispositivos> disp);

  @override
  Widget build(BuildContext context) {
    Dispositivos? disp =
        ModalRoute.of(context)?.settings.arguments as Dispositivos;
    nombreController.text = disp.Nombre.toString();
    especieController.text = disp.Codigo.toString();

    return Scaffold(
        appBar: AppBar(title: Text("Guardar")),
        body: Container(
            child: Padding(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  controller: nombreController,
                  validator: (value) {
                    if (value!.isEmpty) return "El nombre es obligatorio";
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Nombre"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: especieController,
                  validator: (value) {
                    if (value!.isEmpty) return "La especie es obligatoria";
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Especie"),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (disp.id! > 0) {
                          disp.Nombre = nombreController.text;
                          disp.Codigo = especieController.text;
                          DisDataBase.update(disp);
                        } else
                          DisDataBase.insert(Dispositivos(
                              Nombre: nombreController.text,
                              Codigo: especieController.text));
                        Navigator.pushNamed(context, "/");
                      }
                    },
                    child: Text("Guardar"))
              ])),
          padding: EdgeInsets.all(15),
        )));
  }
}
