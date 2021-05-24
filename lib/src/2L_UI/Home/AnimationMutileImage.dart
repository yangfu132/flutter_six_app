import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimationMutileImage extends StatefulWidget {
  final Map<int, Image> imageCaches;
  final double width;
  final double height;
  final Color backColor;
  final bool bRandom;
  final bool? bCancel;
  AnimationMutileImage(
      this.imageCaches, this.width, this.height, this.backColor, this.bRandom,
      {this.bCancel})
      : assert(imageCaches != null);

  @override
  State<StatefulWidget> createState() {
    return new _WOActionImageState();
  }
}

class _WOActionImageState extends State<AnimationMutileImage> {
  bool _disposed = false;
  Duration _duration = Duration(milliseconds: 50);
  int _imageIndex = 1;
  late Container _container;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
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
      Image imageValue = widget.imageCaches[_imageIndex]!;

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
