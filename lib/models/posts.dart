import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:posts_task/models/owner.dart';
import 'package:http/http.dart' as http;
import 'package:posts_task/models/post.dart';

class Posts with ChangeNotifier {
  List<Post> postsList = [];
  Owner owner;
  String id;
  String textPost;
  String imagePost;
  String publishDatePost;
  String link;
  int likes;
  List<dynamic> listTages;

  final app_id = '60a373f57c13e7f5a901a999';

// Request get all posts
  Future<void> fetchData() async {
    var url = Uri.https(
      'dummyapi.io',
      '/data/api/post',
    );
    try {
      final http.Response res =
          await http.get(url, headers: {'app-id': app_id});
      final extractedData = json.decode(res.body);

      final postes = extractedData['data'].map((post) {
        _validateData(post);
        return Post(
            owner: owner,
            id: id,
            imagePost: imagePost,
            publishDatePost: publishDatePost,
            textPost: textPost,
            tags: listTages,
            link: link,
            likes: likes);
      }).toList();
      print(extractedData);

      for (int index = 0; index < postes.length; index++) {
        postsList.add(Post(
          owner: postes[index].owner,
          id: postes[index].id,
          imagePost: postes[index].imagePost,
          publishDatePost: postes[index].publishDatePost,
          textPost: postes[index].textPost,
          tags: postes[index].tags,
          link: postes[index].link,
          likes: postes[index].likes,
        ));
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

// Requset get determnet post ues id post
  Future<Post> fetchSelctedPost(String id) async {
    var url = Uri.https(
      'dummyapi.io',
      '/data/api/post/$id',
    );

    try {
      final http.Response res =
          await http.get(url, headers: {'app-id': app_id});
      final extractedData = json.decode(res.body);
      print(extractedData);
      final post = extractedData;

      _validateData(post);

      return Post(
        owner: owner,
        id: id,
        imagePost: imagePost,
        publishDatePost: publishDatePost,
        textPost: textPost,
        tags: listTages,
        link: link,
        likes: likes,
      );
    } catch (e) {
      throw e;
    }
  }

  void _validateData(post) {
    owner = post['owner'] != null
        ? Owner(
            email: post['owner']['email'],
            id: post['owner']['id'],
            picture: post['owner']['picture'],
            title: post['owner']['title'],
            firstName: post['owner']['firstName'],
            lastName: post['owner']['lastName'])
        : Owner(
            email: '',
            id: '',
            picture: '',
            title: '',
            firstName: '',
            lastName: '');
    id = post['id'] != null ? post['id'] : '';
    textPost = post['text'] != null ? post['text'] : '';
    imagePost = post['image'] != null ? post['image'] : '';
    publishDatePost = post['publishDate'] != null ? post['publishDate'] : '';
    link = post['link'] != null ? post['link'] : '';
    likes = post['likes'] != null ? post['likes'] as int : 0;
    listTages = post['tags'] as List<dynamic>;
  }
}
