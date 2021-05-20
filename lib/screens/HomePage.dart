import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../models/posts.dart';
import '../authorization/auth.dart';
import 'post_details.dart';
import 'package:posts_task/widget/post_card.dart';
import 'package:posts_task/models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Posts>(context, listen: false).fetchData().then((_) {
      _isLoading = false;
    }).catchError((onError) => print(onError));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> postList = Provider.of<Posts>(context, listen: true).postsList;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('My Posts'),
            actions: [
              ElevatedButton(
                  onPressed: () =>
                      Provider.of<Auth>(context, listen: false).logout(),
                  child: Text("LogOut"))
            ],
          ),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : (postList.isEmpty
                  ? Center(
                      child: Text('No Posts Added.',
                          style: TextStyle(fontSize: 22)))
                  : RefreshIndicator(
                      onRefresh: () async =>
                          await Provider.of<Posts>(context, listen: false)
                              .fetchData(),
                      child: ListView(
                        children: postList
                            .map((item) => PostCard(
                                item.id,
                                item.owner.firstName,
                                item.owner.lastName,
                                item.owner.picture,
                                item.textPost,
                                item.imagePost,
                                item.likes,
                                item.publishDatePost))
                            .toList(),
                      ),
                    )),
        ));
  }
}
