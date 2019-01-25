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
  AnimationController controller;
  AnimationController controllerTwo;
  Widget firstWidget;
  Widget secondWidget;
  Duration animationDuration;
  String currentCard = "Sign in";
  @override
  void initState() {
    super.initState();
    firstWidget = widget.firstWidget;
    secondWidget = widget.secondWidget;
    animationDuration = widget.duration;

    controller = AnimationController(vsync: this, duration: animationDuration);
    controllerTwo =
        AnimationController(vsync: this, duration: animationDuration);

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
    } else {
      setState(() {
        controller.forward();
        controllerTwo.forward();
        currentCard = card;
      });
    }
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
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _buttonTap("Sign in");
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.lightBlue,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Sign in"),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  _buttonTap("Sign up");
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.lightBlue,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Sign up"),
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
