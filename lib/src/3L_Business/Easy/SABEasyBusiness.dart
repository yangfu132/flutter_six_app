import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import 'SABEightDiagramsModel.dart';
import 'SABEasyDigitModel.dart';
import 'SABElementModel.dart';
import "package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart";
import 'SABEasyWordsModel.dart';

///此Business用于将EasyModel与数据进行关联；
class SABEasyBusiness {
  SABEasyBusiness(this._inputEasyModel);

  ///此属性代表八宫数据以及六十四卦信息；
  SABEightDiagramsModel _eightDiagrams;

  PWBCalendarBusiness _businessCalendar;

  final SABEasyDigitModel _inputEasyModel;

  SABEasyWordsModel _outEasyWordsModel;

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

  String symbolAtRow(int intRow, EasyTypeEnum enumEasyType) {
    String strSymbol;

    if (enumEasyType == EasyTypeEnum.from) {
      strSymbol = symbolAtFromRow(intRow);
    } else if (enumEasyType == EasyTypeEnum.to) {
      strSymbol = symbolAtToRow(intRow);
    } else if (enumEasyType == EasyTypeEnum.hide) {
      strSymbol = symbolAtHideRow(intRow);
    } else
      colog("error!");

    return strSymbol;
  }

  String symbolAtHideRow(int intIndex) {
    String result;
    int intHideIndex = intIndex;

    if (intHideIndex >= 0) {
      result = symbolStringAtRow(intHideIndex, placeFirstEasy());
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
        String symbolDes =
            strSymbol.substring(strSymbol.length - 4, strSymbol.length);
        int nValue = _inputEasyModel.digitAtIndex(intIndex);
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

  String symbolAtToRow(int intIndex) {
    String stringResult;
    if (0 <= intIndex && intIndex <= 5) {
      String fromEasyElement = eightDiagrams().elementOfEasy(fromEasyName());
      Map toDict = toEasyDictionary();
      if (null != toDict) {
        String toSymbol = symbolStringAtRow(intIndex, toDict);
        String toElement = symbolElement(toSymbol);

        String strValue =
            SABElementModel.elementRelative(fromEasyElement, toElement);
        stringResult = toSymbol.replaceRange(toSymbol.length - 4, 2, strValue);
      }
      //else cont.
    }
    //else cont.

    return stringResult;
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
    return symbolAtRow(_goalIndex(), EasyTypeEnum.from);
  }

  int _goalIndex() {
    Map fromDict = fromEasyDictionary();
    int yingIndex = fromDict["应"];
    return 6 - yingIndex;
  }

  /// `此模块包含提取爻信息的方法`///////////////////////////////////////////////////
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
      stringResult = symbol.substring(symbol.length - 1, symbol.length);
    else
      colog("");

    return stringResult;
  }

  String symbolParent(String stringSymbol) {
    String stringResult = "";

    if (stringSymbol.length >= 4)
      stringResult = stringSymbol.substring(
          stringSymbol.length - 4, stringSymbol.length - 2);
    else
      colog("");

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
      stringResult = stringSymbol.substring(
          stringSymbol.length - 2, stringSymbol.length - 1);
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

  SABEasyWordsModel outEasyWordsModel() {
    if (null == _outEasyWordsModel) {
      _outEasyWordsModel = SABEasyWordsModel(_inputEasyModel);

      _outEasyWordsModel.stringDayEarth = dayEarth();
      _outEasyWordsModel.stringMonthEarth = monthEarth();
      _outEasyWordsModel.stringDaySky = daySky();
      _outEasyWordsModel.stringMonthSky = monthSky();

      _outEasyWordsModel.mapFromEasy = fromEasyDictionary();
      _outEasyWordsModel.mapToEasy = toEasyDictionary();
      _outEasyWordsModel.mapHideEasy = placeFirstEasy();

      _outEasyWordsModel.intLifeIndex = getLifeIndex();
      _outEasyWordsModel.intGoalIndex = _goalIndex();
      _outEasyWordsModel.stringFromName = fromEasyName();
      _outEasyWordsModel.stringToName = toEasyName();
      _outEasyWordsModel.stringFromElement =
          eightDiagrams().elementOfEasy(fromEasyName());
      _outEasyWordsModel.stringToElement =
          eightDiagrams().elementOfEasy(toEasyName());

      _outEasyWordsModel.stringFromPlace =
          eightDiagrams().easyPlaceByName(fromEasyName());

      _outEasyWordsModel.stringToPlace =
          eightDiagrams().easyPlaceByName(toEasyName());

      _outEasyWordsModel.bFromPureEasy =
          0 == lifeIndexAtEasy(fromEasyDictionary());

      _outEasyWordsModel.bToPureEasy = 0 == lifeIndexAtEasy(toEasyDictionary());

      for (int intRow = 0; intRow < 6; intRow++) {
        _outEasyWordsModel.setDigit(
            intRow, _inputEasyModel.digitAtIndex(intRow));
        _outEasyWordsModel.setMovement(
            intRow, _inputEasyModel.isMovementAtRow(intRow));

        String symbolFrom = symbolAtFromRow(intRow);
        _outEasyWordsModel.setFromSymbolName(intRow, symbolFrom);
        _outEasyWordsModel.setFromParent(intRow, symbolParent(symbolFrom));
        _outEasyWordsModel.setFromEarth(intRow, symbolEarth(symbolFrom));
        _outEasyWordsModel.setFromElement(intRow, symbolElement(symbolFrom));

        String symbolTo = symbolAtToRow(intRow);
        _outEasyWordsModel.setToSymbolName(intRow, symbolTo);
        _outEasyWordsModel.setToParent(intRow, symbolParent(symbolTo));
        _outEasyWordsModel.setToEarth(intRow, symbolEarth(symbolTo));
        _outEasyWordsModel.setToElement(intRow, symbolElement(symbolTo));

        String symbolHide = symbolAtHideRow(intRow);
        _outEasyWordsModel.setHideSymbolName(intRow, symbolHide);
        _outEasyWordsModel.setHideParent(intRow, symbolParent(symbolHide));
        _outEasyWordsModel.setHideEarth(intRow, symbolEarth(symbolHide));
        _outEasyWordsModel.setHideElement(intRow, symbolElement(symbolHide));
      }
    }
    return _outEasyWordsModel;
  }
}
