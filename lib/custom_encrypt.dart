library custom_encrypt;

import 'dart:typed_data';
import 'dart:convert' as convert;

import 'package:encrypt/encrypt.dart';

class CustomCryptor {
  final String generatedRandomKey;

  CustomCryptor({required this.generatedRandomKey});

  String decrypt({
    required String encryptedValue,
  }) {
    final key = Key.fromBase64(generatedRandomKey.split(":")[0]);

    final encrypter = Encrypter(
      AES(
        key,
        mode: AESMode.cbc,
        padding: "PKCS7",
      ),
    );

    List<String> cipherTextIvMac = encryptedValue.split(':');

    Uint8List bytes = convert.base64.decode(cipherTextIvMac[2]);
    final encrypted = Encrypted(bytes);
    final decrypted = encrypter.decrypt(
      encrypted,
      iv: IV.fromBase64(cipherTextIvMac[0]),
    );
    return decrypted;
  }
}
