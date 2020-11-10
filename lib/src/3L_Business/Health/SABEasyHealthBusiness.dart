import '../../1L_Context/SACGlobal.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import 'SABStaticHealthBusiness.dart';
import 'SABHealthOriginBusiness.dart';

class SABEasyHealthBusiness {
  SABEasyHealthBusiness(this._inputLogicBusiness);
  SABStaticHealthBusiness _staticBusiness;
  final SABEasyLogicBusiness _inputLogicBusiness;

  SABStaticHealthBusiness staticBusiness() {
    if (null == _staticBusiness) {
      _staticBusiness = SABStaticHealthBusiness(_inputLogicBusiness);
    }
    return _staticBusiness;
  }

  SABHealthOriginBusiness originBusiness() {
    return staticBusiness().moveBusiness().originBusiness();
  }

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
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_EMPTY);

    for (int nRow in listRightEmpty)
      staticBusiness().calculateHealthOfMove(nRow, EasyTypeEnum.from);
    return bHasBegin;
  }

  ///Level:指的是OutRightEnum，Level4代指 RIGHT_STATIC
  ///bool calculateHealthAtLevel4() {
  bool calculateHealthOfStatic() {
    bool bHasBeginMove = staticBusiness().calculateHealthAtLevel3();
    List arrayStatic =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_EMPTY);
    for (int nRow in arrayStatic) {
      if (originBusiness().isUnFinish(nRow)) {
        double basicHealth =
            staticBusiness().baseHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        originBusiness().setHealth(basicHealth, nRow);
      }
    }
    bool bHasBeginStatic = staticBusiness().isLevel4HasBegin();
    for (int nRow in arrayStatic) {
      if (originBusiness().isUnFinish(nRow)) {
        if (bHasBeginStatic) {
          staticBusiness().calculateHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        } else {
          originBusiness().addToFinishArray(nRow);
        }
      }
    }
    return bHasBeginMove && bHasBeginStatic;
  }

  double usefulHealth() {
    double fResult = 0;
    int usefulIndex = _inputLogicBusiness.usefulGodRow();

    if (0 <= usefulIndex && usefulIndex < 6) {
      fResult = originBusiness().getHealth(usefulIndex);
    } else {
      int hideIndex = usefulIndex - ROW_FLY_BEGIN;
      fResult = staticBusiness().hideSymbolHealthAtRow(hideIndex);
    } //endi

    return fResult;
  }

  ///世的健康值
  double lifeHealth() {
    double fResult = 0;
    int lifeIndex = _inputLogicBusiness.getLifeIndex();
    fResult = originBusiness().getHealth(lifeIndex);
    return fResult;
  }

  String healthDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    double fHealth = staticBusiness().symbolHealthAtRow(nRow, easyType);
    fHealth -= originBusiness().healthCriticalValue();
    if (fHealth > 0)
      strResult = "强";
    else
      strResult = "弱";

    strResult = fHealth.toStringAsFixed(4) + strResult;

    return strResult;
  }

  double lifeHealthWithCritical() {
    return lifeHealth() - originBusiness().healthCriticalValue();
  }

  double usefulHealthWithCritical() {
    return usefulHealth() - originBusiness().healthCriticalValue();
  }
}
