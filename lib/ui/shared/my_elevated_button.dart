import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;
  const MyElevatedButton(
      {super.key, required this.text, this.icon, this.onPressed});

  factory MyElevatedButton.prestar({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Prestar', icon: Icons.upload_file, onPressed: onPressed);

  factory MyElevatedButton.edit({required Function onPressed}) =>
      MyElevatedButton(text: 'Editar', icon: Icons.edit, onPressed: onPressed);

  factory MyElevatedButton.devolver({required Function onPressed}) =>
      MyElevatedButton(
          text: 'Devolver', icon: Icons.task, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
          onPressed: () {
            if (onPressed != null) onPressed!();
          },
          icon: Icon(icon),
          label: buildMouseRegionForText());
    }
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        child: buildMouseRegionForText());
  }

  buildMouseRegionForText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(text),
    );
  }
}
