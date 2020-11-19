import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import 'SABSymbolWordsModel.dart';

class SABEasyWordsModel {
  String stringDayEarth;
  String stringDaySky;
  String stringMonthSky;
  String stringMonthEarth;

  List arrayMovement;
  List _listSymbols;

  String symbolAtRow(int intRow, EasyTypeEnum enumEasyType) {
    String strSymbol = '';
    SABSymbolWordsModel model = symbolsArray()[intRow];
    if (enumEasyType == EasyTypeEnum.from) {
      strSymbol = model.mapSymbolFrom['name'];
    } else if (enumEasyType == EasyTypeEnum.to) {
      strSymbol = model.mapSymbolTo['name'];
    } else if (enumEasyType == EasyTypeEnum.hide) {
      strSymbol = model.mapSymbolHide['name'];
    } else {
      colog("error!");
    }
    return strSymbol;
  }

  List symbolsArray() {
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

  void setDigit(int intRow, int intDigit) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.intDigit = intDigit;
  }

  int getDigit(int intRow) {
    return symbolsArray()[intRow].intDigit;
  }

  void setMovement(int intRow, bool bMovement) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.bMovement = bMovement;
  }

  bool isMovementAtRow(int intRow) {
    return symbolsArray()[intRow].bMovement;
  }

  String getSmbolName(EasyTypeEnum easyTypeEnum, int intRow) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return symbolsArray()[intRow].mapSymbolFrom['name'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return symbolsArray()[intRow].mapSymbolTo['name'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return symbolsArray()[intRow].mapSymbolHide['name'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolParent(EasyTypeEnum easyTypeEnum, int intRow) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return symbolsArray()[intRow].mapSymbolFrom['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return symbolsArray()[intRow].mapSymbolTo['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return symbolsArray()[intRow].mapSymbolHide['parent'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolEarth(EasyTypeEnum easyTypeEnum, int intRow) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return symbolsArray()[intRow].mapSymbolFrom['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return symbolsArray()[intRow].mapSymbolTo['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return symbolsArray()[intRow].mapSymbolHide['earth'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolElement(int intRow, EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return symbolsArray()[intRow].mapSymbolFrom['element'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return symbolsArray()[intRow].mapSymbolTo['element'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return symbolsArray()[intRow].mapSymbolHide['element'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  void setFromSymbol(int intRow, String stringSymbol) {
    symbolsArray()[intRow].mapSymbolFrom['name'] = stringSymbol;
  }

  void setFromParent(int intRow, String stringParnet) {
    symbolsArray()[intRow].mapSymbolFrom['parent'] = stringParnet;
  }

  void setFromEarth(int intRow, String stringEarth) {
    symbolsArray()[intRow].mapSymbolFrom['earth'] = stringEarth;
  }

  void setFromElement(int intRow, String stringElement) {
    symbolsArray()[intRow].mapSymbolFrom['element'] = stringElement;
  }

  void setToSymbol(int intRow, String stringSymbol) {
    symbolsArray()[intRow].mapSymbolTo['name'] = stringSymbol;
  }

  void setToParent(int intRow, String stringParnet) {
    symbolsArray()[intRow].mapSymbolTo['parent'] = stringParnet;
  }

  void setToEarth(int intRow, String stringEarth) {
    symbolsArray()[intRow].mapSymbolTo['earth'] = stringEarth;
  }

  void setToElement(int intRow, String stringElement) {
    symbolsArray()[intRow].mapSymbolTo['element'] = stringElement;
  }

  void setHideSymbol(int intRow, String stringSymbol) {
    symbolsArray()[intRow].mapSymbolHide['name'] = stringSymbol;
  }

  void setHideParent(int intRow, String stringParnet) {
    symbolsArray()[intRow].mapSymbolHide['parent'] = stringParnet;
  }

  void setHideEarth(int intRow, String stringEarth) {
    symbolsArray()[intRow].mapSymbolHide['earth'] = stringEarth;
  }

  void setHideElement(int intRow, String stringElement) {
    symbolsArray()[intRow].mapSymbolHide['element'] = stringElement;
  }
}
