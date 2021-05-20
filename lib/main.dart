import 'package:flutter/material.dart';
import 'package:posts_task/screens/waiting_screen.dart';
import 'screens/auth_screen.dart';
import 'authorization/auth.dart';
import 'screens/HomePage.dart';
import 'models/posts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<Posts>(
          create: (_) => Posts(),
        ),
      ],
      // Check if user alreday log in
      child: Consumer<Auth>(
        builder: (context, value, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: value.isAuth
              ? HomePage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).isAutoLogin(),
                  builder: (context, snapShot) =>
                      ConnectionState.waiting == snapShot.connectionState
                          ? WaitingScreen()
                          : AuthScreen()),
        ),
      ),
    );
  }
}
