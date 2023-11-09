// ignore_for_file: constant_identifier_names

enum TipoObra{
  LIBRO, REVISTA, ARTICULO_REVISTA, TESIS, PAGINA_WEB, INFORME, REPORTE, OTRO;

  @override
  String toString() => name;
}