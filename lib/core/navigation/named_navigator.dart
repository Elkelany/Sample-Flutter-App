abstract class NamedNavigator {
  Future push(String routeName, {dynamic arguments, bool replace = false});

  void pop({dynamic result});
}

class Routes {
  static const LOGIN = "LOGIN_ROUTER";
  static const BLOGS_LIST = "BLOGS_LIST_ROUTER";
  static const BLOG_ENTRY = "BLOG_ENTRY_ROUTER";
}
