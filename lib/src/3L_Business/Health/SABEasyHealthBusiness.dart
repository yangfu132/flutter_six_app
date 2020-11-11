import '../../1L_Context/SACGlobal.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import 'SABStaticHealthBusiness.dart';
import 'SABHealthOriginBusiness.dart';
import 'SABHealthModel.dart';

class SABEasyHealthBusiness {
  SABEasyHealthBusiness(this._inputLogicBusiness);
  final SABEasyLogicBusiness _inputLogicBusiness;
  SABStaticHealthBusiness _staticBusiness;
  SABHealthModel _outHealthModel;

  SABHealthModel calculateHealth() {
    // 找到不受生克的动爻，如果找不到这个卦就没办法解开，最好重新占卜，这叫做乱动；
    // 子丑寅卯辰巳午未申酉戌亥，扣除旬空与日临，也可以形成闭环，比如：
    // 甲子月 甲子日 子 寅 巳 未 酉
    //备注：这句话应该是程序实现时的定义，将乱动对应到程序实现时，出现的查询方法；

    //  月破、日破都不能形成这样的条件，因为：
    //  月破；月破的爻在月支上的health为0，依然可以起到生克作用，但是力量非常弱。
    //  日破，对health没有影响，对right的影响与日冲是一样的。

    outHealthModel().bValidEasy = calculateHealthOfStatic();
    List listRightEmpty =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_EMPTY);

    for (int nRow in listRightEmpty)
      staticBusiness().calculateHealthOfMove(nRow, EasyTypeEnum.from);

    return outHealthModel();
  }

  ///Level:指的是OutRightEnum，Level4代指 RIGHT_STATIC
  ///bool calculateHealthAtLevel4() {
  bool calculateHealthOfStatic() {
    bool bHasBeginMove = staticBusiness().calculateHealthAtLevel3();
    List arrayStatic =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);
    for (int nRow in arrayStatic) {
      if (outHealthModel().isUnFinish(nRow)) {
        double basicHealth =
            staticBusiness().baseHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        outHealthModel().setHealth(basicHealth, nRow);
      }
    }
    bool bHasBeginStatic = staticBusiness().isLevel4HasBegin();
    for (int nRow in arrayStatic) {
      if (outHealthModel().isUnFinish(nRow)) {
        if (bHasBeginStatic) {
          staticBusiness().calculateHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        } else {
          outHealthModel().addToFinishArray(nRow);
        }
      }
    }
    return bHasBeginMove && bHasBeginStatic;
  }

  double usefulHealth() {
    double fResult = 0;
    int usefulIndex = _inputLogicBusiness.usefulGodRow();

    if (0 <= usefulIndex && usefulIndex < 6) {
      fResult = outHealthModel().getHealth(usefulIndex);
    } else if (ROW_MONTH == usefulIndex) {
      fResult = originBusiness().monthHealthValue();
    } else if (ROW_DAY == usefulIndex) {
      fResult = originBusiness().dayHealthValue();
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
    fResult = outHealthModel().getHealth(lifeIndex);
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

  ///`SABEasyHealthDelegate`

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return staticBusiness().symbolHealthAtRow(nRow, easyType);
  }

  double healthCriticalValue() {
    return originBusiness().healthCriticalValue();
  }

  List rowArrayAtOutRightLevel(OutRightEnum level) {
    return originBusiness().rowArrayAtOutRightLevel(level);
  }

  ///`加载函数`
  SABHealthModel outHealthModel() {
    if (null == _outHealthModel) {
      _outHealthModel = SABHealthModel();
    }
    return _outHealthModel;
  }

  SABStaticHealthBusiness staticBusiness() {
    if (null == _staticBusiness) {
      _staticBusiness =
          SABStaticHealthBusiness(_inputLogicBusiness, outHealthModel());
    }
    return _staticBusiness;
  }

  SABHealthOriginBusiness originBusiness() {
    return staticBusiness().moveBusiness().originBusiness();
  }
}
