import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyWordsModel.dart';
import 'SABSymbolLogicModel.dart';

class SABEasyLogicModel {
  SABEasyLogicModel(this.inputWordsModel);
  final SABEasyWordsModel inputWordsModel;

  List _listSymbols;

  bool bStaticEasy;

  bool _bFromEasySixPair;
  bool _bToEasySixPair;
  bool _bHideEasySixPair;
  bool _bFromEasySixConflict;
  bool _bToEasySixConflict;
  bool _bHideEasySixConflict;

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
      bResult = _bFromEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = _bToEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = _bHideEasySixPair;
    } else {
      colog("error!");
    }
    return bResult;
  }

  void setIsEasySixPair(EasyTypeEnum enumEasyType, bool bEasySixPair) {
    if (enumEasyType == EasyTypeEnum.from) {
      _bFromEasySixPair = bEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.to) {
      _bToEasySixPair = bEasySixPair;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      _bHideEasySixPair = bEasySixPair;
    } else {
      colog("error!");
    }
  }

  bool isEasySixConflict(EasyTypeEnum enumEasyType) {
    bool bResult = false;
    if (enumEasyType == EasyTypeEnum.from) {
      bResult = _bFromEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.to) {
      bResult = _bToEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      bResult = _bHideEasySixConflict;
    } else {
      colog("error!");
    }
    return bResult;
  }

  void setIsEasySixConflict(EasyTypeEnum enumEasyType, bool bEasySixConflict) {
    if (enumEasyType == EasyTypeEnum.from) {
      _bFromEasySixConflict = bEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.to) {
      _bToEasySixConflict = bEasySixConflict;
    } else if (enumEasyType == EasyTypeEnum.hide) {
      _bHideEasySixConflict = bEasySixConflict;
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

  MonthConflictEnum getConflictOnMonthState(
      int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getConflictOnMonthState(easyTypeEnum);
  }

  void setConflictOnMonthState(int intRow, EasyTypeEnum easyTypeEnum,
      MonthConflictEnum enumResultConflict) {
    symbolAtRow(intRow)
        .setConflictOnMonthState(easyTypeEnum, enumResultConflict);
  }

  EmptyEnum getBasicEmptyState(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getBasicEmptyState(easyTypeEnum);
  }

  void setBasicEmptyState(
      int intRow, EasyTypeEnum easyTypeEnum, EmptyEnum enumResultEmpty) {
    symbolAtRow(intRow).setBasicEmptyState(easyTypeEnum, enumResultEmpty);
  }

  bool isOnMonth(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsOnMonth(easyTypeEnum);
  }

  void setIsOnMonth(int intRow, EasyTypeEnum easyTypeEnum, bool bOnMonth) {
    symbolAtRow(intRow).setIsOnMonth(easyTypeEnum, bOnMonth);
  }

  bool isOnDay(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsOnDay(easyTypeEnum);
  }

  void setIsOnDay(int intRow, EasyTypeEnum easyTypeEnum, bool bOnMonth) {
    symbolAtRow(intRow).setIsOnDay(easyTypeEnum, bOnMonth);
  }

  bool isMonthPair(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsMonthPair(easyTypeEnum);
  }

  void setIsMonthPair(int intRow, EasyTypeEnum easyTypeEnum, bool bMonthPair) {
    symbolAtRow(intRow).setIsMonthPair(easyTypeEnum, bMonthPair);
  }

  bool isDayPair(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsDayPair(easyTypeEnum);
  }

  void setIsDayPair(int intRow, EasyTypeEnum easyTypeEnum, bool bDayPair) {
    symbolAtRow(intRow).setIsDayPair(easyTypeEnum, bDayPair);
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
