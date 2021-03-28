import 'package:flutter/material.dart';
import 'package:kelany/core/bloc/blog_entry_bloc.dart';
import 'package:kelany/core/bloc/blog_entry_message.dart';
import 'package:kelany/shell/repos/blogs_repo_impl.dart';
import 'package:kelany/shell/views/blog_card.dart';

class BlogEntryPage extends StatefulWidget {
  final BlogEntryBloc _bloc;

  BlogEntryPage({String blogId})
      : assert(blogId != null),
        _bloc = BlogEntryBloc(blogsRepo: BlogsRepoImpl(), blogId: blogId);

  @override
  _BlogEntryPageState createState() => _BlogEntryPageState();
}

class _BlogEntryPageState extends State<BlogEntryPage> {
  final _defaultMessage = BlogEntryMessage.defaultValue();

  @override
  void initState() {
    widget._bloc.eventsSink
        .add(_defaultMessage.copyWith(event: BlogEntryEvent.initialize));
    super.initState();
  }

  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Entry"),
        leading: BackButton(),
      ),
      body: StreamBuilder<BlogEntryMessage>(
        initialData: _defaultMessage,
        stream: widget._bloc.statesStream,
        builder: (context, snapshot) {
          if (snapshot == null || snapshot.hasError || (!snapshot.hasData)) {
            return Container();
          } else {
            return _renderStates(context, snapshot.data);
          }
        },
      ),
    );
  }

  Widget _renderStates(BuildContext context, BlogEntryMessage message) {
    Widget currentState = Container();

    switch (message.state) {
      case BlogEntryState.loading:
        currentState = Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
        break;
      case BlogEntryState.ready:
        currentState = Container(
          margin: EdgeInsets.all(20),
          child: BlogCard(blog: message.blog),
        );
        break;
    }

    return currentState;
  }
}
