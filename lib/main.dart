import 'package:card_stack_app/animatedCardStack.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: AnimatedCardStack(
            duration: Duration(seconds: 1),
            firstWidget: Container(
              color: Colors.lightBlue,
              height: 150.0,
              width: 150.0,
            ),
            secondWidget: Container(
              color: Colors.lightGreen,
              height: 150.0,
              width: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}
