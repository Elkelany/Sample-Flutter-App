import 'package:kelany/core/bloc/base_bloc.dart';
import 'package:kelany/core/bloc/blogs_list_message.dart';
import 'package:kelany/core/models/blog.dart';
import 'package:kelany/core/navigation/named_navigator.dart';
import 'package:kelany/core/repos/blogs_repo.dart';
import 'package:meta/meta.dart';

class BlogsListBloc extends BaseBloc<BlogsListMessage> {
  final BlogsRepo _blogsRepo;
  final NamedNavigator _namedNavigator;

  BlogsListBloc({
    @required BlogsRepo blogsRepo,
    @required NamedNavigator namedNavigator,
  })  : this._blogsRepo = blogsRepo,
        this._namedNavigator = namedNavigator;

  @override
  void eventHandler(BlogsListMessage message) {
    switch (message.event) {
      case BlogsListEvent.initialize:
        _initialize(message);
        break;
      case BlogsListEvent.selectBlog:
        _selectBlog(message);
        break;
    }
  }

  // Events
  void _initialize(BlogsListMessage message) async {
    statesSink.add(message.copyWith(state: BlogsListState.loading));

    try {
      List<Blog> blogs = await _blogsRepo.fetchBlogsList();

      statesSink
          .add(message.copyWith(state: BlogsListState.ready, blogs: blogs));
    } catch (error) {
      print(error);
      statesSink.add(message.copyWith(state: BlogsListState.loading));
    }
  }

  void _selectBlog(BlogsListMessage message) {
    String selectedBlogId = message.blogs[message.selectedBlogIndex].id;

    _namedNavigator.push(Routes.BLOG_ENTRY, arguments: selectedBlogId);
  }
}
