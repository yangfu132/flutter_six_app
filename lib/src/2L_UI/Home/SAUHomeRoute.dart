import 'package:flutter/material.dart';

import 'SAUHomeBody.dart';

class SAUHomeRoute extends StatefulWidget {
  SAUHomeRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUHomeRouteState createState() {
    return SAUHomeRouteState();
  }
}

class SAUHomeRouteState extends State<SAUHomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SAUHomeBody(),
    );
  }
}
