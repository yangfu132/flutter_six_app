import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyModel.dart';
import '../Easy/SABEasyBusiness.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import 'SABMoveHealthBusiness.dart';
import 'SABStaticHealthBusiness.dart';
import 'SABHealthOriginBusiness.dart';

class SABEasyHealthBusiness {
  SABEasyHealthBusiness(this._inputEasyModel);
  SABEasyBusiness _easyBusiness;
  final SABEasyModel _inputEasyModel;
  SABMoveHealthBusiness _moveBusiness;
  SABStaticHealthBusiness _staticBusiness;
  SABHealthOriginBusiness _originBusiness;
  SABEasyLogicBusiness _logicBusiness;

  bool calculateHealth() {
    // 找到不受生克的动爻，如果找不到这个卦就没办法解开，最好重新占卜，这叫做乱动；
    // 子丑寅卯辰巳午未申酉戌亥，扣除旬空与日临，也可以形成闭环，比如：
    // 甲子月 甲子日 子 寅 巳 未 酉
    //备注：这句话应该是程序实现时的定义，将乱动对应到程序实现时，出现的查询方法；

    //  月破、日破都不能形成这样的条件，因为：
    //  月破；月破的爻在月支上的health为0，依然可以起到生克作用，但是力量非常弱。
    //  日破，对health没有影响，对right的影响与日冲是一样的。

    bool bHasBegin = calculateHealthOfStatic();
    List listRightEmpty =
        _originBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_EMPTY);

    for (int nRow in listRightEmpty)
      _moveBusiness.calculateHealthOfMove(nRow, EasyTypeEnum.from);
    return bHasBegin;
  }

  ///Level:指的是OutRightEnum，Level4代指 RIGHT_STATIC
  ///bool calculateHealthAtLevel4() {
  bool calculateHealthOfStatic() {
    bool bHasBeginMove = _moveBusiness.calculateHealthAtLevel3();
    List arrayStatic =
        _originBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_EMPTY);
    for (int nRow in arrayStatic) {
      if (_originBusiness.isUnFinish(nRow)) {
        double basicHealth =
            _staticBusiness.baseHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        _originBusiness.setHealth(basicHealth, nRow);
      }
    }
    bool bHasBeginStatic = _staticBusiness.isLevel4HasBegin();
    for (int nRow in arrayStatic) {
      if (_originBusiness.isUnFinish(nRow)) {
        if (bHasBeginStatic) {
          _staticBusiness.calculateHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        } else {
          _originBusiness.addToFinishArray(nRow);
        }
      }
    }
    return bHasBeginMove && bHasBeginStatic;
  }

  double usefulHealth() {
    double fResult = 0;
    int usefulIndex = _logicBusiness.usefulGodRow();

    if (0 <= usefulIndex && usefulIndex < 6) {
      fResult = _originBusiness.getHealth(usefulIndex);
    } else {
      int hideIndex = usefulIndex - ROW_FLY_BEGIN;
      fResult = _staticBusiness.hideSymbolHealthAtRow(hideIndex);
    } //endi

    return fResult;
  }

//世的强弱
  double lifeHealth() {
    double fResult = 0;
    int lifeIndex = _easyBusiness.getLifeIndex();
    fResult = _originBusiness.getHealth(lifeIndex);
    return fResult;
  }

  String healthDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    double fHealth = _staticBusiness.symbolHealthAtRow(nRow, easyType);
    fHealth -= _originBusiness.healthCriticalValue();
    if (fHealth > 0)
      strResult = "强";
    else
      strResult = "弱";

    strResult = fHealth.toStringAsFixed(4) + strResult;

    return strResult;
  }
}
