import '../Easy/SABSymbolWordsModel.dart';
import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABSymbolLogicModel {
  final SABSymbolWordsModel inputWordsSymbol;
  SABSymbolLogicModel(this.inputWordsSymbol);

  ///{
  ///'isOnMonth'
  ///'isOnDay'
  ///'isDayPair'
  ///'isMonthPair'
  ///'basicEmptyState'
  ///'conflictOnMonthState'
  ///'isSeasonStrong'
  ///}
  Map mapSymbolFrom = {};
  Map mapSymbolTo = {};
  Map mapSymbolHide = {};

  bool getIsSeasonStrong(EasyTypeEnum easyTypeEnum) {
    bool bResultStrong = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultStrong = mapSymbolFrom['isSeasonStrong'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultStrong = mapSymbolTo['isSeasonStrong'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultStrong = mapSymbolHide['isSeasonStrong'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultStrong;
  }

  void setIsSeasonStrong(EasyTypeEnum easyTypeEnum, bool bSeasonStrong) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isSeasonStrong'] = bSeasonStrong;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isSeasonStrong'] = bSeasonStrong;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isSeasonStrong'] = bSeasonStrong;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  MonthConflictEnum getConflictOnMonthState(EasyTypeEnum easyTypeEnum) {
    MonthConflictEnum enumResultConflict = MonthConflictEnum.Conflict_Null;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultConflict = mapSymbolFrom['conflictOnMonthState'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultConflict = mapSymbolTo['conflictOnMonthState'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultConflict = mapSymbolHide['conflictOnMonthState'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return enumResultConflict;
  }

  void setConflictOnMonthState(
      EasyTypeEnum easyTypeEnum, MonthConflictEnum enumResultConflict) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['conflictOnMonthState'] = enumResultConflict;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['conflictOnMonthState'] = enumResultConflict;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['conflictOnMonthState'] = enumResultConflict;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  EmptyEnum getBasicEmptyState(EasyTypeEnum easyTypeEnum) {
    EmptyEnum enumResultEmpty = EmptyEnum.Empty_Null;
    if (easyTypeEnum == EasyTypeEnum.from) {
      enumResultEmpty = mapSymbolFrom['basicEmptyState'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      enumResultEmpty = mapSymbolTo['basicEmptyState'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      enumResultEmpty = mapSymbolHide['basicEmptyState'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return enumResultEmpty;
  }

  void setBasicEmptyState(
      EasyTypeEnum easyTypeEnum, EmptyEnum enumResultEmpty) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['basicEmptyState'] = enumResultEmpty;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['basicEmptyState'] = enumResultEmpty;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['basicEmptyState'] = enumResultEmpty;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  bool getIsMonthPair(EasyTypeEnum easyTypeEnum) {
    bool bResultIsMonthPair = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsMonthPair = mapSymbolFrom['isMonthPair'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsMonthPair = mapSymbolTo['isMonthPair'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsMonthPair = mapSymbolHide['isMonthPair'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsMonthPair;
  }

  void setIsMonthPair(EasyTypeEnum easyTypeEnum, bool bMonthPair) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isMonthPair'] = bMonthPair;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isMonthPair'] = bMonthPair;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isMonthPair'] = bMonthPair;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  bool getIsOnMonth(EasyTypeEnum easyTypeEnum) {
    bool bResultIsOnMonth = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsOnMonth = mapSymbolFrom['isOnMonth'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsOnMonth = mapSymbolTo['isOnMonth'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsOnMonth = mapSymbolHide['isOnMonth'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsOnMonth;
  }

  void setIsOnMonth(EasyTypeEnum easyTypeEnum, bool bOnMonth) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isOnMonth'] = bOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isOnMonth'] = bOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isOnMonth'] = bOnMonth;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  bool getIsDayPair(EasyTypeEnum easyTypeEnum) {
    bool bResultIsDayPair = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsDayPair = mapSymbolFrom['isDayPair'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsDayPair = mapSymbolTo['isDayPair'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsDayPair = mapSymbolHide['isDayPair'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsDayPair;
  }

  void setIsDayPair(EasyTypeEnum easyTypeEnum, bool bDayPair) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isDayPair'] = bDayPair;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isDayPair'] = bDayPair;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isDayPair'] = bDayPair;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  bool getIsOnDay(EasyTypeEnum easyTypeEnum) {
    bool bResultIsOnDay = false;
    if (easyTypeEnum == EasyTypeEnum.from) {
      bResultIsOnDay = mapSymbolFrom['isOnDay'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      bResultIsOnDay = mapSymbolTo['isOnDay'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      bResultIsOnDay = mapSymbolHide['isOnDay'];
    } else
      colog('easyTypeEnum:$easyTypeEnum');

    return bResultIsOnDay;
  }

  void setIsOnDay(EasyTypeEnum easyTypeEnum, bool bOnDay) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isOnDay'] = bOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isOnDay'] = bOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isOnDay'] = bOnDay;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }
}
