import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import 'SABHealthOriginBusiness.dart';

///动爻的强弱计算
class SABMoveHealthBusiness {
  SABMoveHealthBusiness(this._inputLogicBusiness);

  SABHealthOriginBusiness _originBusiness;
  final SABEasyLogicBusiness _inputLogicBusiness;

  //calculateHealthAtLevel3Row
  void calculateHealthOfMove(int item, EasyTypeEnum easyType) {
    double basicHealth = 0;
    if (_inputLogicBusiness.isMovementAtRow(item))
      basicHealth = moveSymbolBasicHealthAtRow(item);
    else
      basicHealth = _originBusiness.symbolBasicHealthAtRow(item, easyType);

    List arrayEffects = effectingArrayAtLevel3Row(item, easyType);

    for (int itemEffects in arrayEffects) {
      if (_originBusiness.isUnFinish(itemEffects)) {
        calculateHealthOfMove(item, easyType);
      }
      //else cont.

      basicHealth += adjustHealthAtRow(item, easyType, itemEffects, easyType);
    } //endf
    _originBusiness.setHealth(basicHealth, item);
    _originBusiness.addToFinishArray(item);
  }

  bool calculateHealthAtLevel3() {
    bool bResult = isLevel3HasBegin();
    List arrayLevel3 =
        _originBusiness.rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
    for (int item in arrayLevel3) {
      if (_originBusiness.isUnFinish(item)) {
        if (bResult)
          calculateHealthOfMove(item, EasyTypeEnum.from);
        else {
          double basicHealth = 0;
          if (_inputLogicBusiness.isMovementAtRow(item))
            basicHealth = moveSymbolBasicHealthAtRow(item);
          else
            basicHealth =
                _originBusiness.symbolBasicHealthAtRow(item, EasyTypeEnum.from);

          _originBusiness.setHealth(basicHealth, item);
          _originBusiness.addToFinishArray(item);
        } //endi
      }
      //else cont.
    } //endf
    return bResult;
  }

  double adjustHealthAtRow(int basicRow, EasyTypeEnum baseEasyType,
      int effectsRow, EasyTypeEnum effectsEasyType) {
    double fHealth = 0;

    double basicDefense =
        _originBusiness.symbolDefensiveAtRow(basicRow, EasyTypeEnum.from);

    String basicSymbol =
        _inputLogicBusiness.symbolAtRow(basicRow, EasyTypeEnum.from);

    String basicEarth = _inputLogicBusiness.symbolEarth(basicSymbol);

    String effectsSymbol =
        _inputLogicBusiness.symbolAtRow(effectsRow, effectsEasyType);

    if (null != effectsSymbol && "" != effectsSymbol) {
      String effectsEarth = _inputLogicBusiness.symbolEarth(effectsSymbol);

      if (_inputLogicBusiness.isEarthBorn(effectsEarth, basicEarth)) {
        fHealth += symbolOutAtRow(effectsRow, effectsEasyType);
      }
      //else cont.

      if (_inputLogicBusiness.isEarthRestricts(effectsEarth, basicEarth)) {
        fHealth -= (MAX_DEFENSIVE - basicDefense) *
            symbolOutAtRow(effectsRow, effectsEasyType);
      }
      //else cont.
    } else
      colog("error!");

    return fHealth;
  }

  double symbolOutAtRow(int nRow, EasyTypeEnum easyType) {
    double result = 0.0;

    if (EasyTypeEnum.to == easyType) {
      double toHealth = toSymbolHealthAtRow(nRow);
      result = toHealth * _originBusiness.conversionRateAtRow(nRow, easyType);
    } else if (EasyTypeEnum.from == easyType) {
      if (_originBusiness.isUnFinish(nRow)) {
        double health = _originBusiness.getHealth(nRow);
        result = health * _originBusiness.conversionRateAtRow(nRow, easyType);
      } else {
        colog("error!");
      }
    } else if (EasyTypeEnum.hide == easyType) {
      colog("error!");
    }
    return result;
  }

  ///`变爻的health`//////////////////////////////////////////////////////

  double toSymbolHealthAtRow(int nRow) {
    return _originBusiness.symbolBasicHealthAtRow(nRow, EasyTypeEnum.to);
  }

  ///`动爻的基本值`//////////////////////////////////////////////////////

