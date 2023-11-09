
// ignore_for_file: avoid_print

import 'package:biblioteca_front/constants.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Function? onPressed;

  const MyTextButton({Key? key, required this.text, this.onPressed, this.color})
      : super(key: key);

  factory MyTextButton.cancel({required Function onPressed}) =>
      MyTextButton(text: 'No, cancelar', onPressed: onPressed);

  factory MyTextButton.back({required Function onPressed}) =>
      MyTextButton(text: 'Volver', onPressed: onPressed);

      

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final optionStyle = Theme.of(context).textTheme.bodyMedium!;
    return TextButton(
      autofocus: true,
      onPressed: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        } else {
          print(widget.text);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: Text(widget.text,
              style: optionStyle.apply(
                color: widget.color,
                  decoration: isHover
                      ? TextDecoration.underline
                      : TextDecoration.none)),
        ),
      ),
    );
  }
}