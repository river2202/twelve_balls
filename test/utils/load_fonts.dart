import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> loadFonts() async {
  await loadAppFonts();

  //https://github.com/flutter/flutter/issues/20907
  if (Directory.current.path.endsWith('/test')) {
    Directory.current = Directory.current.parent;
  }

  loadCustomFont(String name, String fontPath) async {
    final customFont = File(fontPath)
        .readAsBytes()
        .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
    final customFontLoader = FontLoader(name)..addFont(customFont);
    await customFontLoader.load();
  }

  await loadCustomFont('TradeGothicLTStd', 'fonts/TradeGothicLTStd.otf');
  await loadCustomFont(
      'TradeGothicLTStd-Bold', 'fonts/TradeGothicLTStd-Bold.otf');
  await loadCustomFont('DS-DIGI', 'fonts/DS-DIGI.TTF');
}
