import 'package:flutter/material.dart';
import '../../utils/media_query_values.dart';

class MySearchFormField extends StatefulWidget {
  const MySearchFormField({
    super.key,
  });

  @override
  State<MySearchFormField> createState() => _MySearchFormFieldState();
}

class _MySearchFormFieldState extends State<MySearchFormField> {
  bool inFocus = false;
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Focus(
      onFocusChange: (value) {
        setState(() {
          inFocus = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: inFocus ? context.width * 0.8 : context.width * 0.2,
        height: context.height * 0.05,
        
          curve: Curves.fastOutSlowIn,
        child: TextField(
            decoration: InputDecoration(
          fillColor: primary.withOpacity(0.4),
          filled: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Buscar',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: const OutlineInputBorder(),
        )),
      ),
    );
  }
}
