import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_six_app/src/1L_Context/SACContext.dart';
import 'AnimationMutileImage.dart';

///note：三个色子转动的动画
class AnimationDiceWidget extends StatefulWidget {
  final VoidCallback callbackFinish;
  AnimationDiceWidget(this.callbackFinish);
  @override
  AnimationDiceState createState() {
    return AnimationDiceState();
  }
}

class AnimationDiceState extends State<AnimationDiceWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animationOffset1;
  Animation<Offset> _animationOffset2;
  Animation<Offset> _animationOffset3;
  Widget dice1;
  Widget dice2;
  Widget dice3;
  AnimationMutileImage images;
  bool _bFinish = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    _animationOffset1 = animationMethod(tweenSequenceDice1());
    _animationOffset2 = animationMethod(tweenSequenceDice2());
    _animationOffset3 = animationMethod(tweenSequenceDice3());

    _controller.forward();
  }

  TweenSequence<Offset> tweenSequenceDice1() {
    double rate = 1 / 50;
    double offsetX = 30 * rate;
    double offsetY = 20 * rate;
    Offset _offset0 = Offset(140.0 * rate, 200.0 * rate + offsetY);
    Offset _offset1 = Offset(85.0 * rate + offsetX, 115.0 * rate + offsetY);
    Offset _offset2 = Offset(165.0 * rate + offsetX, 100.0 * rate + offsetY);
    Offset _offset3 = Offset(240.0 * rate + offsetX, 160.0 * rate + offsetY);
    Offset _offset4 = Offset(140.0 * rate + offsetX, 200.0 * rate + offsetY);
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset0, end: _offset1), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset1, end: _offset2), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset2, end: _offset3), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset3, end: _offset4), weight: 1),
    ]);
  }

  TweenSequence<Offset> tweenSequenceDice2() {
    double rate = 1 / 50;
    double offsetX = 50 * rate;
    double offsetY = 20 * rate;
    //Tween(begin: _offsetBegin, end: _offsetEnd)
    Offset _offset0 = Offset(100.0 * rate + offsetX, 130.0 * rate + offsetY);
    Offset _offset1 = Offset(195.0 * rate + offsetX, 115.0 * rate + offsetY);
    Offset _offset2 = Offset(175.0 * rate + offsetX, 95.0 * rate + offsetY);
    Offset _offset3 = Offset(140.0 * rate + offsetX, 220.0 * rate + offsetY);
    Offset _offset4 = Offset(100.0 * rate + offsetX, 130.0 * rate + offsetY);
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset0, end: _offset1), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset1, end: _offset2), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset2, end: _offset3), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset3, end: _offset4), weight: 1),
    ]);
  }

  TweenSequence<Offset> tweenSequenceDice3() {
    double rate = 1 / 50;
    double offsetX = 50 * rate;
    double offsetY = 20 * rate;
    //Tween(begin: _offsetBegin, end: _offsetEnd)
    Offset _offset0 = Offset(230.0 * rate + offsetX, 110.0 * rate + offsetY);
    Offset _offset1 = Offset(200.0 * rate + offsetX, 180.0 * rate + offsetY);
    Offset _offset2 = Offset(90.0 * rate + offsetX, 190.0 * rate + offsetY);
    Offset _offset3 = Offset(70.0 * rate + offsetX, 140.0 * rate + offsetY);
    Offset _offset4 = Offset(230.0 * rate + offsetX, 110.0 * rate + offsetY);
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset0, end: _offset1), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset1, end: _offset2), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset2, end: _offset3), weight: 1),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: _offset3, end: _offset4), weight: 1),
    ]);
  }

  Animation<Offset> animationMethod(tweenSequence) {
    Animation<Offset> animationOffset = tweenSequence.animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!_bFinish) {
            _bFinish = true;
            widget.callbackFinish();
          }
          //else cont.
        }
      });

    return animationOffset;
  }

  Widget movingDice(context, animationOffset) {
    Image theImage = Image.asset('images/dong1@2x.png');

    double rate = 700;
    rate = SACContext.screenWidth(context);
    rate = rate / 350;
    int width = 45;
    int height = 45;
    theImage.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
      width = info.image.width;
      height = info.image.height;
    }));
    return SlideTransition(
      position: animationOffset,
      child: RotationTransition(
        child: AnimationMutileImage(
          {
            1: Image.asset(
              'images/dong1@2x.png',
              width: width * rate,
              height: height * rate,
              fit: BoxFit.fill,
            ),
            2: Image.asset(
              'images/dong2@2x.png',
              fit: BoxFit.fill,
              width: width * rate,
              height: height * rate,
            ),
            3: Image.asset(
              'images/dong3@2x.png',
              fit: BoxFit.fill,
              width: width * rate,
              height: height * rate,
            )
          },
          width * rate,
          height * rate,
          Colors.transparent,
          true,
        ),
        // child: images, //Image.asset('images/dong1@2x.png'),
        turns: _controller
          ..addStatusListener(
            (status) {},
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (dice1 == null) dice1 = movingDice(context, _animationOffset1);
    if (dice2 == null) dice2 = movingDice(context, _animationOffset2);
    if (dice3 == null) dice3 = movingDice(context, _animationOffset3);
    return Stack(
      children: <Widget>[
        dice1,
        dice2,
        dice3,
      ],
    );
  }
}

///note：测试界面
class AnimationRoute extends StatefulWidget {
  @override
  AnimationRouteState createState() {
    return AnimationRouteState();
  }
}

class AnimationRouteState extends State<AnimationRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        centerTitle: true,
      ),
      body: AnimationDiceWidget(() {}),
    );
  }
}
