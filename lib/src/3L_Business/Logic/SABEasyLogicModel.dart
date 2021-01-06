import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyWordsModel.dart';
import 'SABSymbolLogicModel.dart';
import '../EarthBranch/SABEarthBranchModel.dart';

class SABEasyLogicModel {
  SABEasyLogicModel(this.inputWordsModel);
  final SABEasyWordsModel inputWordsModel;
  SABEarthBranchModel _earthBranchModel;
  List listStaticSeasonStrong;
  List _listSymbols;

  bool bStaticEasy;

  bool _bFromEasySixPair;
  bool _bToEasySixPair;
  bool _bHideEasySixPair;

  bool _bFromEasySixConflict;
  bool _bToEasySixConflict;
  bool _bHideEasySixConflict;

  /// `Public`//////////////////////////////////////////////////////////////

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

  String getSymbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).inputWordsSymbol.getSymbolEarth(easyTypeEnum);
  }

  bool isMovementAtRow(int intRow) {
    return inputWordsModel.isMovementAtRow(intRow);
  }

  /// `Get & Set`//////////////////////////////////////////////////////////////
  ///

  EmptyEnum getSymbolEmptyState(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getSymbolEmptyState(easyTypeEnum);
  }

  void setSymbolEmptyState(
      int intRow, EasyTypeEnum easyTypeEnum, EmptyEnum symbolEmptyState) {
    symbolAtRow(intRow).setSymbolEmptyState(easyTypeEnum, symbolEmptyState);
  }

  bool getIsSymbolBackMove(int intRow) {
    return symbolAtRow(intRow).isSymbolBackMove;
  }

  void setIsSymbolBackMove(int intRow, bool bSymbolBackMove) {
    symbolAtRow(intRow).isSymbolBackMove = bSymbolBackMove;
  }

  bool getIsSymbolChangeEmpty(int intRow) {
    return symbolAtRow(intRow).isSymbolChangeEmpty;
  }

  void setIsSymbolChangeEmpty(int intRow, bool bSymbolChangeEmpty) {
    symbolAtRow(intRow).isSymbolChangeEmpty = bSymbolChangeEmpty;
  }

  String getSymbolForwardOrBack(int intRow) {
    return symbolAtRow(intRow).stringSymbolForwardOrBack;
  }

  void setSymbolForwardOrBack(int intRow, String stringForwardOrBack) {
    symbolAtRow(intRow).stringSymbolForwardOrBack = stringForwardOrBack;
  }

  bool getIsSymbolChangeBorn(int intRow) {
    return symbolAtRow(intRow).isSymbolChangeBorn;
  }

  void setIsSymbolChangeBorn(int intRow, bool bSymbolChangeBorn) {
    symbolAtRow(intRow).isSymbolChangeBorn = bSymbolChangeBorn;
  }

  bool getIsSymbolChangeRestrict(int intRow) {
    return symbolAtRow(intRow).isSymbolChangeRestrict;
  }

  void setIsSymbolChangeRestrict(int intRow, bool bSymbolChangeRestrict) {
    symbolAtRow(intRow).isSymbolChangeRestrict = bSymbolChangeRestrict;
  }

  bool getIsSymbolChangeConflict(int intRow) {
    return symbolAtRow(intRow).isSymbolChangeConflict;
  }

  void setIsSymbolChangeConflict(int intRow, bool bSymbolChangeConflict) {
    symbolAtRow(intRow).isSymbolChangeConflict = bSymbolChangeConflict;
  }

  String getDiety(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getDiety(easyTypeEnum);
  }

  void setDiety(int intRow, EasyTypeEnum easyTypeEnum, String stringDeity) {
    symbolAtRow(intRow).setDiety(easyTypeEnum, stringDeity);
  }

  bool isEffectable(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsEffectable(easyTypeEnum);
  }

  void setIsEffectable(
      int intRow, EasyTypeEnum easyTypeEnum, bool bSeasonStrong) {
    symbolAtRow(intRow).setIsEffectable(easyTypeEnum, bSeasonStrong);
  }

  bool getIsSymbolDayBroken(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsSymbolDayBroken(easyTypeEnum);
  }

  void setIsSymbolDayBroken(
      int intRow, EasyTypeEnum easyTypeEnum, bool bSymbolDayBroken) {
    symbolAtRow(intRow).setIsSymbolDayBroken(easyTypeEnum, bSymbolDayBroken);
  }

  bool isSeasonStrong(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getIsSeasonStrong(easyTypeEnum);
  }

  void setIsSeasonStrong(
      int intRow, EasyTypeEnum easyTypeEnum, bool bSeasonStrong) {
    symbolAtRow(intRow).setIsSeasonStrong(easyTypeEnum, bSeasonStrong);
  }

  MonthConflictEnum getConflictOnMonthState(
      int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getConflictOnMonthState(easyTypeEnum);
  }

  void setConflictOnMonthState(int intRow, EasyTypeEnum easyTypeEnum,
      MonthConflictEnum enumResultConflict) {
    symbolAtRow(intRow)
        .setConflictOnMonthState(easyTypeEnum, enumResultConflict);
  }

  DayConflictEnum getConflictOnDayState(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getConflictOnDayState(easyTypeEnum);
  }

  void setConflictOnDayState(int intRow, EasyTypeEnum easyTypeEnum,
      DayConflictEnum enumResultConflict) {
    symbolAtRow(intRow).setConflictOnDayState(easyTypeEnum, enumResultConflict);
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

  SABEarthBranchModel earthBranchModel() {
    if (null == _earthBranchModel) {
      _earthBranchModel = SABEarthBranchModel();
    }
    return _earthBranchModel;
  }
}
