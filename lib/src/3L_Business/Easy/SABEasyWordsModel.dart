import 'package:flutter_six_app/src/1L_Context/SACContext.dart';

import '../../1L_Context/SACGlobal.dart';
import 'SABEasyDigitModel.dart';
import 'SABSymbolWordsModel.dart';

class SABEasyWordsModel {
  final SABEasyDigitModel inputDigitModel;
  SABEasyWordsModel(this.inputDigitModel);
  List _listSymbols;

  ///时间
  String stringFormatTime;
  String stringDayEarth;
  String stringDaySky;
  String stringMonthSky;
  String stringMonthEarth;

  int _intLifeIndex;
  int _intGoalIndex;
  String stringFromName;
  String stringFromPlace;
  String stringFromElement;
  String stringToName;
  String stringToPlace;
  String stringToElement;

  Map mapFromEasy;
  Map mapToEasy;
  Map mapHideEasy;

  ///纯卦
  bool bFromPureEasy;
  bool bToPureEasy;

  /// `MergeRow函数`///////////////////////////////////////////////////////////
  ///MergeRow的定义
  ///from:0~6
  ///Month:7
  ///Day:8
  ///Fly:10~16
  ///To:20~26
  String symbolNameAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSymbolName(intRow, EasyTypeEnum.from);
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      stringResult = getSymbolName(intRow - ROW_CHNAGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = getSymbolName(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  EasyTypeEnum easyTypeOfMergeRow(int intRow) {
    EasyTypeEnum enumResultType = EasyTypeEnum.type_null;
    if (0 <= intRow && intRow < 6) {
      enumResultType = EasyTypeEnum.from;
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      enumResultType = EasyTypeEnum.to;
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      enumResultType = EasyTypeEnum.hide;
    }
    //else cont.

    return enumResultType;
  }

  int rowOfMergeRow(int intRow) {
    int intResultRow = -1;
    if (0 <= intRow && intRow < 6) {
      intResultRow = intRow;
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      intResultRow = intRow - ROW_CHNAGE_BEGIN;
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      intResultRow = intRow - ROW_FLY_BEGIN;
    }
    //else cont.

    return intResultRow;
  }

  String earthAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSymbolEarth(intRow, EasyTypeEnum.from);
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      stringResult = getSymbolEarth(intRow - ROW_CHNAGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = getSymbolEarth(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  List earthAtMergeRowArray(List arrayRow) {
    List arrayEarth = [];

    for (int intItem in arrayRow) {
      arrayEarth.add(earthAtMergeRow(intItem));
    } //endf

    return arrayEarth;
  }

  /// `Get & Set函数`///////////////////////////////////////////////////////////
  void setLifeIndex(int intRow) {
    this._intLifeIndex = intRow;
    symbolAtRow(intRow).desOfGoalOrLife = "世";
  }

  int getLifeIndex() {
    return this._intLifeIndex;
  }

  void setGoalIndex(int intRow) {
    this._intGoalIndex = intRow;
    symbolAtRow(intRow).desOfGoalOrLife = "应";
  }

  int getGoalIndex() {
    return this._intGoalIndex;
  }

  void setDigit(int intRow, int intDigit) {
    symbolAtRow(intRow).intDigit = intDigit;
  }

  int getDigit(int intRow) {
    return symbolAtRow(intRow).intDigit;
  }

  void setAnimal(int intRow, String stringAnimal) {
    symbolAtRow(intRow).stringAnimal = stringAnimal;
  }

  String getAnimal(int intRow) {
    return symbolAtRow(intRow).stringAnimal;
  }

  void setMovement(int intRow, bool bMovement) {
    symbolAtRow(intRow).bMovement = bMovement;
  }

  ///此函数用于判断当前爻是否为动爻
  bool isMovementAtRow(int intMergeRow) {
    bool bResult = false;
    int rowInEasy = rowOfMergeRow(intMergeRow);
    if (0 <= rowInEasy && 6 >= rowInEasy)
      bResult = symbolAtRow(rowInEasy).bMovement;
    else if (ROW_MONTH == intMergeRow || ROW_DAY == intMergeRow)
      print('日月为用神');
    else
      colog('error');
    return bResult;
  }

  String getSymbolName(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getSymbolName(easyTypeEnum);
  }

  String getSmbolParent(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getSmbolParent(easyTypeEnum);
  }

  String getSymbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getSymbolEarth(easyTypeEnum);
  }

  String getSmbolElement(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getSmbolElement(easyTypeEnum);
  }

  void setFromSymbolName(int intRow, String stringSymbol) {
    if (null != stringSymbol) {
      symbolAtRow(intRow).mapSymbolFrom['name'] = stringSymbol;
    } else
      colog('error');
  }

  void setFromParent(int intRow, String stringParnet) {
    if (null != stringParnet) {
      symbolAtRow(intRow).mapSymbolFrom['parent'] = stringParnet;
    } else
      colog('error');
  }

  void setFromEarth(int intRow, String stringEarth) {
    if (null != stringEarth) {
      symbolAtRow(intRow).mapSymbolFrom['earth'] = stringEarth;
    } else
      colog('error');
  }

  void setFromElement(int intRow, String stringElement) {
    if (null != stringElement) {
      symbolAtRow(intRow).mapSymbolFrom['element'] = stringElement;
    } else
      colog('error');
  }

  void setToSymbolName(int intRow, String stringSymbol) {
    if (null != stringSymbol) {
      symbolAtRow(intRow).mapSymbolTo['name'] = stringSymbol;
    } else
      colog('error');
  }

  void setToParent(int intRow, String stringParnet) {
    if (null != stringParnet) {
      symbolAtRow(intRow).mapSymbolTo['parent'] = stringParnet;
    } else
      colog('error');
  }

  void setToEarth(int intRow, String stringEarth) {
    if (null != stringEarth) {
      symbolAtRow(intRow).mapSymbolTo['earth'] = stringEarth;
    } else
      colog('error');
  }

  void setToElement(int intRow, String stringElement) {
    if (null != stringElement) {
      symbolAtRow(intRow).mapSymbolTo['element'] = stringElement;
    } else
      colog('error');
  }

  void setHideSymbolName(int intRow, String stringSymbol) {
    if (null != stringSymbol) {
      symbolAtRow(intRow).mapSymbolHide['name'] = stringSymbol;
    } else
      colog('error');
  }

  void setHideParent(int intRow, String stringParnet) {
    if (null != stringParnet) {
      symbolAtRow(intRow).mapSymbolHide['parent'] = stringParnet;
    } else
      colog('error');
  }

  void setHideEarth(int intRow, String stringEarth) {
    if (null != stringEarth) {
      symbolAtRow(intRow).mapSymbolHide['earth'] = stringEarth;
    } else
      colog('error');
  }

  void setHideElement(int intRow, String stringElement) {
    if (null != stringElement) {
      symbolAtRow(intRow).mapSymbolHide['element'] = stringElement;
    } else
      colog('error');
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        SABSymbolWordsModel model = SABSymbolWordsModel();
        model.intRow = intRow;
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolWordsModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }

  /// `桥函数`/////////////////////////////////////////////////////////////////
  ///此函数获取内卦变动的爻列表
  List inGuaMovementArray() {
    return inputDigitModel.inGuaMovementArray();
  }

  ///此函数获取外卦变动的爻列表
  List outGuaMovementArray() {
    return inputDigitModel.outGuaMovementArray();
  }
}
