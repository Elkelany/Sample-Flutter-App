import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kelany/core/models/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog _blog;

  const BlogCard({Blog blog}) : _blog = blog;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          child: CachedNetworkImage(
            imageUrl: _blog.imageUrl,
            progressIndicatorBuilder: (_, __, ___) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            _blog.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          child: Text(_blog.createdAt,
              style: Theme.of(context).textTheme.subtitle2),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
