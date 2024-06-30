// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareManager {
  Future<void> sharePDF(String name) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/resultados_$name.pdf';
    final file = File(path);

    if (await file.exists()) {
      Share.shareFiles([path], text: 'Resultados para $name.pdf');
    } else {
      print('O arquivo PDF não foi encontrado.');
    }
  }
}
