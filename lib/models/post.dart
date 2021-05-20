import 'package:flutter/material.dart';
import 'owner.dart';

class Post {
  final Owner owner;
  final String id;
  final String imagePost;
  final String publishDatePost;
  final String textPost;
  final List<dynamic> tags;
  final String link;
  final int likes;

  Post({
    @required this.owner,
    @required this.id,
    @required this.imagePost,
    @required this.publishDatePost,
    @required this.textPost,
    @required this.tags,
    @required this.link,
    @required this.likes,
  });
}
