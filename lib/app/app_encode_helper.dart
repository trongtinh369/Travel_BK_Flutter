import 'dart:convert';
import 'dart:io';

class AppEncodeHelper {
  static Future<String> toBase64String(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
