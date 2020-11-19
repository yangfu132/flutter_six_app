import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyWordsModel.dart';
import 'SABSymbolLogicModel.dart';

class SABEasyLogicModel {
  SABEasyLogicModel(this.inputWordsModel);
  final SABEasyWordsModel inputWordsModel;

  List _listSymbols;

  bool isStaticEasy;

  bool _isFromEasySixPair;
  bool _isToEasySixPair;
  bool _isHideEasySixPair;
  bool _isFromEasySixConflict;
  bool _isToEasySixConflict;
  bool _isHideEasySixConflict;

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
      bResult = _isFromEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = _isToEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = _isHideEasySixPair;
    } else {
      colog("error!");
    }
    return bResult;
  }

  void setIsEasySixPair(EasyTypeEnum enumEasyType, bool bEasySixPair) {
    if (enumEasyType == EasyTypeEnum.from) {
      _isFromEasySixPair = bEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      _isToEasySixPair = bEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      _isHideEasySixPair = bEasySixPair;
    } else {
      colog("error!");
    }
  }

  bool isEasySixConflict(EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = _isFromEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = _isToEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = _isHideEasySixConflict;
    } else {
      colog("error!");
    }
    return bResult;
  }

  void setIsEasySixConflict(EasyTypeEnum enumEasyType, bool bEasySixConflict) {
    if (enumEasyType == EasyTypeEnum.from) {
      _isFromEasySixConflict = bEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.to) {
      _isToEasySixConflict = bEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      _isHideEasySixConflict = bEasySixConflict;
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

  void setIsMonthPair(int intRow, EasyTypeEnum easyTypeEnum, bool isMonthPair) {
    symbolAtRow(intRow).setIsMonthPair(easyTypeEnum, isMonthPair);
  }

  bool isMonthPair(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsMonthPair(easyTypeEnum);
  }

  void setIsDayPair(int intRow, EasyTypeEnum easyTypeEnum, bool isDayPair) {
    symbolAtRow(intRow).setIsDayPair(easyTypeEnum, isDayPair);
  }

  bool isDayPair(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsDayPair(easyTypeEnum);
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
