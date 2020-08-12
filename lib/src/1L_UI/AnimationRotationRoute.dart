import 'package:flutter/material.dart';

class RotationDemoRoute extends StatefulWidget {
  @override
  RotationDemoRouteState createState() {
    return RotationDemoRouteState();
  }
}

class RotationDemoRouteState extends State<RotationDemoRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: RotationTransition(
        child: CircleAvatar(
          radius: 25,
          backgroundImage: ExactAssetImage('images/dong1@2x.png'),
          child: Icon(Icons.queue_music),
        ),
        turns: _controller
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _controller.reset();
                _controller.forward();
              }
            },
          ),
      ),
    );
  }
}
