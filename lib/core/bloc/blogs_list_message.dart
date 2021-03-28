import 'package:kelany/core/models/blog.dart';

enum BlogsListState { loading, ready }

enum BlogsListEvent { initialize, selectBlog }

class BlogsListMessage {
  final BlogsListState state;
  final BlogsListEvent event;
  final List<Blog> blogs;
  final int selectedBlogIndex;

  BlogsListMessage({
    BlogsListState state,
    BlogsListEvent event,
    List<Blog> blogs,
    int selectedBlogIndex,
  })  : this.state = state,
        this.event = event,
        this.blogs = blogs,
        this.selectedBlogIndex = selectedBlogIndex;

  factory BlogsListMessage.defaultValue() {
    return BlogsListMessage(
      state: BlogsListState.loading,
    );
  }

  BlogsListMessage copyWith({
    BlogsListState state,
    BlogsListEvent event,
    List<Blog> blogs,
    int selectedBlogIndex,
  }) {
    return BlogsListMessage(
      state: state ?? this.state,
      event: event ?? this.event,
      blogs: blogs ?? this.blogs,
      selectedBlogIndex: selectedBlogIndex ?? this.selectedBlogIndex,
    );
  }

  @override
  String toString() {
    return '''BlogsListMessage(
     state: $state,
     event: $event,
     blogs: $blogs,
     selectedBlogIndex: $selectedBlogIndex,
     )''';
  }
}
