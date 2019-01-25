import 'package:flutter/material.dart';

class AnimatedCardStack extends StatefulWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final Duration duration;

  AnimatedCardStack(
      {@required this.duration,
      @required this.firstWidget,
      @required this.secondWidget});

  _AnimatedCardStackState createState() => _AnimatedCardStackState();
}

class _AnimatedCardStackState extends State<AnimatedCardStack>
    with TickerProviderStateMixin {
  bool swap = false;
  Animation<double> animation;
  Animation<double> animationTwo;
  Animation<double> animateButton;
  Animation<double> animateButtonTwo;
  AnimationController controller;
  AnimationController controllerTwo;
  AnimationController controllerSignInButton;
  AnimationController controllerSignUpButton;
  Widget firstWidget;
  Widget secondWidget;
  Duration animationDuration;
  String currentCard = "Sign in";
  bool textColorBlue = false;

  @override
  void initState() {
    super.initState();
    firstWidget = widget.firstWidget;
    secondWidget = widget.secondWidget;
    animationDuration = widget.duration;

    controller = AnimationController(vsync: this, duration: animationDuration);
    controllerTwo =
        AnimationController(vsync: this, duration: animationDuration);
    controllerSignInButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animateButton = Tween(begin: 15.0, end: 30.0).animate(CurvedAnimation(
      parent: controllerSignInButton,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          textColorBlue = !textColorBlue;
        }
      }));
    controllerSignUpButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animateButtonTwo = Tween(begin: 15.0, end: 30.0).animate(CurvedAnimation(
      parent: controllerSignUpButton,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          textColorBlue = !textColorBlue;
        }
      }));

    animation = Tween(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
          reverseCurve: Curves.elasticIn),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          swap = !swap;
          controller.reverse();
        }
      });
    animationTwo = Tween(begin: 0.0, end: -0.7).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controllerTwo.reverse();
        }
      });
    setState(() {
      controllerSignInButton.forward();
    });

    animateButton.addListener(() {
      setState(() {});
    });

    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    controllerTwo?.dispose();
    super.dispose();
  }

  Widget _buildCardOne() {
    return Transform.rotate(
      origin: Offset(50.0, 100.0),
      angle: animation.value,
      child: firstWidget,
    );
  }

  Widget _buildCardTwo() {
    return Transform.rotate(
      origin: Offset(-50.0, 100.0),
      angle: animationTwo.value,
      child: secondWidget,
    );
  }

  _buttonTap(String card) {
    if (currentCard == card) {
      return;
    }

    if (card == "Sign up") {
      setState(() {
        controllerSignUpButton.forward();
        controllerSignInButton.reverse();
      });
    } else {
      setState(() {
        controllerSignUpButton.reverse();
        controllerSignInButton.forward();
      });
    }
    textColorBlue = !textColorBlue;
    setState(() {
      textColorBlue = !textColorBlue;
      controller.forward();
      controllerTwo.forward();
      currentCard = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              !swap ? _buildCardOne() : _buildCardTwo(),
              !swap ? _buildCardTwo() : _buildCardOne(),
            ],
          ),
          //Controls
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    highlightColor: Colors.lightBlue,
                    onTap: () {
                      _buttonTap("Sign in");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue.withOpacity(0.5), width: 1.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: textColorBlue ? Colors.blue : null,
                          fontSize: animateButton.value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              GestureDetector(
                child: Material(
                  elevation: 3.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    highlightColor: Colors.lightBlue,
                    onTap: () {
                      _buttonTap("Sign up");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue.withOpacity(0.5), width: 1.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: textColorBlue ? null : Colors.blue,
                          fontSize: animateButtonTwo.value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
