import 'package:biblioteca_front/models/existencia.dart';
import 'package:biblioteca_front/models/persona.dart';

class Prestamo {
    final String id;
    final bool activo;
    final String nombre;
    final DateTime fechaCreacion;
    final Existencia existencia;
    final Persona persona;
    final DateTime? fechaHoraDevolucion;

    Prestamo({
        required this.id,
        required this.activo,
        required this.nombre,
        required this.fechaCreacion,
        required this.existencia,
        required this.persona,
        required this.fechaHoraDevolucion,
    });

    factory Prestamo.fromJson(Map<String, dynamic> json) => Prestamo(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        existencia: Existencia.fromJson(json["existencia"]),
        persona: Persona.fromJson(json["persona"]),
        fechaHoraDevolucion: DateTime.parse(json["fechaHoraDevolucion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "existencia": existencia.toJson(),
        "persona": persona.toJson(),
        "fechaHoraDevolucion": fechaHoraDevolucion?.toIso8601String(),
    };
}



