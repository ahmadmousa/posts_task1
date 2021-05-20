import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailsCard extends StatelessWidget {
  String id;
  String firstName;
  String lastName;
  String imageOwner;
  String textPost;
  String imagePost;
  List<dynamic> tags;
  int likes;
  String datePost;
  String link;
  final context;

  PostDetailsCard(
    @required this.context,
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.imageOwner,
    @required this.textPost,
    @required this.imagePost,
    @required this.tags,
    @required this.link,
    @required this.likes,
    @required this.datePost,
  );

  _launchURL() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("link not found"),
                title: Text('An Error'),
                actions: [
                  ElevatedButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  List<Widget> listTagsButton = List<Widget>();
  List<Widget> _buildTagesButtons() {
    listTagsButton.clear();
    for (int index = 0; index < tags.length; index++) {
      listTagsButton.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: TextButton(
            onPressed: () {},
            child: Text(
              tags[index],
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )),
      ));
    }
    return listTagsButton;
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    //alignment: Alignment.centerLeft,
                    child: Text(
                      datePost.substring(12, 16) +
                          " " +
                          datePost.substring(0, 10),
                      //  textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                  height: 3,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Text(textPost)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 200,
                  width: double.infinity,
                  child: Image.network(imagePost),
                ),
                SizedBox(height: 10),
                LikeButton(
                  likeCount: likes,
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
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: _launchURL,
                  child: Text("link post"),
                ),
                SizedBox(height: 7),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Wrap(
                      children: _buildTagesButtons(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      //),
    );
    //);
  }
}
