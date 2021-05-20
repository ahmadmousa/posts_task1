import 'dart:async';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:posts_task/widget/auth_card.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(100, 100, 255, 50).withOpacity(0.3),
                          Color.fromRGBO(0, 0, 250, 20).withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 1],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 80.0),
                              transform: Matrix4.rotationZ(-4 * pi / 180)
                                ..translate(-5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueAccent,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.black26,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: Text(
                                'Welcome to back !',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: AuthCard(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
