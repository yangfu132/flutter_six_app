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

  String symbolEarth(String stringSymbol) {
    String stringResult = "";
    if (stringSymbol.length >= 2)
      stringResult = stringSymbol.substring(
          stringSymbol.length - 2, stringSymbol.length - 1);
    else
      stringResult = "卦中用神未现"; //colog("error!");

    return stringResult;
  }

  bool isMovementAtRow(int nRow) {
    return -1 != arrayMovement.indexOf(nRow);
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

  void setMovement(int intRow, bool bMovement) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.bMovement = bMovement;
  }

  void setFromSymbol(int intRow, String stringSymbol) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.mapSymbolFrom['name'] = stringSymbol;
    model.mapSymbolFrom['parent'] = symbolParent(stringSymbol);
    model.mapSymbolFrom['earth'] = symbolEarth(stringSymbol);
    model.mapSymbolFrom['element'] = symbolElement(stringSymbol);
  }

  void setToSymbol(int intRow, String stringSymbol) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.mapSymbolTo['name'] = stringSymbol;
    model.mapSymbolTo['parent'] = symbolParent(stringSymbol);
    model.mapSymbolTo['earth'] = symbolEarth(stringSymbol);
    model.mapSymbolTo['element'] = symbolElement(stringSymbol);
  }

  void setHideSymbol(int intRow, String stringSymbol) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.mapSymbolHide['name'] = stringSymbol;
    model.mapSymbolHide['parent'] = symbolParent(stringSymbol);
    model.mapSymbolHide['earth'] = symbolEarth(stringSymbol);
    model.mapSymbolHide['element'] = symbolElement(stringSymbol);
  }
}
