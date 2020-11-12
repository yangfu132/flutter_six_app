import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABLogicModel {
  String stringDayEarth;
  String stringDaySky;
  String stringMonthSky;
  String stringMonthEarth;
  bool isStaticEasy;
  Map mapFromEasy;
  Map mapToEasy;
  Map mapHideEasy;
  List arrayRightMove;
  List arrayMovement;
  List arrayFromSeasonStrong;
  List arrayToSeasonStrong;
  List arrayHideSeasonStrong;

  String symbolAtRow(int intRow, EasyTypeEnum enumEasyType) {
    String strSymbol = '';
    if (enumEasyType == EasyTypeEnum.from) {
      strSymbol = mapFromEasy[intRow];
    } else if (enumEasyType == EasyTypeEnum.to) {
      strSymbol = mapToEasy[intRow];
    } else if (enumEasyType == EasyTypeEnum.hide) {
      strSymbol = mapHideEasy[intRow];
    } else {
      colog("error!");
    }
    return strSymbol;
  }

  bool isMovementAtRow(int nRow) {
    return -1 != arrayMovement.indexOf(nRow);
  }

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
