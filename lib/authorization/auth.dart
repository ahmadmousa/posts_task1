import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;

// Check token user found or not
  bool get isAuth {
    return _token != null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    // Create url sign in or sign up
    // url segment detemint sign in or sign up
    var url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:$urlSegment',
        {'key': 'AIzaSyDYJ94w358sGJpfGLmakrks9OXxJ-G0P5w'});
    try {
      // Request get authentication
      final resource = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final resourceData = json.decode(resource.body);
      // Check if respones contain error or not
      if (null != resourceData['error']) {
        throw "${resourceData['error']['message']}";
      }
      // save token to give me authraiz in life cycle app
      _token = resourceData['idToken'];

      final pref = await SharedPreferences.getInstance();

      pref.setString('token', _token);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  // Check if store token in app or no
  // if found token then skip auth_screen
  Future<bool> isAutoLogin() async {
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('token')) return false;
    _token = pref.getString('token');

    notifyListeners();
    return true;
  }

  // log out user and remove token user
  void logout() async {
    _token = null;
    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
