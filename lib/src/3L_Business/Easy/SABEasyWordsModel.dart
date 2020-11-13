import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABEasyWordsModel {
  String stringDayEarth;
  String stringDaySky;
  String stringMonthSky;
  String stringMonthEarth;
  Map mapFromEasy;
  Map mapToEasy;
  Map mapHideEasy;
  List arrayMovement;
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
}
