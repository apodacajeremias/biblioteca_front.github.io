import 'package:biblioteca_front_02/constants.dart';
import 'package:biblioteca_front_02/ui/shared/my_list_obra.dart';
import 'package:flutter/material.dart';

class ObraView extends StatelessWidget {
  final String titulo;
  final Function(String) onSearch;
  final Future Function() onFutureLoad;

  const ObraView(
      {super.key,
      required this.titulo,
      required this.onSearch,
      required this.onFutureLoad});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child:
                  Text(titulo, style: Theme.of(context).textTheme.titleLarge),
            ),
            FutureBuilder(
              future: onFutureLoad(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                      child:
                          Center(child: CircularProgressIndicator.adaptive()));
                }
                if (snapshot.hasData) {
                  return Expanded(
                      child: MyListObra(obraPaging: snapshot.data!));
                } else {
                  return Expanded(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.square(
                          dimension: 128,
                          child: Icon(Icons.error,
                              color: Colors.grey.shade400, size: 64)),
                      Text('No se ha encontrado registros.',
                          style: Theme.of(context).textTheme.displaySmall)
                    ],
                  )));
                }
              },
            ),
            const SizedBox(height: defaultPadding),
          ],
        ));
  }
}
