﻿import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';
import 'SABEightDiagramsModel.dart';
import 'SABEasyModel.dart';
import 'SABElementModel.dart';
import "package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart";

///此Business用于将EasyModel与数据进行关联；
class SABEasyBusiness {
  SABEasyBusiness(this._inputEasyModel);

  ///此属性代表八宫数据以及六十四卦信息；
  SABEightDiagramsModel _eightDiagrams;

  PWBCalendarBusiness _businessCalendar;

  SABEarthBranchBusiness _branchBusiness;

  final SABEasyModel _inputEasyModel;

  /// `此模块包含基础数据函数，提供给外部使用`////////////////////////////////////////

  ///此函数包含十天干
  String skyTrunkString() {
    return "甲乙丙丁戊己庚辛壬癸";
  }

  ///此函数包含十二地支
  String earthBranchString() {
    return "子丑寅卯辰巳午未申酉戌亥";
  }

  /// `此模块获取日期的数据`/////////////////////////////////////////////////////

  PWBCalendarBusiness businessCalendar() {
    if (null == _businessCalendar) {
      _businessCalendar = PWBCalendarBusiness(_inputEasyModel.getEasyTime());
    }
    return _businessCalendar;
  }

  String monthEarth() {
    return businessCalendar().earthBranchMonth().stringName();
  }

  String monthSky() {
    return businessCalendar().skyTrunkMonth().stringName();
  }

  String dayEarth() {
    return businessCalendar().earthBranchDay().stringName();
  }

  String daySky() {
    return businessCalendar().skyTrunkDay().stringName();
  }

  /// `此模块获取八宫以及六十四管的数据`/////////////////////////////////////////////

  ///方法注释：获取本卦所在八宫的第一卦
  Map placeFirstEasy() {
    String firstKey = eightDiagrams()
        .firstEasyKeyInDiagram(eightDiagrams().easyPlaceByName(fromEasyName()));
    Map fristEasy = eightDiagrams().getEasyDictionaryForKey(firstKey);
    return fristEasy;
  }

  ///此方法获取当前爻所在的八卦
  String eightGuaAtFromRow(int nRow) {
    String result = "";

    String fromEasyKey = _inputEasyModel.fromEasyKey();
    if (fromEasyKey.length >= 6) {
      String guaKey = "";
      if (nRow < 3)
        guaKey = fromEasyKey.substring(0, 3);
      else
        guaKey = fromEasyKey.substring(3, 6);

      result = SABEightDiagramsModel.palaceNameForKey(guaKey);
    } else
      colog("error!");

    return result;
  }

  ///此方法获取本卦在八宫中的信息
  Map fromEasyDictionary() {
    Map result =
        eightDiagrams().getEasyDictionaryForKey(_inputEasyModel.fromEasyKey());
    return result;
  }

  ///此方法获取变卦在八宫中的信息
  Map toEasyDictionary() {
    Map result =
        eightDiagrams().getEasyDictionaryForKey(_inputEasyModel.toEasyKey());
    return result;
  }

  ///此方法获取本卦的卦名
  String fromEasyName() {
    String stringResult = "";
    Map fromDict = fromEasyDictionary();
    if (null != fromDict) {
      stringResult = fromDict["name"];
    }
    //else cont.

    return stringResult;
  }

  ///此方法获取变卦的卦名
  String toEasyName() {
    String stringResult = "";
    Map toDict = toEasyDictionary();
    if (null != toDict) {
      stringResult = toDict["name"];
    }
    //else cont.
    return stringResult;
  }

  /// `此模块获取六爻的数据`/////////////////////////////////////////////////////////////////

  String symbolStringAtRow(int intIndex, Map mapEasy) {
    String stringResult;

    if (null != mapEasy) {
      List array = mapEasy["data"];
      stringResult = array[intIndex];
    }
    //else cont.

    return stringResult;
  }

  String symbolAtHideRow(int intIndex) {
    String result;
    int intHideIndex = intIndex;

    if (intHideIndex >= 0) {
      String symbolName = symbolStringAtRow(intHideIndex, placeFirstEasy());
      result = result + symbolName;
    } else
      result = "卦中用神未现"; //colog("error!");

    return result;
  }

  String symbolAtFromRow(int intIndex) {
    String result;

    if (0 <= intIndex && intIndex <= 5) {
      Map fromDict = fromEasyDictionary();
      String strSymbol = symbolStringAtRow(intIndex, fromDict);

      if (strSymbol.length >= 4) {
        String symbolDes = strSymbol.substring(strSymbol.length - 4, 4);
        int nValue = _inputEasyModel.symbolAtIndex(intIndex);
        if (8 == nValue) {
          result = "×" + symbolDes;
        } else if (9 == nValue) {
          result = "○" + symbolDes;
        } else
          result = strSymbol;
      } else
        colog("error!");
    }
    //else cont.

    return result;
  }

  String symbolAtChangeRow(int intIndex) {
    String stringResult;
    if (0 <= intIndex && intIndex <= 5) {
      if (_inputEasyModel.isMovementAtRow(intIndex)) {
        String fromEasyElement = eightDiagrams().elementOfEasy(fromEasyName());
        Map toDict = toEasyDictionary();
        if (null != toDict) {
          String symbol = symbolStringAtRow(intIndex, toDict);

          String toElement = symbolElement(symbol);

          String strValue =
              SABElementModel.elementRelative(fromEasyElement, toElement);
          stringResult = symbol.replaceRange(symbol.length - 4, 2, strValue);
        }
        //else cont.
      }
      //else cont.
    }
    //else cont.

    return stringResult;
  }

