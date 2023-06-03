import 'package:asm/config.dart';
import 'package:encrypt/encrypt.dart';

void main() {
  print('my 32 length key................'.length);
  print(encryptAES("Hello"));
}

encryptAES(String plainText) {
  final SecConfig config = SecConfig();
  String encrypted;
  final key = Key.fromUtf8('3t6w9z\$C&F)J@NcRfUjXnZr4u7x!A%D*');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  encrypted = encrypter.encrypt(plainText, iv: iv).base64;
  return encrypted;
}

decryptAES(String encrypted) {
  String decrypted;
  final SecConfig config = SecConfig();
  final key = Key.fromUtf8('injnuygtllijgf=ptqaxdsrvgtybvdts');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
  print(decrypted);
}
