import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyWordsModel.dart';
import 'SABSymbolLogicModel.dart';

class SABEasyLogicModel {
  SABEasyLogicModel(this.inputWordsModel);
  final SABEasyWordsModel inputWordsModel;

  List _listSymbols;

  bool isStaticEasy;

  bool isFromEasySixPair;
  bool isToEasySixPair;
  bool isHideEasySixPair;

  List arrayRightMove;
  List arrayFromSeasonStrong;
  List arrayToSeasonStrong;
  List arrayHideSeasonStrong;

  /// `Public`//////////////////////////////////////////////////////////////
  bool isSymbolSeasonStrong(int intRow, EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = -1 != arrayFromSeasonStrong.indexOf(intRow);
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = -1 != arrayFromSeasonStrong.indexOf(intRow);
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = -1 != arrayFromSeasonStrong.indexOf(intRow);
    } else {
      colog("error!");
    }
    return bResult;
  }

  bool isEasySixPair(EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = isFromEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = isToEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = isHideEasySixPair;
    } else {
      colog("error!");
    }
    return bResult;
  }

  void setIsEasySixPair(EasyTypeEnum enumEasyType, bool isEasySixPair) {
    if (enumEasyType == EasyTypeEnum.from) {
      isFromEasySixPair = isEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      isToEasySixPair = isEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      isHideEasySixPair = isEasySixPair;
    } else {
      colog("error!");
    }
  }

  String getSmbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).inputWordsSymbol.getSmbolEarth(easyTypeEnum);
  }

  bool isMovementAtRow(int intRow) {
    return inputWordsModel.isMovementAtRow(intRow);
  }

  /// `Get & Set`//////////////////////////////////////////////////////////////

  void setIsOnMonth(int intRow, EasyTypeEnum easyTypeEnum, bool isOnMonth) {
    symbolAtRow(intRow).setIsOnMonth(easyTypeEnum, isOnMonth);
  }

  bool isOnMonth(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsOnMonth(easyTypeEnum);
  }

  void setIsOnDay(int intRow, EasyTypeEnum easyTypeEnum, bool isOnMonth) {
    symbolAtRow(intRow).setIsOnDay(easyTypeEnum, isOnMonth);
  }

  bool isOnDay(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsOnDay(easyTypeEnum);
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        SABSymbolLogicModel model =
            SABSymbolLogicModel(inputWordsModel.symbolAtRow(intRow));
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolLogicModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }
}
