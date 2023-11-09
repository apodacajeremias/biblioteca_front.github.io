import 'dart:convert';

import 'package:biblioteca_front_02/models/obra.dart';
import 'package:biblioteca_front_02/models/persona.dart';

List<Prestamo> prestamosFromJson(List str) =>
    str.map((x) => Prestamo.fromJson(x)).toList();
Prestamo prestamoFromJson(String str) =>
    json.decode(str).map((x) => Prestamo.fromJson(x));

class Prestamo {
  String? id;
  String? nombre;
  Obra? obra;
  Persona? persona;

  Prestamo({this.id, this.nombre, this.obra, this.persona});

  factory Prestamo.fromJson(Map<String, dynamic> json) => Prestamo(
        id: json["id"],
        nombre: json["nombre"],
        obra: Obra.fromJson(json['obra']),
        persona: Persona.fromJson(json['persona']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
