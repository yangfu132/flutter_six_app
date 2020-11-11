import 'dart:math';

///此Model仅代表占卜时所创造的数据；
class SABEasyModel {
  //构造函数
  SABEasyModel(this._strEasyGoal, this._strUsefulGod) {}

  //属性：实例发生时间
  DateTime _nEasyTime;

//属性：实例的随机数数组
  List _listEasyData;

  //属性：实例的发生目的
  String _strEasyGoal;

  //属性：实例的用神
  String _strUsefulGod;

  DateTime getEasyTime() {
    return _nEasyTime;
  }

  //函数：占卜目的
  String getEasyGoal() {
    return _strEasyGoal;
  }

  //函数：用神
  String getUsefulGod() {
    return _strUsefulGod;
  }

  ///利用随机数创造数据
  List generateEasyArray() {
    _nEasyTime = DateTime.now();
    _listEasyData = List();
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      int randomNum = Random().nextInt(3);
      if (2 == randomNum)
        randomNum = 8;
      else if (3 == randomNum) randomNum = 9;
      //else cont.
      _listEasyData.add(randomNum);
    } //endf
    return _listEasyData;
    //return _listEasyData = [8, 1, 1, 8, 8, 1];
  }

  bool isMovementAtRow(int nRow) {
    bool result = false;

    if (0 <= nRow && nRow < 6) {
      if (8 == _listEasyData[nRow]) {
        result = true;
      } else if (9 == _listEasyData[nRow]) {
        result = true;
      }
      //else cont.
    } else
      result = false;
    //CO_LOG(@"error!");

    return result;
  }

  String fromEasyKey() {
    String strFromKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = _listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 0;
      else if (nValue == 9)
        nFromValue = 1;
      else
        nFromValue = nValue;
      strFromKey = "$strFromKey$nFromValue";
    } //endf

    return strFromKey;
  }

  String toEasyKey() {
    String strToKey = "";
    int nValue, nFromValue;
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      nValue = _listEasyData[nIndex];
      if (nValue == 8)
        nFromValue = 1;
      else if (nValue == 9)
        nFromValue = 0;
      else
        nFromValue = nValue;
      strToKey = "$strToKey$nFromValue";
    } //endf

    return strToKey;
  }

  int symbolAtIndex(int intSymbolIndex) {
    return _listEasyData[intSymbolIndex];
  }

  ///此函数获取内卦变动的爻列表
  List inGuaMovementArray() {
    List inMovementArray = [];

    for (int intIndex = 3; intIndex < 6; intIndex++) {
      int intValue = _listEasyData[intIndex];
      if (8 == intValue || 9 == intValue) {
        inMovementArray.add(intValue);
      }
      //else cont.
    } //endf

    return inMovementArray;
  }

  ///此函数获取外卦变动的爻列表
  List outGuaMovementArray() {
    List outMovementArray = [];
    for (int intIndex = 0; intIndex < 3; intIndex++) {
      int intValue = _listEasyData[intIndex];

      if (8 == intValue || 9 == intValue) {
        outMovementArray.add(intValue);
      }
      //else cont.
    } //endf

    return outMovementArray;
  }
}
