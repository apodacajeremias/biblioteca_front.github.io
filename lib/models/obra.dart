import 'dart:convert';
import 'package:biblioteca_front/models/enums/area.dart';
import 'package:biblioteca_front/models/enums/tipo_obra.dart';
List<Obra> obrasFromJson(List str) => str.map((x) => Obra.fromJson(x)).toList();
Obra obraFromJson(String str) => json.decode(str).map((x) => Obra.fromJson(x));
class Obra {
    String? id;
    DateTime? fechaCreacion;
    DateTime? fechaModificacion;
    String? subtitulo;
    String? sinopsis;
    String? autor;
    String? editorial;
    String? isbn;
    String? doi;
    String? anhoPublicacion;
    String? idioma;
    String? pais;
    String? portada;
    bool? fisico;
    TipoObra? tipo;
    Area? area;
    bool? activo;
    String? nombre;

    Obra({
        this.id,
        this.fechaCreacion,
        this.fechaModificacion,
        this.subtitulo,
        this.sinopsis,
        this.autor,
        this.editorial,
        this.isbn,
        this.doi,
        this.anhoPublicacion,
        this.idioma,
        this.pais,
        this.portada,
        this.fisico,
        this.tipo,
        this.area,
        this.activo,
        this.nombre,
    });

    factory Obra.fromJson(Map<String, dynamic> json) => Obra(
        id: json["id"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]!),
        fechaModificacion: json["fechaModificacion"] == null ? null : DateTime.parse(json["fechaModificacion"]!),
        subtitulo: json["subtitulo"],
        sinopsis: json["sinopsis"],
        autor: json["autor"],
        editorial: json["editorial"],
        isbn: json["isbn"],
        doi: json["doi"],
        anhoPublicacion: json["anhoPublicacion"],
        idioma: json["idioma"],
        pais: json["pais"],
        portada: json["portada"],
        fisico: json["fisico"] == null ? null : (json["fisico"]!),
        tipo: json["tipo"] == null ? null : TipoObra.values.byName(json["tipo"]!),
        area: json["area"] == null ? null : Area.values.byName(json["area"]!),
        activo: json["activo"] == null ? null : (json["activo"]!),
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "subtitulo": subtitulo,
        "sinopsis": sinopsis,
        "autor": autor,
        "editorial": editorial,
        "isbn": isbn,
        "doi": doi,
        "anhoPublicacion": anhoPublicacion,
        "idioma": idioma,
        "pais": pais,
        "portada": portada,
        "fisico": fisico,
        "tipo": tipo,
        "area": area,
        "activo": activo,
        "nombre": nombre,
    };
}
