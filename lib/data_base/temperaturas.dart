class Dispositivos {
  int? id;
  String? Nombre;
  String? Codigo;
  String? Email;

  Dispositivos({this.id, this.Nombre, this.Codigo, this.Email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': Nombre, 'codigo': Codigo, 'email':Email};
  }
}
