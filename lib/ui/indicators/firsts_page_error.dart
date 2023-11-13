import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../shared/my_elevated_button.dart';

class FirstPageError extends StatelessWidget {
  final Function onReload;
  const FirstPageError({super.key, required this.onReload});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        //  Revisa tu red e inténtalo de nuevo.
        SvgPicture.asset(
          'Questions-amico.svg',
          height: defaultPadding * 15,
        ),
        Text('Estamos teniendo problemas de conexión.',
            style: theme.titleMedium),
        Text('Revisa tu red e inténtalo de nuevo.', style: theme.displaySmall),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: MyElevatedButton.reintentar(onPressed: onReload),
        ),
      ],
    );
  }
}
