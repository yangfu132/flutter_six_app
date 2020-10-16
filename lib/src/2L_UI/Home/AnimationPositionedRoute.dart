import 'package:flutter/material.dart';

class AnimationPositionedRoute extends StatefulWidget {
  @override
  AnimationPositionedRouteState createState() {
    return AnimationPositionedRouteState();
  }
}

class AnimationPositionedRouteState extends State<AnimationPositionedRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<RelativeRect> _animation;
  Animation _curve;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _animation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(400.0, 400.0, 0.0, 0.0),
            end: RelativeRect.fromLTRB(0.0, 0.0, 400.0, 400.0))
        .animate(_curve)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((AnimationStatus state) {
            if (state == AnimationStatus.completed) {
              _controller.reverse();
            } else if (state == AnimationStatus.dismissed) {
              _controller.forward();
            }
            setState(() {});
          });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PositionedTransition(
            rect: _animation,
            child: Image.asset('images/2@2x.png'),
          ),
        ],
      ),
    );
  }
}
