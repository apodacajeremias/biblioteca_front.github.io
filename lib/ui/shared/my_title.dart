import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTitle extends StatelessWidget {
  final String title;
  const MyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (provider.query.isNotEmpty) ...[
              const SizedBox(height: defaultPadding / 2),
              Text('Buscando "${provider.query}"',
                  style: Theme.of(context).textTheme.displaySmall),
            ],
            const SizedBox(height: defaultPadding / 2),
          ],
        ));
  }
}
