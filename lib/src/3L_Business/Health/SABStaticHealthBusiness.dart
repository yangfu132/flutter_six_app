import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyBusiness.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import 'SABHealthOriginBusiness.dart';
import 'SABMoveHealthBusiness.dart';

///静爻的强弱
class SABStaticHealthBusiness {
  SABStaticHealthBusiness(this._inputEasyBusiness);
  final SABEasyBusiness _inputEasyBusiness;

  SABHealthOriginBusiness _originBusiness;
  SABMoveHealthBusiness _moveBusiness;
  SABEasyLogicBusiness _logicBusiness;

  void calculateHealthAtLevel4Row(int item, EasyTypeEnum easyType) {
    double basicHealth = symbolHealthAtRow(item, easyType);
    List arrayEffectsInLevel4 = effectingArrayAtLevel4Row(item, easyType);

    for (int itemEffects in arrayEffectsInLevel4) {
      if (_originBusiness.isUnFinish(itemEffects)) {
        calculateHealthAtLevel4Row(itemEffects, easyType);
      }
      //else cont.

      basicHealth += _moveBusiness.adjustHealthAtRow(
          item, easyType, itemEffects, easyType);
    } //endf
    _originBusiness.setHealth(basicHealth, item);
    _originBusiness.addToFinishArray(item);
  }

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    double fHealth = 0.0;

    if (EasyTypeEnum.from == easyType) {
      fHealth = _originBusiness.getHealth(nRow);
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = _moveBusiness.toSymbolHealthAtRow(nRow);
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbolHealthAtRow(nRow);
    } else
      colog("error!");

    return fHealth;
  }

  bool isLevel4HasBegin() {
    bool bHasBegin = false;
    List arrayLevel =
        _originBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_STATIC);
    if (arrayLevel.length > 0) {
      for (int item in arrayLevel) {
        List arrayEffects = effectingArrayAtLevel4Row(item, EasyTypeEnum.from);

        if (0 == arrayEffects.length) {
          //这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (_originBusiness.isUnFinish(itemEffects)) {
              allFinish = false;
              break;
            }
            //else cont.
          } //endf

          if (allFinish) bHasBegin = true;
          //else cont.

        } //endi

      } //endf
    } else
      bHasBegin = true;

    return bHasBegin;
  }

  bool calculateHealthAtLevel4() {
    bool bHasBegin3 = _moveBusiness.calculateHealthAtLevel3();

    List arrayLevel4 =
        _originBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_STATIC);
    for (int item in arrayLevel4) {
      if (_originBusiness.isUnFinish(item)) {
        double basicHealth = baseHealthAtLevel4Row(item, EasyTypeEnum.from);
        _originBusiness.setHealth(basicHealth, item);
      }
      //else cont.
    } //endf

    bool bHasBegin4 = isLevel4HasBegin();
    for (int item in arrayLevel4) {
      if (_originBusiness.isUnFinish(item)) {
        if (bHasBegin4)
          calculateHealthAtLevel4Row(item, EasyTypeEnum.from);
        else
          _originBusiness.addToFinishArray(item);
      }
      //else cont.
    } //endi

    return bHasBegin3 && bHasBegin4;
  }

  double baseHealthAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    double basicHealth = _originBusiness.symbolBasicHealthAtRow(nRow, easyType);

    List arrayEffectsInLevel3 =
        _moveBusiness.effectingArrayAtLevel3Row(nRow, easyType);

    for (int itemEffects in arrayEffectsInLevel3) {
      if (_originBusiness.isUnFinish(itemEffects)) {
        _moveBusiness.calculateHealthOfMove(itemEffects, easyType);
      } else {
        basicHealth += _moveBusiness.adjustHealthAtRow(
            nRow, easyType, itemEffects, easyType);
      } //endi
    } //endf

    return basicHealth;
  }

  bool isEffectingLevel4AtRow(int nEffectingRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (OutRightEnum.RIGHT_STATIC ==
        _originBusiness.symbolOutRightAtRow(nEffectingRow, easyType)) {
      if (_logicBusiness.isSymbolHealthStrong(nEffectingRow, easyType))
        bResult = true;
      //else cont.
    } else
      colog("error!");

    return bResult;
  }

  List effectingArrayAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    String basicSymbol = _inputEasyBusiness.symbolAtRow(nRow, easyType);

    List arrayEffects = [];

    String basicEarth = _inputEasyBusiness.symbolEarth(basicSymbol);

    List levelArray =
        _originBusiness.rowArrayAtLevel(OutRightEnum.RIGHT_STATIC);

    for (int itemRow in levelArray) {
      if (nRow != itemRow) {
        if (isEffectingLevel4AtRow(itemRow, easyType)) {
          if (_moveBusiness.isEffectingEarth(basicEarth, itemRow))
            arrayEffects.add(itemRow);
          //else cont.
        }
        //else 日冲休囚静爻算是日破
      }
      //else cont.

    } //endf

    return arrayEffects;
  }

  ///`伏神`//////////////////////////////////////////////////////
  double hideSymbolHealthAtRow(int nRow) {
    EasyTypeEnum easyType = EasyTypeEnum.hide;

    double basicHealth = _originBusiness.symbolBasicHealthAtRow(nRow, easyType);

    //TODO:疑问 伏神是否受到动爻的生克？伏神是否生克动爻？
    List arrayEffects = _moveBusiness.effectingArrayAtLevel6Row(nRow, easyType);

    for (int itemEffects in arrayEffects) {
      if (_originBusiness.isUnFinish(itemEffects)) {
        if (OutRightEnum.RIGHT_MOVE ==
            _originBusiness.symbolOutRightAtRow(nRow, easyType)) {
          _moveBusiness.calculateHealthOfMove(itemEffects, easyType);
        } else if (OutRightEnum.RIGHT_STATIC ==
            _originBusiness.symbolOutRightAtRow(nRow, easyType)) {
          calculateHealthAtLevel4();
        } //endi
      }

      basicHealth += _moveBusiness.adjustHealthAtRow(
          nRow, easyType, itemEffects, EasyTypeEnum.from);
    } //endf
    return basicHealth;
  }
}
