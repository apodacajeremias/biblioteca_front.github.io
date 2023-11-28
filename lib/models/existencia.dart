import 'package:biblioteca_front/models/obra.dart';

class Existencia {
    final String id;
    final bool activo;
    final String nombre;
    final DateTime fechaCreacion;
    final bool disponible;
    final Obra obra;

    Existencia({
        required this.id,
        required this.fechaCreacion,
        required this.disponible,
        required this.obra,
        required this.activo,
        required this.nombre,
    });

    factory Existencia.fromJson(Map<String, dynamic> json) => Existencia(
        id: json["id"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        disponible: json["disponible"],
        obra: Obra.fromJson(json["obra"]),
        activo: json["activo"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "disponible": disponible,
        "obra": obra.toJson(),
        "activo": activo,
        "nombre": nombre,
    };
}