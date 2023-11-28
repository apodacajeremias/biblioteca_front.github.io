class Persona {
    final String id;
    final bool activo;
    final String nombre;
    final DateTime fechaCreacion;
    final String documentoIdentidad;

    Persona({
        required this.id,
        required this.activo,
        required this.nombre,
        required this.fechaCreacion,
        required this.documentoIdentidad,
    });

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        documentoIdentidad: json["documentoIdentidad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "documentoIdentidad": documentoIdentidad,
    };
}
