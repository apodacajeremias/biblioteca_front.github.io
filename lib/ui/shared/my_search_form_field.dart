import 'dart:async';

import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:biblioteca_front/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/media_query_values.dart';

class MySearchFormField extends StatefulWidget {
  const MySearchFormField({
    super.key
  });

  @override
  State<MySearchFormField> createState() => _MySearchFormFieldState();
}

class _MySearchFormFieldState extends State<MySearchFormField> {
  bool blink = false;
  bool inFocus = false;
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (inFocus) {
        setState(() {
          blink = !blink;
        });
    
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final Function(String) onChanged = Provider.of<SearchProvider>(context).onChanged;
    return Focus(
      onFocusChange: (value) {
        setState(() {
          inFocus = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: inFocus ? context.width * 0.8 : context.width * 0.2,
        height: inFocus ? context.height * 0.06 : context.height * 0.05,
        curve: Curves.fastOutSlowIn,
        child: TextField(
            onSubmitted: (value) {
              Provider.of<SearchProvider>(context, listen: false).query =
                  value.trimAll();
            },
            onChanged: (value) {
              if (validateSearch(value)) {
                Provider.of<SearchProvider>(context, listen: false).query =
                    value.trimAll();
              }
            },
            decoration: InputDecoration(
              prefixIcon: _buildPrefixIcon(primary),
              suffixIcon: inFocus ? _buildSuffixIcon(primary) : null,
              fillColor: primary.withOpacity(0.1),
              filled: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: blink ? primary.withOpacity(0.5) : primary,
                    width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Buscar',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: const OutlineInputBorder(),
            )),
      ),
    );
  }

  Widget _buildSuffixIcon(Color primary) {
    return Icon(Icons.keyboard_return,
        color: blink ? primary.withOpacity(0.5) : primary);
  }

  Widget _buildPrefixIcon(Color primary) {
    return Icon(Icons.search,
        color: blink ? primary.withOpacity(0.5) : primary);
  }

  bool validateSearch(String value) {
    if (value.length % 4 == 0) {
      return true;
    }
    if (value.endsWith(' ')) {
      return true;
    }
    return false;
  }
}
