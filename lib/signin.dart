import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  final Color textgroundColor = Colors.lightBlue.withOpacity(0.2);
  final BorderRadius textBorderRadius = BorderRadius.circular(10.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.withOpacity(0.5), width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey, offset: Offset(3.0, 3.0), blurRadius: 5.0),
          ]),
      height: MediaQuery.of(context).size.height * 0.70,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 50.0,
              child: Text(
                "Sign in",
                style: TextStyle(fontSize: 35.0, color: Colors.lightBlue),
              )),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue.withOpacity(0.5), width: 1.0),
                      color: textgroundColor,
                      borderRadius: textBorderRadius),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'email'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue.withOpacity(0.5), width: 1.0),
                      color: textgroundColor,
                      borderRadius: textBorderRadius),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'password'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
