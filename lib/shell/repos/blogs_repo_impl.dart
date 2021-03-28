import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kelany/core/constants.dart';
import 'package:kelany/core/models/blog.dart';
import 'package:kelany/core/repos/authorization_repo.dart';
import 'package:kelany/core/repos/blogs_repo.dart';
import 'package:kelany/shell/models/blog_response.dart';
import 'package:kelany/shell/repos/authorization_repo_impl.dart';

class BlogsRepoImpl implements BlogsRepo {
  final AuthorizationRepo _authorizationRepo;

  BlogsRepoImpl({AuthorizationRepo authorizationRepo})
      : _authorizationRepo = authorizationRepo ?? AuthorizationRepoImpl();

  @override
  Future login() async {
    final response = await http.post(LOGIN_URL);

    Map<String, dynamic> jsonData = json.decode(response.body);

    String authToken = jsonData["token"];

    await _authorizationRepo.saveAuthToken(authToken);
  }

  @override
  Future<List<Blog>> fetchBlogsList() async {
    String authToken = await _authorizationRepo.getAuthToken();

    final response = await http.get(BLOGS_LIST_URL, headers: {
      "Authorization": "Bearer " + "$authToken",
    });

    List<dynamic> jsonData = json.decode(response.body);

    List<BlogResponse> blogsResponse = [];

    jsonData.forEach((element) {
      blogsResponse.add(BlogResponse.fromJson(element));
    });

    List<Blog> blogs = blogsResponse.map((value) => value.mapToBlog()).toList();

    return blogs;
  }

  @override
  Future<Blog> fetchSingleBlog({String blogId}) async {
    String authToken = await _authorizationRepo.getAuthToken();

    final response =
        await http.get(SINGLE_BLOG_URL.replaceFirst("{id}", blogId), headers: {
      "Authorization": "Bearer " + "$authToken",
    });

    Map<String, dynamic> jsonData = json.decode(response.body);

    BlogResponse blogResponse = BlogResponse.fromJson(jsonData);

    Blog blog = blogResponse.mapToBlog();

    return blog;
  }
}
