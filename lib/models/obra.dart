class Obra {
  final String id;
  final DateTime fechaCreacion;
  final String subtitulo;
  final String autores;
  final String? empresaResponsable;
  final String? sinopsis;
  final int anho;
  final String pais;
  final String idioma;
  final String portada;
  final String area;
  final String tipo;
  final String subtipo;
  final String tipoIdentificador;
  final String identificador;
  final bool disponible;
  final int cantidad;
  final int cantidadDisponible;
  final bool fisico;
  final dynamic recurso;
  final bool activo;
  final String nombre;

  Obra({
    required this.id,
    required this.fechaCreacion,
    required this.subtitulo,
    required this.autores,
    this.empresaResponsable,
    this.sinopsis,
    required this.anho,
    required this.pais,
    required this.idioma,
    required this.portada,
    required this.area,
    required this.tipo,
    required this.subtipo,
    required this.tipoIdentificador,
    required this.identificador,
    required this.disponible,
    required this.cantidad,
    required this.cantidadDisponible,
    required this.fisico,
    required this.recurso,
    required this.activo,
    required this.nombre,
  });

  factory Obra.fromJson(Map<String, dynamic> json) => Obra(
        id: json["id"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        subtitulo: json["subtitulo"],
        autores: json["autores"],
        empresaResponsable: json["empresaResponsable"],
        sinopsis: json["sinopsis"],
        anho: json["anho"],
        pais: json["pais"],
        idioma: json["idioma"],
        portada: json["portada"],
        area: json["area"],
        tipo: json["tipo"],
        subtipo: json["subtipo"],
        tipoIdentificador: json["tipoIdentificador"],
        identificador: json["identificador"],
        disponible: json["disponible"],
        cantidad: json["cantidad"],
        cantidadDisponible: json["cantidadDisponible"],
        fisico: json["fisico"],
        recurso: json["recurso"],
        activo: json["activo"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "activo": activo,
        "nombre": nombre,
      };
}
