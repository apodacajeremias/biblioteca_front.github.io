
import 'package:biblioteca_front/models/pages/paging.dart';

import '../obra.dart';

class ObraPaging{
  final Paging paging;
  final List<Obra> content;

  ObraPaging({required this.paging, required this.content});
}