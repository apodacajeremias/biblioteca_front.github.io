// To parse this JSON data, do
//
//     final contadorEntrada = contadorEntradaFromJson(jsonString);

import 'dart:convert';

ContadorEntrada contadorEntradaFromJson(String str) =>
    ContadorEntrada.fromJson(json.decode(str));

String contadorEntradaToJson(ContadorEntrada data) =>
    json.encode(data.toJson());

class ContadorEntrada {
  int diaNumero;
  String diaNombre;
  double cantidad;

  ContadorEntrada({
    required this.diaNumero,
    required this.diaNombre,
    required this.cantidad,
  });

  factory ContadorEntrada.fromJson(Map<String, dynamic> json) =>
      ContadorEntrada(
        diaNumero: json["diaNumero"],
        diaNombre: json["diaNombre"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "diaNumero": diaNumero,
        "diaNombre": diaNombre,
        "cantidad": cantidad,
      };
}
