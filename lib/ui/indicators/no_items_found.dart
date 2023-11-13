import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/search_provider.dart';

class NoItemsFound extends StatelessWidget {
  final Function onReload;
  const NoItemsFound({super.key, required this.onReload});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgPicture.asset(
          'Empty-amico.svg',
          height: defaultPadding * 15,
        ),
        Text('No se encontraron resultados.', style: theme.titleMedium),
        Text('Revisa tus filtros de búsqueda y vuelve a intentarlo.',
            style: theme.displaySmall),
        Text.rich(
          TextSpan(
            text: provider.query.isNotEmpty
                ? 'Sin coincidencias para '
                : 'Sin coincidencias.',
            style: theme.displaySmall!,
            children: [
              TextSpan(
                  text: provider.query,
                  style:
                      theme.displaySmall!.copyWith(fontStyle: FontStyle.italic))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: MyElevatedButton.mostrarTodo(onPressed: onReload),
        ),
      ],
    );
  }
}
