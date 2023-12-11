import 'package:biblioteca_front/app_colors.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? color;
  final Function onPressed;

  factory MyElevatedButton.prestar({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Prestar', icon: Icons.upload_file, onPressed: onPressed);

  factory MyElevatedButton.devolver({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Devolver', icon: Icons.task, onPressed: onPressed);

  factory MyElevatedButton.enviar({required Function onPressed}) =>
      MyElevatedButton(text: 'Enviar', icon: Icons.send, onPressed: onPressed);

  ///

  factory MyElevatedButton.mostrarTodo({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Mostrar todo',
          onPressed: onPressed,
          color: AppColors.contentColorYellow);

  factory MyElevatedButton.reintentar({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Reintentar',
          icon: Icons.refresh,
          onPressed: onPressed,
          color: AppColors.contentColorYellow);

  ///

  factory MyElevatedButton.confirmar({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Si, confirmar',
          onPressed: onPressed,
          color: AppColors.contentColorGreen);

  factory MyElevatedButton.cancelar({required Function onPressed}) =>
      MyElevatedButton(
          text: 'No, cancelar',
          onPressed: onPressed,
          color: AppColors.contentColorRed);

  ///

  factory MyElevatedButton.entrar({required Function onPressed}) =>
      MyElevatedButton(text: 'Marcar entrada', onPressed: onPressed);

  factory MyElevatedButton.salir({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Marcar salida',
          onPressed: onPressed,
          color: AppColors.contentColorRed);

  const MyElevatedButton(
      {super.key, this.text, this.icon, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
          style: color != null
              ? ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(color!))
              : null,
          onPressed: () {
            onPressed();
          },
          icon: Icon(icon),
          label: buildMouseRegionForText());
    }
    return ElevatedButton(
        style: color != null
            ? ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(color!))
            : null,
        onPressed: () {
          onPressed();
        },
        child: buildMouseRegionForText());
  }

  buildMouseRegionForText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(text ?? '....'),
    );
  }
}
