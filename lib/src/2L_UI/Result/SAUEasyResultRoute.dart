import 'package:flutter/material.dart';
import '../../3L_Business/Easy/SABEasyModel.dart';
import '../../3L_Business/Easy/SABEasyBusiness.dart';
import '../../3L_Business/Result/SABEasyResultBusiness.dart';
import '../../3L_Business/Result/SABEasyResultModel.dart';

class SAUEasyResultRoute extends StatefulWidget {
  SAUEasyResultRoute(this.easyModel) {
    this.resultBusiness.configResultModel(this.easyModel, this.resultModel);
  }
  final SABEasyModel easyModel;
  final SABEasyBusiness easyBusiness = SABEasyBusiness();
  final SABEasyResultBusiness resultBusiness = SABEasyResultBusiness();
  final SABEasyResultModel resultModel = SABEasyResultModel();
  @override
  _SAUEasyResultState createState() {
    return _SAUEasyResultState();
  }
}

class _SAUEasyResultState extends State<SAUEasyResultRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView.builder(
          itemCount: widget.resultModel.resultList.length * 2,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = widget.resultModel.resultList[dataIndex];
            if (kv > 0)
              return ListTile(title: Text(value['value']));
            else
              return ListTile(title: Text(value['key']));
          }),
    );
  }
}
