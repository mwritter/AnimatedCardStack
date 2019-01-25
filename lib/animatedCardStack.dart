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

  @override
  void initState() {
    super.initState();
    firstWidget = widget.firstWidget;
    secondWidget = widget.secondWidget;
    animationDuration = widget.duration;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    controllerTwo =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          !swap ? firstWidget : secondWidget,
          !swap ? secondWidget : firstWidget,
        ],
      ),
    );
  }
}
