import '../Easy/SABSymbolWordsModel.dart';
import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABSymbolLogicModel {
  final SABSymbolWordsModel inputWordsSymbol;
  SABSymbolLogicModel(this.inputWordsSymbol);

  ///{
  ///'isOnMonth'
  ///'isOnDay'
  ///}
  Map mapSymbolFrom = {};
  Map mapSymbolTo = {};
  Map mapSymbolHide = {};

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

  void setIsOnMonth(EasyTypeEnum easyTypeEnum, bool isOnMonth) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isOnMonth'] = isOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isOnMonth'] = isOnMonth;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isOnMonth'] = isOnMonth;
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

  void setIsOnDay(EasyTypeEnum easyTypeEnum, bool isOnDay) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['isOnDay'] = isOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['isOnDay'] = isOnDay;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['isOnDay'] = isOnDay;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }
}
