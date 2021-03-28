import 'package:flutter/material.dart';
import 'package:kelany/core/navigation/named_navigator.dart';
import 'package:kelany/shell/views/blog_entry_page.dart';
import 'package:kelany/shell/views/blogs_list_page.dart';
import 'package:kelany/shell/views/login_page.dart';

class NamedNavigatorImpl implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.BLOGS_LIST:
        return MaterialPageRoute(builder: (_) => BlogsListPage());
      case Routes.BLOG_ENTRY:
        return MaterialPageRoute(
            builder: (_) => BlogEntryPage(blogId: settings.arguments));
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  @override
  Future push(String routeName, {arguments, bool replace = false}) {
    if (replace)
      return navigatorState.currentState
          .pushReplacementNamed(routeName, arguments: arguments);

    return navigatorState.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop({dynamic result}) {
    if (navigatorState.currentState.canPop())
      navigatorState.currentState.pop(result);
  }
}
