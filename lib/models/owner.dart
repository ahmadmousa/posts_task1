import 'package:flutter/material.dart';

class Owner {
  final String id;
  final String email;
  final String title;
  final String picture;
  final String firstName;
  final String lastName;

  Owner({
    @required this.id,
    @required this.email,
    @required this.title,
    @required this.picture,
    @required this.firstName,
    @required this.lastName,
  });
}
