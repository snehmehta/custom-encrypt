import 'package:flutter_test/flutter_test.dart';

import 'package:custom_encrypt/custom_encrypt.dart';

void main() {
  const generatedRandomKey =
      'ZANDO0PEOD3QWXiy+vZapA==:w2P0yIrohvgwPKmV47xLIPUi7gu9EgZmY7jaYdD56X0=';
  test('Decryption test', () {
    const expectedValue = '3fa154dc-eac6-4f12-b76b-c519e7560e16';

    const encryptedValue =
        'ZVdohUTTMraXB+NiYaky+Q==:m1x/m9EbIbtD5J8ZxKM8elgF/5kGMpD2VCw9Bqm331w=:EBjAZMn8anRkg4Mir1tg16X+wi2UEMPIi85B+ULKONmsy1KUHYh11mh/bSd1z4rt';

    final _crypt = CustomCryptor(generatedRandomKey: generatedRandomKey);

    final encrypted = _crypt.decrypt(
      encryptedValue: encryptedValue,
    );

    expect(expectedValue, encrypted);
  });

  test('Complete test', () {
    const expectedValue = '3fa154dc-eac6-4f12-b76b-c519e7560e16';

    final _crypt = CustomCryptor(generatedRandomKey: generatedRandomKey);

    final encrypted = _crypt.encrypt(
      plainText: expectedValue,
    );

    final decrypt = _crypt.decrypt(
      encryptedValue: encrypted,
    );

    expect(expectedValue, decrypt);
  });
}
