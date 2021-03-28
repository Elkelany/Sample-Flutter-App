import 'package:kelany/core/bloc/base_bloc.dart';
import 'package:kelany/core/bloc/blog_entry_message.dart';
import 'package:kelany/core/models/blog.dart';
import 'package:kelany/core/repos/blogs_repo.dart';
import 'package:meta/meta.dart';

class BlogEntryBloc extends BaseBloc<BlogEntryMessage> {
  final BlogsRepo _blogsRepo;
  final String _blogId;

  BlogEntryBloc({
    @required BlogsRepo blogsRepo,
    @required String blogId,
  })  : this._blogsRepo = blogsRepo,
        this._blogId = blogId;

  @override
  void eventHandler(BlogEntryMessage message) {
    switch (message.event) {
      case BlogEntryEvent.initialize:
        _initialize(message);
        break;
    }
  }

  // Events
  void _initialize(BlogEntryMessage message) async {
    statesSink.add(message.copyWith(state: BlogEntryState.loading));

    try {
      Blog blog = await _blogsRepo.fetchSingleBlog(blogId: _blogId);

      statesSink.add(message.copyWith(state: BlogEntryState.ready, blog: blog));
    } catch (error) {
      print(error);
      statesSink.add(message.copyWith(state: BlogEntryState.loading));
    }
  }
}
