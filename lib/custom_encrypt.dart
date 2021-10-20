library custom_encrypt;

import 'dart:typed_data';
import 'dart:convert' as convert;

import 'package:encrypt/encrypt.dart';

class CustomCryptor {
  final String generatedRandomKey;
  late Encrypter encrypter;

  CustomCryptor({required this.generatedRandomKey}) {
    final key = Key.fromBase64(generatedRandomKey.split(":")[0]);

    encrypter = Encrypter(
      AES(
        key,
        mode: AESMode.cbc,
        padding: "PKCS7",
      ),
    );
  }

  String decrypt({
    required String encryptedValue,
  }) {
    List<String> cipherTextIvMac = encryptedValue.split(':');

    Uint8List bytes = convert.base64.decode(cipherTextIvMac[2]);
    final encrypted = Encrypted(bytes);
    final decrypted = encrypter.decrypt(
      encrypted,
      iv: IV.fromBase64(cipherTextIvMac[0]),
    );
    return decrypted;
  }

  String encrypt({
    required String plainText,
  }) {
    final iv = IV.fromLength(16);

    final decrypted = encrypter.encrypt(
      plainText,
      iv: iv,
    );
    const mac = 'mac';
    final cipherTextIvMac = '${iv.base64}:$mac:${decrypted.base64}';
    return cipherTextIvMac;
  }
}
