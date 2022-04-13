import 'dart:convert';
import 'package:crypto/crypto.dart';

String toHash(String string) {
  var data = utf8.encode(string);
  var digest = sha256.convert(data);

  return digest.toString();
}
