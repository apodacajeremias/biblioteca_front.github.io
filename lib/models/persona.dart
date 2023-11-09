import 'dart:convert';


List<Persona> personasFromJson(List str) => str.map((x) => Persona.fromJson(x)).toList();
Persona personaFromJson(String str) => json.decode(str).map((x) => Persona.fromJson(x));
class Persona {
    String? id;
    String? nombre;

    Persona({
        this.id,
        this.nombre,
    });

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
