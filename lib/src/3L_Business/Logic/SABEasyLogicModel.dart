import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABEasyLogicModel {
  bool isStaticEasy;

  List arrayRightMove;

  List arrayFromSeasonStrong;
  List arrayToSeasonStrong;
  List arrayHideSeasonStrong;

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
}
