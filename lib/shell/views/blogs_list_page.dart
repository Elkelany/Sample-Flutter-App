import 'package:flutter/material.dart';
import 'package:kelany/core/bloc/blogs_list_bloc.dart';
import 'package:kelany/core/bloc/blogs_list_message.dart';
import 'package:kelany/shell/navigation/named_navigator_impl.dart';
import 'package:kelany/shell/repos/blogs_repo_impl.dart';
import 'package:kelany/shell/views/blog_card.dart';

class BlogsListPage extends StatefulWidget {
  final BlogsListBloc _bloc;

  BlogsListPage()
      : _bloc = BlogsListBloc(
            blogsRepo: BlogsRepoImpl(), namedNavigator: NamedNavigatorImpl());

  @override
  _BlogsListPageState createState() => _BlogsListPageState();
}

class _BlogsListPageState extends State<BlogsListPage> {
  final _defaultMessage = BlogsListMessage.defaultValue();

  @override
  void initState() {
    widget._bloc.eventsSink
        .add(_defaultMessage.copyWith(event: BlogsListEvent.initialize));
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
        title: Text("Blogs List"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<BlogsListMessage>(
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

  Widget _renderStates(BuildContext context, BlogsListMessage message) {
    Widget currentState = Container();

    switch (message.state) {
      case BlogsListState.loading:
        currentState = Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
        break;
      case BlogsListState.ready:
        currentState = _renderReadyState(context, message);
        break;
    }

    return currentState;
  }

  Widget _renderReadyState(BuildContext context, BlogsListMessage message) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onSelectBlog(message, index),
            child: BlogCard(blog: message.blogs[index]),
          );
        },
        itemCount: message.blogs.length,
      ),
    );
  }

  void _onSelectBlog(BlogsListMessage message, int index) {
    widget._bloc.eventsSink.add(message.copyWith(
        event: BlogsListEvent.selectBlog, selectedBlogIndex: index));
  }
}
