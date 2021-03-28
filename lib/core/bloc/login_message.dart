enum LoginState { initial, loading }

enum LoginEvent { submit }

class LoginMessage {
  final LoginState state;
  final LoginEvent event;
  final String email;
  final String password;

  LoginMessage({
    LoginState state,
    LoginEvent event,
    String email,
    String password,
  })  : this.state = state,
        this.event = event,
        this.email = email,
        this.password = password;

  factory LoginMessage.defaultValue() {
    return LoginMessage(
      state: LoginState.initial,
    );
  }

  LoginMessage copyWith({
    LoginState state,
    LoginEvent event,
    String email,
    String password,
  }) {
    return LoginMessage(
      state: state ?? this.state,
      event: event ?? this.event,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return '''LoginMessage(
     state: $state,
     event: $event,
     email: $email,
     password: $password,
     )''';
  }
}