  String symbolAtRow(int intRow, EasyTypeEnum enumEasyType) {
    String strSymbol;

    if (enumEasyType == EasyTypeEnum.from) {
      strSymbol = symbolAtFromRow(intRow);
    } else if (enumEasyType == EasyTypeEnum.to) {
      strSymbol = symbolAtChangeRow(intRow);
    } else if (enumEasyType == EasyTypeEnum.hide) {
      strSymbol = symbolAtHideRow(intRow);
    } else
      colog("error!");

    return strSymbol;
  }

  /// `此模块包含世应相关的方法`///////////////////////////////////////////////////

  //在本卦中，获得世的索引号；
  int getLifeIndex() {
    Map fromDict = fromEasyDictionary();
    int shiIndex = fromDict["世"];
    return 6 - shiIndex;
  }

  //在指定卦中，获得世的索引号；
  int lifeIndexAtEasy(Map easyDict) {
    int shiIndex = easyDict["世"];
    return 6 - shiIndex;
  }

  String getLifeSymbol() {
    return symbolAtRow(getLifeIndex(), EasyTypeEnum.from);
  }

  String getGoalSymbol() {
    return symbolAtRow(goalIndex(), EasyTypeEnum.from);
  }

  int goalIndex() {
    Map fromDict = fromEasyDictionary();
    int yingIndex = fromDict["应"];
    return 6 - yingIndex;
  }

  /// `此模块包含提取爻信息的方法`///////////////////////////////////////////////////

  String earthAtFromRow(int intIndex) {
    String stringResult = "";
    if (0 <= intIndex && intIndex < 6) {
      String stringSymbol = symbolAtRow(intIndex, EasyTypeEnum.from);
      stringResult = symbolEarth(stringSymbol);
    }
    //else cont.

    return stringResult;
  }

  String earthAtChangeRow(int intIndex) {
    String stringResult = "";
    if (0 <= intIndex && intIndex < 6) {
      if (_inputEasyModel.isMovementAtRow(intIndex)) {
        String stringSymbol = symbolAtChangeRow(intIndex);
        stringResult = symbolEarth(stringSymbol);
      }
      //else cont.
    }
    //else cont.

    return stringResult;
  }

  String animalAtRow(int intIndex) {
    String stringResult = "";
    String dayName = daySky();
    if ("甲" == dayName || "乙" == dayName) {
      List array = ["玄武", "白虎", "螣蛇", "勾陈", "朱雀", "青龙"];

      stringResult = array[intIndex];
    } else if ("丙" == dayName || "丁" == dayName) {
      List array = ["青龙", "玄武", "白虎", "螣蛇", "勾陈", "朱雀"];

      stringResult = array[intIndex];
    } else if ("戊" == dayName) {
      List array = ["朱雀", "青龙", "玄武", "白虎", "螣蛇", "勾陈"];
      stringResult = array[intIndex];
    } else if ("己" == dayName) {
      List array = [
        "勾陈",
        "朱雀",
        "青龙",
        "玄武",
        "白虎",
        "螣蛇",
      ];
      stringResult = array[intIndex];
    } else if ("庚" == dayName || "辛" == dayName) {
      List array = [
        "螣蛇",
        "勾陈",
        "朱雀",
        "青龙",
        "玄武",
        "白虎",
      ];
      stringResult = array[intIndex];
    } else if ("壬" == dayName || "癸" == dayName) {
      List array = ["白虎", "螣蛇", "勾陈", "朱雀", "青龙", "玄武"];
      stringResult = array[intIndex];
    }

    return stringResult;
  }

  String symbolElement(String symbol) {
    String stringResult = "";

    if (symbol.length >= 1)
      stringResult = symbol.substring(symbol.length - 1, 1);
    else
      colog("");

    return stringResult;
  }

  String symbolParent(String stringSymbol) {
    String stringResult = "";

    if (stringSymbol.length >= 4)
      stringResult = stringSymbol.substring(stringSymbol.length - 4, 2);
    else
      colog("");

    return stringResult;
  }

  String earthAtMergeRow(int intRow) {
    String stringResult = "";

    String stringSymbol = symbolAtMergeRow(intRow);

    if ("" != stringSymbol) stringResult = symbolEarth(stringSymbol);
    //else cont.

    return stringResult;
  }

  String symbolAtMergeRow(int intRow) {
    String stringResult = "";

    if (0 <= intRow && intRow < 6) {
      stringResult = symbolAtRow(intRow, EasyTypeEnum.from);
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      stringResult = symbolAtRow(intRow - ROW_CHNAGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = symbolAtRow(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  bool isSymbolMovement(String stringSymbol) {
    bool bResult = false;
    if (null != stringSymbol && "" != stringSymbol) {
      String strMark = stringSymbol.substring(0, 1);
      bResult = "×" == strMark || "○" == strMark;
    } else
      colog("error!");

    return bResult;
  }

  String symbolEarth(String stringSymbol) {
    String stringResult = "";
    if (stringSymbol.length >= 2)
      stringResult = stringSymbol.substring(stringSymbol.length - 2, 1);
    else
      stringResult = "卦中用神未现"; //colog("error!");

    return stringResult;
  }

  String easyTitle() {
    return _businessCalendar.stringFromDate() + _inputEasyModel.getEasyGoal();
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  ///此方法加载六十四卦信息
  SABEightDiagramsModel eightDiagrams() {
    if (null == _eightDiagrams) _eightDiagrams = SABEightDiagramsModel();
    //else cont.

    return _eightDiagrams;
  }
}
