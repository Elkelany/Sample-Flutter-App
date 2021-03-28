import 'package:kelany/core/models/blog.dart';

enum BlogEntryState { loading, ready }

enum BlogEntryEvent { initialize }

class BlogEntryMessage {
  final BlogEntryState state;
  final BlogEntryEvent event;
  final Blog blog;

  BlogEntryMessage({
    BlogEntryState state,
    BlogEntryEvent event,
    Blog blog,
  })  : this.state = state,
        this.event = event,
        this.blog = blog;

  factory BlogEntryMessage.defaultValue() {
    return BlogEntryMessage(
      state: BlogEntryState.loading,
    );
  }

  BlogEntryMessage copyWith({
    BlogEntryState state,
    BlogEntryEvent event,
    Blog blog,
    int selectedBlogIndex,
  }) {
    return BlogEntryMessage(
      state: state ?? this.state,
      event: event ?? this.event,
      blog: blog ?? this.blog,
    );
  }

  @override
  String toString() {
    return '''BlogEntryMessage(
     state: $state,
     event: $event,
     blogs: $blog,
     )''';
  }
}
