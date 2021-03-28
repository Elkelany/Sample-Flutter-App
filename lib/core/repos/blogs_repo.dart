import 'package:kelany/core/models/blog.dart';

abstract class BlogsRepo {
  Future login();

  Future<List<Blog>> fetchBlogsList();

  Future<Blog> fetchSingleBlog({String blogId});
}
