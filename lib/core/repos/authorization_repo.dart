abstract class AuthorizationRepo {
  Future saveAuthToken(String authToken);

  Future<String> getAuthToken();
}
