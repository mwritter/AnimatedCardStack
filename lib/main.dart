import 'package:card_stack_app/animatedCardStack.dart';
import 'package:card_stack_app/signin.dart';
import 'package:card_stack_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 35.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: AnimatedCardStack(
                duration: Duration(milliseconds: 500),
                firstWidget: SignUp(),
                secondWidget: SignIn(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
