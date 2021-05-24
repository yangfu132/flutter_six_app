import 'package:flutter/material.dart';

import '../../3L_Business/Easy/SABEasyDigitModel.dart';
import '../../3L_Business/Result/SABEasyResultBusiness.dart';
import '../../3L_Business/Result/SABEasyResultModel.dart';
import '../EasyResult/SAUEasyResultRoute.dart';

class SAUExpertCategoryRoute extends StatefulWidget {
  SAUExpertCategoryRoute(this.inputEasyModel);
  final SABEasyDigitModel inputEasyModel;

  @override
  _SAUExpertCategoryRoute createState() {
    return _SAUExpertCategoryRoute();
  }
}

class _SAUExpertCategoryRoute extends State<SAUExpertCategoryRoute> {
  late final SABEasyResultBusiness detailBusiness;
  SABEasyResultModel outputResultModel = SABEasyResultModel();

  @override
  void initState() {
    super.initState();
    detailBusiness = SABEasyResultBusiness();
    detailBusiness.configResultModel(widget.inputEasyModel, outputResultModel);
  }

  SABEasyResultModel resultModel() {
    return outputResultModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('补充'),
      ),
      body: ListView.builder(
          itemCount: resultModel().resultList.length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = resultModel().resultList[dataIndex];
            if (kv > 0)
              return ListTile(
                title: Text(value['value']),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SAUEasyResultRoute(widget.inputEasyModel);
                  }));
                },
              );
            else
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(title: Text(value['key'])),
              );
            //return ListTile(title: Text(value['key']));
          }),
    );
  }
}
