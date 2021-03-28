import 'package:kelany/core/externals/secure_storage.dart';
import 'package:kelany/core/repos/authorization_repo.dart';
import 'package:kelany/shell/externals/secure_storage_impl.dart';

class AuthorizationRepoImpl implements AuthorizationRepo {
  SecureStorage _secureStorage;

  AuthorizationRepoImpl({
    SecureStorage secureStorage,
  }) : this._secureStorage = secureStorage ?? SecureStorageImpl();

  @override
  Future saveAuthToken(String authToken) async {
    return await _secureStorage.write(
        key: SecureStorageKey.authToken, value: authToken);
  }

  @override
  Future<String> getAuthToken() {
    return _secureStorage
        .read(key: SecureStorageKey.authToken)
        .then((authToken) {
      return Future.value(authToken ?? "");
    }).catchError((error) {
      return Future.value("");
    });
  }
}
