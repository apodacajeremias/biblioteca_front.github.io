import 'package:biblioteca_front/models/existencia.dart';
import 'package:biblioteca_front/models/persona.dart';

class Prestamo {
    final String id;
    final DateTime fechaCreacion;
    final Existencia existencia;
    final Persona persona;
    final dynamic fechaHoraDevolucion;
    final bool activo;
    final String nombre;

    Prestamo({
        required this.id,
        required this.fechaCreacion,
        required this.existencia,
        required this.persona,
        required this.fechaHoraDevolucion,
        required this.activo,
        required this.nombre,
    });

    factory Prestamo.fromJson(Map<String, dynamic> json) => Prestamo(
        id: json["id"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        existencia: Existencia.fromJson(json["existencia"]),
        persona: Persona.fromJson(json["persona"]),
        fechaHoraDevolucion: json["fechaHoraDevolucion"],
        activo: json["activo"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "existencia": existencia.toJson(),
        "persona": persona.toJson(),
        "fechaHoraDevolucion": fechaHoraDevolucion,
        "activo": activo,
        "nombre": nombre,
    };
}



