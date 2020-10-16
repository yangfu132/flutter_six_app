import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class AnimationMutileImage extends StatefulWidget {
  final Map<int, Image> imageCaches;
  final double width;
  final double height;
  final Color backColor;
  final bool bRandom;
  final bool bCancel;
  AnimationMutileImage(
      this.imageCaches, this.width, this.height, this.backColor, this.bRandom,
      {Key key, this.bCancel})
      : assert(imageCaches != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WOActionImageState();
  }
}

class _WOActionImageState extends State<AnimationMutileImage> {
  bool _disposed;
  Duration _duration;
  int _imageIndex;
  Container _container;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _disposed = false;
    _duration = Duration(milliseconds: 50);
    _imageIndex = 1;
    _container = Container(height: widget.height, width: widget.width);
    _updateImage();
  }

  void _updateImage() {
    if (_disposed || widget.imageCaches.isEmpty) {
      return;
    }

    setState(() {
      if (_imageIndex > widget.imageCaches.length) {
        _imageIndex = 1;
      }
      print('_imageIndex:$_imageIndex');
      Image imageValue = widget.imageCaches[_imageIndex];

      _container = Container(
        color: widget.backColor,
        child: imageValue,
        height: widget.height,
        width: widget.width,
      );
      if (widget.bRandom) {
        _imageIndex = Random().nextInt(widget.imageCaches.length) + 1;
      } else {
        _imageIndex++;
      }
    });

    _timer = Timer(_duration, () {
      _updateImage();
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    widget.imageCaches.clear();
  }

  @override
  Widget build(BuildContext context) {
    return _container;
  }
}
