import 'package:flutter/material.dart';

class DeatilsOwner extends StatelessWidget {
  String imageOwner;
  String id;
  String firstName;
  String lastName;

  DeatilsOwner(@required this.imageOwner, @required this.id,
      @required this.firstName, @required this.lastName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imageOwner))),
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                firstName + " " + lastName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
