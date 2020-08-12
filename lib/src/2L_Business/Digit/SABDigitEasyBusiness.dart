import '../Easy/SABEasyModel.dart';
import '../../Context/SACGlobal.dart';
import 'SABDigitMoveBusiness.dart';
import 'SABDigitStaticBusiness.dart';

class SABDigitEasyBusiness {
  SABEasyModel inputModel;
  SABDigitMoveBusiness moveBusiness;
  SABDigitStaticBusiness staticBusiness;

  Map<int, double> _healthMap;

  List _finishedList;

  bool calculateHealth() {
    // 找到不受生克的动爻，如果找不到这个卦就没办法解开，最好重新占卜，这叫做乱动；
    // 子丑寅卯辰巳午未申酉戌亥，扣除旬空与日临，也可以形成闭环，比如：
    // 甲子月 甲子日 子 寅 巳 未 酉
    //备注：这句话应该是程序实现时的定义，将乱动对应到程序实现时，出现的查询方法；

    //  月破、日破都不能形成这样的条件，因为：
    //  月破；月破的爻在月支上的health为0，依然可以起到生克作用，但是力量非常弱。
    //  日破，对health没有影响，对right的影响与日冲是一样的。
    bool bHasBegin = calculateHealthAtLevel4();
    List arrayLevel5 = moveBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_EMPTY);
    for (int nRow in arrayLevel5)
      calculateHealthAtLevel3Row(nRow, EasyTypeEnum.from);
    return bHasBegin;
  }

  bool calculateHealthAtLevel4() {
    bool bHasBeginMove = moveBusiness.calculateHealthAtLevel3();
    List arrayStatic = moveBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_EMPTY);
    for (int nRow in arrayStatic) {
      if (-1 == _finishedList.indexOf(nRow)) {
        double basicHealth =
            staticBusiness.baseHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        setHealth(basicHealth, nRow);
      }
    }
    bool bHasBeginStatic = staticBusiness.isLevel4HasBegin();
    for (int nRow in arrayStatic) {
      if (-1 == _finishedList.indexOf(nRow)) {
        if (bHasBeginStatic) {
          staticBusiness.calculateHealthAtLevel4Row(nRow, EasyTypeEnum.from);
        } else {
          addToFinishArray(nRow);
        }
      }
    }
    return bHasBeginMove && bHasBeginStatic;
  }

  void calculateHealthAtLevel3Row(int nRow, EasyTypeEnum easyType) {
    double health =
        moveBusiness.calculateHealthAtLevel3Row(nRow, EasyTypeEnum.from);
    setHealth(health, nRow);
    addToFinishArray(nRow);
  }

  void setHealth(double numHealth, int nRow) {
    _healthMap[nRow] = numHealth;
  }

  void addToFinishArray(int nRow) {
    if (-1 == _finishedList.indexOf(nRow)) {
      _finishedList.add(nRow);
    }
  }

//世的强弱
  double lifeHealth() {
    double fResult = 0;
    int lifeIndex = inputModel.getLifeIndex();
    fResult = _healthMap[lifeIndex];
    return fResult;
  }
}
