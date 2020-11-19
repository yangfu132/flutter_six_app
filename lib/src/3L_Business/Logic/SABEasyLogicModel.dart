import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyWordsModel.dart';

class SABEasyLogicModel {
  SABEasyLogicModel(this.inputWordsModel);
  final SABEasyWordsModel inputWordsModel;
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

  /// `桥函数`/////////////////////////////////////////////////////////////////
  String getSmbolEarth(int intRow, EasyTypeEnum easyTypeEnum) {
    return inputWordsModel.getSmbolEarth(intRow, easyTypeEnum);
  }

  bool isMovementAtRow(int intRow) {
    return inputWordsModel.isMovementAtRow(intRow);
  }
}
