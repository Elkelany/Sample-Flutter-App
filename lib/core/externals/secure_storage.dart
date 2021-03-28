abstract class SecureStorage {
  Future write({SecureStorageKey key, String value});

  Future<String> read({SecureStorageKey key});
}

enum SecureStorageKey { authToken }

extension SecureStorageKeyExtension on SecureStorageKey {
  String get value => this.toString().split(".").last;
}
