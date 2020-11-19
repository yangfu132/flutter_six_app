import '../../1L_Context/SACGlobal.dart';
import 'SABSymbolWordsModel.dart';
import 'SABEasyDigitModel.dart';

class SABEasyWordsModel {
  final SABEasyDigitModel inputDigitModel;
  SABEasyWordsModel(this.inputDigitModel);

  String stringDayEarth;
  String stringDaySky;
  String stringMonthSky;
  String stringMonthEarth;
  String stringFromName;
  String stringToName;
  int intLifeIndex;
  int intGoalIndex;

  List arrayMovement;
  List _listSymbols;

  /// `Get & Set函数`///////////////////////////////////////////////////////////
  ///MergeRow的定义
  ///from:0~6
  ///Month:7
  ///Day:8
  ///Fly:10~16
  ///To:20~26
  String symbolAtMergeRow(int intRow) {
    String stringResult = "";
    if (0 <= intRow && intRow < 6) {
      stringResult = getSmbolName(intRow, EasyTypeEnum.from);
    } else if (ROW_CHNAGE_BEGIN <= intRow && intRow < ROW_CHNAGE_END) {
      stringResult = getSmbolName(intRow - ROW_CHNAGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= intRow && intRow < ROW_FLY_END) {
      stringResult = getSmbolName(intRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return stringResult;
  }

  void setDigit(int intRow, int intDigit) {
    SABSymbolWordsModel model = _symbolsArray()[intRow];
    model.intDigit = intDigit;
  }

  int getDigit(int intRow) {
    return _symbolsArray()[intRow].intDigit;
  }

  void setMovement(int intRow, bool bMovement) {
    SABSymbolWordsModel model = _symbolsArray()[intRow];
    model.bMovement = bMovement;
  }

  ///此函数用于判断当前爻是否为动爻
  bool isMovementAtRow(int intRow) {
    return _symbolsArray()[intRow].bMovement;
  }

  String getSmbolName(int intRow, EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return _symbolsArray()[intRow].mapSymbolFrom['name'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return _symbolsArray()[intRow].mapSymbolTo['name'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return _symbolsArray()[intRow].mapSymbolHide['name'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolParent(int intRow, EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return _symbolsArray()[intRow].mapSymbolFrom['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return _symbolsArray()[intRow].mapSymbolTo['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return _symbolsArray()[intRow].mapSymbolHide['parent'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return _symbolsArray()[intRow].mapSymbolFrom['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return _symbolsArray()[intRow].mapSymbolTo['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return _symbolsArray()[intRow].mapSymbolHide['earth'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolElement(int intRow, EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return _symbolsArray()[intRow].mapSymbolFrom['element'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return _symbolsArray()[intRow].mapSymbolTo['element'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return _symbolsArray()[intRow].mapSymbolHide['element'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  void setFromSymbol(int intRow, String stringSymbol) {
    _symbolsArray()[intRow].mapSymbolFrom['name'] = stringSymbol;
  }

  void setFromParent(int intRow, String stringParnet) {
    _symbolsArray()[intRow].mapSymbolFrom['parent'] = stringParnet;
  }

  void setFromEarth(int intRow, String stringEarth) {
    _symbolsArray()[intRow].mapSymbolFrom['earth'] = stringEarth;
  }

  void setFromElement(int intRow, String stringElement) {
    _symbolsArray()[intRow].mapSymbolFrom['element'] = stringElement;
  }

  void setToSymbol(int intRow, String stringSymbol) {
    _symbolsArray()[intRow].mapSymbolTo['name'] = stringSymbol;
  }

  void setToParent(int intRow, String stringParnet) {
    _symbolsArray()[intRow].mapSymbolTo['parent'] = stringParnet;
  }

  void setToEarth(int intRow, String stringEarth) {
    _symbolsArray()[intRow].mapSymbolTo['earth'] = stringEarth;
  }

  void setToElement(int intRow, String stringElement) {
    _symbolsArray()[intRow].mapSymbolTo['element'] = stringElement;
  }

  void setHideSymbol(int intRow, String stringSymbol) {
    _symbolsArray()[intRow].mapSymbolHide['name'] = stringSymbol;
  }

  void setHideParent(int intRow, String stringParnet) {
    _symbolsArray()[intRow].mapSymbolHide['parent'] = stringParnet;
  }

  void setHideEarth(int intRow, String stringEarth) {
    _symbolsArray()[intRow].mapSymbolHide['earth'] = stringEarth;
  }

  void setHideElement(int intRow, String stringElement) {
    _symbolsArray()[intRow].mapSymbolHide['element'] = stringElement;
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
