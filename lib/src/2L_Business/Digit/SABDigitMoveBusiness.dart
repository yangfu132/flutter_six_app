import '../../Context/SACGlobal.dart';
import 'SABDigitBaseBusiness.dart';
import '../Easy/SABEasyModel.dart';

///动爻的强弱计算
class SABDigitMoveBusiness {
  SABEasyModel inputModel;

  SABDigitBaseBusiness digitBaseBusiness;

  double calculateHealthAtLevel3Row(int nRow, EasyTypeEnum easyType) {
    double basicHealth = 0;
    if (inputModel.isMovementAtRow(nRow)) {
      basicHealth = moveSymbolBasicHealthAtRow(nRow);
    } else {
      basicHealth = digitBaseBusiness.symbolBasicHealthAtRow(nRow, easyType);
    }
    List arrayEffects = effectingArrayAtLevel3Row(nRow, easyType);
    for (int itemEffects in arrayEffects) {
      if (-1 == arrayEffects.indexOf(itemEffects)) {
        calculateHealthAtLevel3Row(nRow, easyType);
      }
      //else cont.

      basicHealth +=
          digitBaseBusiness.adjustHealth(nRow, easyType, itemEffects, easyType);
    } //endf

    return basicHealth;
  }

  List effectingArrayAtLevel3Row(int nRow, EasyTypeEnum easyType) {
    return [];
  }

  bool calculateHealthAtLevel3() {
    //TODO
    return true;
  }

  List rowArrayAtLevel(OutRightEnum easyOutEnum) {
    //TODO
    List array = [];
    return array;
  }

  ///动爻的基本值----------------------------------------------
  // 基础值加上变爻的生克
  double moveSymbolBasicHealthAtRow(int nRow) {
    return 0;
  }
}
