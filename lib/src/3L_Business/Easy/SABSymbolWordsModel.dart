import '../../1L_Context/SACGlobal.dart';

class SABSymbolWordsModel {
  int intDigit;
  int intRow;
  bool bMovement;

  /// symbol包含的字段
  /// String symbolName;
  /// String stringParent;
  /// String stringEarth;
  /// String stringElement;
  ///{
  ///'name':['','',''],
  ///'parent':['','',''],
  ///'earth':['','','']
  ///'Element':['','','']
  ///}
  Map mapSymbolFrom = {};
  Map mapSymbolTo = {};
  Map mapSymbolHide = {};

  String getSmbolName(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['name'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['name'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['name'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolParent(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['parent'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['parent'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolEarth(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['earth'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['earth'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSmbolElement(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['element'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['element'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['element'];
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }
}
