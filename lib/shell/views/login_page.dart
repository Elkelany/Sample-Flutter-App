import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kelany/core/bloc/login_bloc.dart';
import 'package:kelany/core/bloc/login_message.dart';
import 'package:kelany/shell/navigation/named_navigator_impl.dart';
import 'package:kelany/shell/repos/blogs_repo_impl.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc _bloc;

  LoginPage()
      : _bloc = LoginBloc(
            blogsRepo: BlogsRepoImpl(), namedNavigator: NamedNavigatorImpl());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginMessage>(
      initialData: LoginMessage.defaultValue(),
      stream: widget._bloc.statesStream,
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.hasError || (!snapshot.hasData)) {
          return Container();
        } else {
          return _renderStates(context, snapshot.data);
        }
      },
    );
  }

  Widget _renderStates(BuildContext context, LoginMessage message) {
    Widget currentState = Container();

    switch (message.state) {
      case LoginState.initial:
        currentState = _renderInitialState(context, message);
        break;
      case LoginState.loading:
        currentState = Stack(
          alignment: Alignment.center,
          children: [
            _renderInitialState(context, message),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        );
        break;
    }

    return currentState;
  }

  Widget _renderInitialState(BuildContext context, LoginMessage message) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
            ),
            FlatButton(
              onPressed: () => _onSubmit(message),
              child: Text("Submit"),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  void _onSubmit(LoginMessage message) {
    widget._bloc.eventsSink.add(message.copyWith(event: LoginEvent.submit));
  }
}
