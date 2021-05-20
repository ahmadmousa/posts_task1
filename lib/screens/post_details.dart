import 'package:flutter/material.dart';
import 'package:posts_task/widget/post_details_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posts_task/widget/details_owner.dart';

import '../models/posts.dart';
import '../models/owner.dart';

class PostsDetails extends StatefulWidget {
  final String id;

  PostsDetails(this.id);

  @override
  _PostsDetailsState createState() => _PostsDetailsState();
}

class _PostsDetailsState extends State<PostsDetails> {
  //final String id;
  bool _isLoading = true;
  bool _isAsRead = false;

  Owner owner;
  String id;
  String imagePost;
  String publishDatePost;
  String textPost;
  List<dynamic> tags;
  String link;
  int likes;

  void checkId() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getBool(widget.id)) {
      _isAsRead = true;
    } else {
      pref.setBool(widget.id, false);
    }
  }

  // _PostsDetailsState(this.id);
  @override
  void initState() {
    // checkId();
    Provider.of<Posts>(context, listen: false)
        .fetchSelctedPost(widget.id)
        .then((value) {
      owner = value.owner;
      id = value.id;
      imagePost = value.imagePost;
      publishDatePost = value.publishDatePost;
      textPost = value.textPost;
      tags = value.tags;
      link = value.link;
      likes = value.likes;
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) => print(onError));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        //  var pref = await SharedPreferences.getInstance();
                        setState(() {
                          _isAsRead = !_isAsRead;
                        });
                      },
                      child: Text(
                        "Mark as Read",
                        style: TextStyle(
                            color: _isAsRead ? Colors.red : Colors.white),
                      ))
                ],
              ),
              body: _isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      color: Colors.white,
                    )
                  : SingleChildScrollView(
                      child: Container(
                          height: deviceSize.height,
                          width: deviceSize.width,
                          color: _isAsRead ? Colors.red : Colors.blue,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              DeatilsOwner(owner.picture, widget.id,
                                  owner.firstName, owner.lastName),
                              SizedBox(height: 10),
                              PostDetailsCard(
                                  context,
                                  id,
                                  owner.firstName,
                                  owner.lastName,
                                  owner.picture,
                                  textPost,
                                  imagePost,
                                  tags,
                                  link,
                                  likes,
                                  publishDatePost)
                            ],
                          ))),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_sharp, color: Colors.black),
              ),
            )));
  }
}