  ///动爻的基本值----------------------------------------------
  // 基础值加上变爻的生克
// 基础值加上变爻的生克
  double moveSymbolBasicHealthAtRow(int nRow) {
    double fResult = -100.0;

    fResult = _originBusiness.symbolBasicHealthAtRow(nRow, EasyTypeEnum.from);

    if (isSymbolEffectableAtRow(nRow, EasyTypeEnum.from)) {
      fResult +=
          adjustHealthAtRow(nRow, EasyTypeEnum.from, nRow, EasyTypeEnum.to);
    }
    //else cont.

    return fResult;
  }

  bool isSymbolEffectableAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     不受生克有以下几种情况:
     1、旬空；旬空的爻，health不变，但在生克上不起作用，但是在判断时机上起作用；
     2、日临月临：health无限大，不受生克冲合的影响。
     3、日合：health保持不变，但是对动爻的生克权有影响。
     最后、没有爻生克这个爻，或者没有1、2、3爻以外的爻影响；
     
     其中旬空、日合改变防御值与right，日临月临改变防御值与health，；
     */
    bool bResult = false;
    bResult =
        MAX_DEFENSIVE != _originBusiness.symbolDefensiveAtRow(nRow, easyType);
    return bResult;
  }

  bool isEffectingEarth(String basicEarth, int itemRow) {
    bool bResult = false;
    String earth = _inputLogicBusiness.earthAtFromRow(itemRow);
    if (_inputLogicBusiness.isEarthBorn(earth, basicEarth)) {
      bResult = true;
    } else if (_inputLogicBusiness.isEarthRestricts(earth, basicEarth)) {
      bResult = true;
    }
    //else cont.

    return bResult;
  }

  List effectingArrayAtLevel3Row(int nLevel3Row, EasyTypeEnum easyType) {
    String basicSymbol = _inputLogicBusiness.symbolAtRow(nLevel3Row, easyType);

    List arrayEffects = [];

    String basicEarth = _inputLogicBusiness.symbolEarth(basicSymbol);

    List level3Array =
        _originBusiness.rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);

    for (int itemRow in level3Array) {
      if (nLevel3Row != itemRow) {
        if (isEffectingLevel3AtRow(itemRow, easyType)) {
          if (isEffectingEarth(basicEarth, itemRow)) arrayEffects.add(itemRow);
          //else cont.
        }
        //else 日冲休囚静爻算是日破
      }
      //else cont.

    } //endf

    return arrayEffects;
  }

  bool isLevel6EffectableAtRow(int nRow, EasyTypeEnum easyType) {
    bool bResult = true;
    //TODO:除了动爻，静爻可以生克伏神吗？
    //TODO:除了旬空的不可以生克伏神，还有别的不可以生克伏神吗？

    if (_inputLogicBusiness.isEmptyAtRow(nRow, easyType)) bResult = false;
    //else cont.

    return bResult;
  }

  List effectingArrayAtLevel6Row(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];

    String basicSymbol = _inputLogicBusiness.symbolAtRow(nRow, easyType);
    String basicEarth = _inputLogicBusiness.symbolEarth(basicSymbol);

    List levelArray =
        _originBusiness.rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
    levelArray.add(nRow);

    for (int itemRow in levelArray) {
      if (isLevel6EffectableAtRow(itemRow, EasyTypeEnum.from)) {
        if (isEffectingEarth(basicEarth, itemRow)) arrayEffects.add(itemRow);
        //else cont.
      }
      //else cont.

    } //endf

    return arrayEffects;
  }

  bool isEffectingLevel3AtRow(int nEffectingRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (EasyTypeEnum.from == easyType) {
      //明动爻对其它爻都有生克权
      if (_inputLogicBusiness.isMovementAtRow(nEffectingRow))
        bResult = _inputLogicBusiness.isEffectableRow(nEffectingRow, easyType);
      else {
        //被日冲的爻只有在strong时才是暗动，才能生克动爻

        if (_originBusiness.isUnFinish(nEffectingRow)) {
          bResult =
              _inputLogicBusiness.isSymbolHealthStrong(nEffectingRow, easyType);
        } else {
          //未被计算的日冲爻，需要被计算
          bResult = true;
        }
      }
    } else
      colog("error!");

    return bResult;
  }

  bool isLevel3HasBegin() {
    bool bHasBegin = false;
    List arrayLevel3 =
        _originBusiness.rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
    if (arrayLevel3.length > 0) {
      for (int intItem in arrayLevel3) {
        List arrayEffects =
            effectingArrayAtLevel3Row(intItem, EasyTypeEnum.from);

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
}
