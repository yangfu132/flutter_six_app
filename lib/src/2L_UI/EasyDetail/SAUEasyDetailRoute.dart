import 'package:flutter/material.dart';
import '../EasyResult/SAUEasyResultRoute.dart';
import '../../3L_Business/Easy/SABEasyDigitModel.dart';
import '../../3L_Business/Detail/SABEasyDetailBusiness.dart';
import '../../3L_Business/Detail/SABEasyDetailModel.dart';

class SAUEasyDetailRoute extends StatefulWidget {
  SAUEasyDetailRoute(this.inputEasyModel);
  final SABEasyDigitModel inputEasyModel;

  @override
  _SAUEasyDetailRouteState createState() {
    return _SAUEasyDetailRouteState();
  }
}

class _SAUEasyDetailRouteState extends State<SAUEasyDetailRoute> {
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
          itemCount: detailModel().detailList().length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            List listValue = detailModel().detailList()[index];
            if (0 == index) {
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  title: Row(children: getWidgetList(listValue)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SAUEasyResultRoute(widget.inputEasyModel);
                    }));
                  },
                ),
              );
            } else {
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Row(children: getWidgetList(listValue)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SAUEasyResultRoute(widget.inputEasyModel);
                    }));
                  },
                ),
              );
            }
          }),
    );
  }

  List<Widget> getWidgetList(List<String> listContent) {
    List<Widget> result = [];
    for (String stringItem in listContent) {
      result.add(Text(stringItem));
    }
    return result;
  }
}
