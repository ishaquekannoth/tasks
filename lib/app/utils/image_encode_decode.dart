import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class ImageManipulator {
  static Future<String> imageStringFromFile(File imageFile) async {
    Uint8List imagebytes = await imageFile.readAsBytes();
    return base64.encode(imagebytes);
  }

  static Future<File> imageStringToFile(String imageFile) async {
    Uint8List decodedbytes = base64.decode(imageFile);
    return File.fromRawPath(decodedbytes);
  }
}
