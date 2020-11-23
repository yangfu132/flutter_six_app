import 'package:flutter/material.dart';
import '../EasyResult/SAUEasyResultRoute.dart';
import '../../3L_Business/Easy/SABEasyDigitModel.dart';
import '../../3L_Business/Detail/SABEasyDetailBusiness.dart';
import '../../3L_Business/Detail/SABEasyDetailModel.dart';

class SAUExpertCategoryRoute extends StatefulWidget {
  SAUExpertCategoryRoute(this.inputEasyModel);
  final SABEasyDigitModel inputEasyModel;

  @override
  _SAUExpertCategoryRoute createState() {
    return _SAUExpertCategoryRoute();
  }
}

class _SAUExpertCategoryRoute extends State<SAUExpertCategoryRoute> {
  SABEasyDetailBusiness detailBusiness;

  @override
  void initState() {
    super.initState();
    detailBusiness = SABEasyDetailBusiness(widget.inputEasyModel);
  }

  SABEasyDetailModel detailModel() {
    return detailBusiness.outputDetailModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailModel().stringDetailName),
      ),
      body: ListView.builder(
          itemCount: detailModel().detailList.length * 2,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = detailModel().detailList[dataIndex];
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
