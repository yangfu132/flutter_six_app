import 'dart:math';
import '../../1L_Context/SACGlobal.dart';

///
class SABEasyModel {
  //构造函数
  SABEasyModel(this._strEasyGoal, this._strUsefulGod) {
    _nEasyTime = DateTime.now().microsecondsSinceEpoch;
    _listEasyData = generateEasyArray();
    _usefulGodRow = nGlobalRowInvalid;
  }

  //属性：实例发生时间
  int _nEasyTime;

//属性：实例的随机数数组
  List _listEasyData;

  //属性：实例的发生目的
  String _strEasyGoal;

  //属性：实例的用神
  String _strUsefulGod;

  //属性：用神的索引号
  int _usefulGodRow;

  //函数：用神
  String getUsefulGod() {
    return _strUsefulGod;
  }

  //函数：天干
  String skyTrunkString() {
    return "甲乙丙丁戊己庚辛壬癸";
  }

  //函数：地址
  String earthBranchString() {
    return "子丑寅卯辰巳午未申酉戌亥";
  }

  ///利用随机数创造数据
  List generateEasyArray() {
    List listResult = List();
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      int randomNum = Random().nextInt(3);
      if (2 == randomNum)
        randomNum = 8;
      else if (3 == randomNum) randomNum = 9;
      //else cont.
      listResult.add(randomNum);
    } //endf
    return listResult;
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
}
