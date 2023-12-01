import 'persona.dart';

class Entrada {
    final String id;
    final bool activo;
    final String nombre;
    final DateTime fechaCreacion;
    final Persona persona;
    final String? motivo;
    final DateTime? fechaHoraSalida;

    Entrada({
        required this.id,
        required this.activo,
        required this.nombre,
        required this.fechaCreacion,
         required this.persona,
         this.motivo,
         this.fechaHoraSalida,
    });

    factory Entrada.fromJson(Map<String, dynamic> json) => Entrada(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        persona: Persona.fromJson(json['persona']),
        motivo: json['motivo'],
        fechaHoraSalida: json.containsKey('fechaHoraSalida') && json['fechaHoraSalida'] != null ? DateTime.tryParse(json['fechaHoraSalida']) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaHoraSalida": fechaHoraSalida?.toIso8601String(),
    };
}
