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
      strSymbol = model.symbolFrom['name'];
    } else if (enumEasyType == EasyTypeEnum.to) {
      strSymbol = model.symbolTo['name'];
    } else if (enumEasyType == EasyTypeEnum.hide) {
      strSymbol = model.symbolHide['name'];
    } else {
      colog("error!");
    }
    return strSymbol;
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
    model.symbolFrom['name'] = stringSymbol;
    model.symbolFrom['parent'] = '';
    model.symbolFrom['earth'] = '';
    model.symbolFrom['element'] = '';
  }

  void setToSymbol(int intRow, String stringSymbol) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.symbolTo['name'] = stringSymbol;
    model.symbolTo['parent'] = '';
    model.symbolTo['earth'] = '';
    model.symbolTo['element'] = '';
  }

  void setHideSymbol(int intRow, String stringSymbol) {
    SABSymbolWordsModel model = symbolsArray()[intRow];
    model.symbolHide['name'] = stringSymbol;
    model.symbolHide['parent'] = '';
    model.symbolHide['earth'] = '';
    model.symbolHide['element'] = '';
  }
}
