import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kelany/core/externals/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  FlutterSecureStorage _flutterSecureStorage;

  SecureStorageImpl() : _flutterSecureStorage = FlutterSecureStorage();

  @override
  Future write({SecureStorageKey key, String value}) {
    return _flutterSecureStorage.write(key: key.value, value: value);
  }

  @override
  Future<String> read({SecureStorageKey key}) {
    return _flutterSecureStorage.read(key: key.value);
  }
}
