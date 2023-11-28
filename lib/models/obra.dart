import 'enums/area.dart';
import 'enums/subtipo_obra.dart';
import 'enums/tipo_identificador.dart';
import 'enums/tipo_obra.dart';

class Obra {
  final String id;
  final bool activo;
  final String nombre;
  final DateTime fechaCreacion;
  final String? subtitulo;
  final String? autores;
  final String? empresaResponsable;
  final String? sinopsis;
  final int anho;
  final String? pais;
  final String? idioma;
  final String? portada;
  final Area area;
  final TipoObra tipo;
  final SubtipoObra? subtipo;
  final TipoIdentificador? tipoIdentificador;
  final String? identificador;
  final bool disponible;
  final int cantidad;
  final int cantidadDisponible;
  final bool fisico;
  final String? recurso;

  Obra({
    required this.id,
    required this.activo,
    required this.nombre,
    required this.fechaCreacion,
    this.subtitulo,
    this.autores,
    this.empresaResponsable,
    this.sinopsis,
    required this.anho,
    this.pais,
    this.idioma,
    this.portada,
    required this.area,
    required this.tipo,
    this.subtipo,
    this.tipoIdentificador,
    this.identificador,
    required this.disponible,
    required this.cantidad,
    required this.cantidadDisponible,
    required this.fisico,
    this.recurso,
  });

  factory Obra.fromJson(Map<String, dynamic> json) => Obra(
        id: json["id"],
        activo: json["activo"],
        nombre: json["nombre"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        subtitulo: json["subtitulo"],
        autores: json["autores"],
        empresaResponsable: json["empresaResponsable"],
        sinopsis: json["sinopsis"],
        anho: json["anho"],
        pais: json["pais"],
        idioma: json["idioma"],
        portada: json["portada"],
        area: Area.values.byName(json["area"]),
        tipo: TipoObra.values.byName(json["tipo"]),
        subtipo: SubtipoObra.values.byName(json["subtipo"]),
        tipoIdentificador:
            TipoIdentificador.values.byName(json["tipoIdentificador"]),
        identificador: json["identificador"],
        disponible: json["disponible"],
        cantidad: json["cantidad"],
        cantidadDisponible: json["cantidadDisponible"],
        fisico: json["fisico"],
        recurso: json["recurso"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "nombre": nombre,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "subtitulo": subtitulo,
        "autores": autores,
        "empresaResponsable": empresaResponsable,
        "sinopsis": sinopsis,
        "anho": anho,
        "pais": pais,
        "idioma": idioma,
        "portada": portada,
        "area": area,
        "tipo": tipo,
        "subtipo": subtipo,
        "tipoIdentificador": tipoIdentificador,
        "identificador": identificador,
        "disponible": disponible,
        "cantidad": cantidad,
        "cantidadDisponible": cantidadDisponible,
        "fisico": fisico,
        "recurso": recurso,
      };
}
