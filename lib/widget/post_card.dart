import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:posts_task/screens/post_details.dart';

class PostCard extends StatefulWidget {
  String id;
  String firstName;
  String lastName;
  String imageOwner;
  String textPost;
  String imagePost;
  int likes;
  String datePost;

  PostCard(
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.imageOwner,
    @required this.textPost,
    @required this.imagePost,
    @required this.likes,
    @required this.datePost,
  );
  // final deviceSize = MediaQuery.of(context).size;

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) => ElevatedButton(
        onPressed: () {
          print(widget.id);
          Navigator.push(
            innerContext,
            MaterialPageRoute(builder: (_) => PostsDetails(widget.id)),
          );
        },
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.imageOwner))),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      TextButton(
                          onPressed: () {},
                          child:
                              Text(widget.firstName + " " + widget.lastName)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.datePost.substring(12, 16) +
                            " " +
                            widget.datePost.substring(0, 10),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      child: Text(widget.textPost)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 200,
                    width: double.infinity,
                    child: Image.network(widget.imagePost),
                  ),
                  SizedBox(height: 10),
                  LikeButton(
                    likeCount: widget.likes,
                    circleColor: CircleColor(
                        start: Color(0xFFF44336), end: Color(0xFFF44336)),
                    likeBuilder: (bool isLike) {
                      return Icon(
                        Icons.favorite,
                        size: 30,
                        color: isLike ? Colors.red : Colors.grey,
                      );
                    },
                  ),
                  SizedBox(height: 7),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
