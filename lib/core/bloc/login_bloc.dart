import 'package:kelany/core/bloc/base_bloc.dart';
import 'package:kelany/core/bloc/login_message.dart';
import 'package:kelany/core/navigation/named_navigator.dart';
import 'package:kelany/core/repos/blogs_repo.dart';
import 'package:meta/meta.dart';

class LoginBloc extends BaseBloc<LoginMessage> {
  final BlogsRepo _blogsRepo;
  final NamedNavigator _namedNavigator;

  LoginBloc({
    @required BlogsRepo blogsRepo,
    @required NamedNavigator namedNavigator,
  })  : this._blogsRepo = blogsRepo,
        this._namedNavigator = namedNavigator;

  @override
  void eventHandler(LoginMessage message) {
    switch (message.event) {
      case LoginEvent.submit:
        _submit(message);
        break;
    }
  }

  // Events
  void _submit(LoginMessage message) async {
    statesSink.add(message.copyWith(state: LoginState.loading));

    try {
      await _blogsRepo.login();

      _namedNavigator.push(Routes.BLOGS_LIST, replace: true);
    } catch (error) {
      print(error);
      statesSink.add(message.copyWith(state: LoginState.initial));
    }
  }
}
