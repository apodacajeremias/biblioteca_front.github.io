import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? color;
  final Function onPressed;

  factory MyOutlinedButton.prestar({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'Prestar', icon: Icons.upload_file, onPressed: onPressed);

  factory MyOutlinedButton.devolver({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'Devolver', icon: Icons.task, onPressed: onPressed);

  factory MyOutlinedButton.mostrarTodo({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'Mostrar todo', onPressed: onPressed, color: Colors.yellow);

  factory MyOutlinedButton.reintentar({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'Reintentar',
          icon: Icons.refresh,
          onPressed: onPressed,
          color: Colors.yellow);

  factory MyOutlinedButton.confirmar({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'Si, confirmar', onPressed: onPressed, color: Colors.green);

  factory MyOutlinedButton.cancelar({required Function onPressed}) =>
      MyOutlinedButton(
          text: 'No, cancelar', onPressed: onPressed, color: Colors.red);

  const MyOutlinedButton(
      {super.key, this.text, this.icon, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return OutlinedButton.icon(
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
    return OutlinedButton(
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
