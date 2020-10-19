import 'package:flutter/material.dart';
import '../../3L_Business/Result/SABEasyResultBusiness.dart';
import '../../3L_Business/Result/SABEasyResultModel.dart';

class SAUEasyResultRoute extends StatefulWidget {
  @override
  _SAUEasyResultState createState() {
    return _SAUEasyResultState();
  }
}

class _SAUEasyResultState extends State<SAUEasyResultRoute> {
  final SABEasyResultBusiness _resultBusiness = SABEasyResultBusiness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            SABEasyResultModel resultModel = _resultBusiness.getResultModel();
            Map value = resultModel.resultList[index];
            return ListTile(title: Text(value['key']));
          }),
    );
  }
}
