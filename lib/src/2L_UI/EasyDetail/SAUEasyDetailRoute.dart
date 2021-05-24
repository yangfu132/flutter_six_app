import 'package:flutter/material.dart';

import '../../3L_Business/Detail/SABEasyDetailBusiness.dart';
import '../../3L_Business/Detail/SABEasyDetailModel.dart';
import '../../3L_Business/Easy/SABEasyDigitModel.dart';
import '../EasyResult/SAUEasyResultRoute.dart';

class SAUEasyDetailRoute extends StatefulWidget {
  SAUEasyDetailRoute(this.inputEasyModel);
  final SABEasyDigitModel inputEasyModel;

  @override
  _SAUEasyDetailRouteState createState() {
    return _SAUEasyDetailRouteState();
  }
}

class _SAUEasyDetailRouteState extends State<SAUEasyDetailRoute> {
  late final SABEasyDetailBusiness detailBusiness;

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
        body: Column(
          children: getRowWidgets(detailModel().detailList()),
        ));
  }

  List<Widget> getRowWidgets(List listDetail) {
    List<Widget> listRow = [];
    int intCount = listDetail.length;
    for (int intRow = 0; intRow < intCount; intRow++) {
      Widget widgetRow;
      if (0 == intRow) {
        widgetRow = Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SAUEasyResultRoute(widget.inputEasyModel);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
              ),
              child: Row(
                children: getWidgetList(listDetail[intRow]),
              ),
            ),
          ),
        );
      } else {
        widgetRow = Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SAUEasyResultRoute(widget.inputEasyModel);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)),
                ),
              ),
              child: Row(
                children: getWidgetList(listDetail[intRow]),
              ),
            ),
          ),
        );
      }
      listRow.add(widgetRow);
    }
    return listRow;
  }

  List<Widget> getWidgetList(List<String> listContent) {
    List<Widget> result = [];
    for (int nColumn = 0; nColumn < listContent.length; nColumn++) {
      String stringItem = listContent[nColumn];
      if (2 == nColumn || 5 == nColumn || 8 == nColumn) {
        Widget widgetItem = Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: double.infinity),
            child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              foregroundDecoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Color(0xffe5e5e5)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stringItem,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        );
        result.add(widgetItem);
      } else {
        Widget widgetItem = ConstrainedBox(
          constraints: BoxConstraints(minHeight: double.infinity),
          child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Color(0xffe5e5e5)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stringItem,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        );
        result.add(widgetItem);
      }
    }
    return result;
  }
}
