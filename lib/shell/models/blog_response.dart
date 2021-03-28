import 'package:kelany/core/models/blog.dart';

class BlogResponse {
  String id;
  String title;
  String imageUrl;
  String createdAt;

  BlogResponse({this.id, this.createdAt, this.title, this.imageUrl});

  BlogResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }

  Blog mapToBlog() {
    return Blog(id: id, title: title, imageUrl: imageUrl, createdAt: createdAt);
  }
}
