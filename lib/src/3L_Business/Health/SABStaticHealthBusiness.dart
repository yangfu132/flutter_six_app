import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../Logic/SABEasyLogicModel.dart';
import 'SABHealthOriginBusiness.dart';
import 'SABMoveHealthBusiness.dart';
import 'SABStaticHealthModel.dart';

///静爻的强弱
class SABStaticHealthBusiness {
  SABStaticHealthBusiness(this._inputLogicBusiness);

  SABStaticHealthModel _outStaticHealthModel;

  SABMoveHealthBusiness _moveBusiness;
  final SABEasyLogicBusiness _inputLogicBusiness;

  void calculateHealthAtLevel4Row(int item, EasyTypeEnum easyType) {
    double basicHealth = symbolHealthAtRow(item, easyType);
    List arrayEffectsInLevel4 = effectingArrayAtLevel4Row(item, easyType);

    for (int itemEffects in arrayEffectsInLevel4) {
      if (outStaticHealthModel().isUnFinish(itemEffects)) {
        calculateHealthAtLevel4Row(itemEffects, easyType);
      }
      //else cont.

      basicHealth += moveBusiness()
          .adjustHealthAtRow(item, easyType, itemEffects, easyType);
    } //endf
    outStaticHealthModel().setHealth(basicHealth, item);
    outStaticHealthModel().addToFinishArray(item);
  }

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    double fHealth = 0.0;

    if (EasyTypeEnum.from == easyType) {
      fHealth = outStaticHealthModel().getHealth(nRow);
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = moveBusiness().toSymbolHealthAtRow(nRow);
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbolHealthAtRow(nRow);
    } else
      colog("error!");

    return fHealth;
  }

  bool isLevel4HasBegin() {
    bool bHasBegin = false;
    List arrayLevel =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);
    if (arrayLevel.length > 0) {
      for (int item in arrayLevel) {
        List arrayEffects = effectingArrayAtLevel4Row(item, EasyTypeEnum.from);

        if (0 == arrayEffects.length) {
          //这个分支是对的，下面那个分支可能永远也不会走到。因为在一个Level中，总会有不受同级生克的；而上一级对本级的生克已经计算完成。
          bHasBegin = true;
        } else {
          bool allFinish = true;
          for (int itemEffects in arrayEffects) {
            if (outStaticHealthModel().isUnFinish(itemEffects)) {
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
    bool bHasBegin3 = moveBusiness().calculateHealthAtLevel3();

    List arrayLevel4 =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);
    for (int item in arrayLevel4) {
      if (outStaticHealthModel().isUnFinish(item)) {
        double basicHealth = baseHealthAtLevel4Row(item, EasyTypeEnum.from);
        outStaticHealthModel().setHealth(basicHealth, item);
      }
      //else cont.
    } //endf

    bool bHasBegin4 = isLevel4HasBegin();
    for (int item in arrayLevel4) {
      if (outStaticHealthModel().isUnFinish(item)) {
        if (bHasBegin4)
          calculateHealthAtLevel4Row(item, EasyTypeEnum.from);
        else
          outStaticHealthModel().addToFinishArray(item);
      }
      //else cont.
    } //endi

    return bHasBegin3 && bHasBegin4;
  }

  double baseHealthAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    double basicHealth =
        originBusiness().symbolBasicHealthAtRow(nRow, easyType);

    List arrayEffectsInLevel3 =
        moveBusiness().effectingArrayAtLevel3Row(nRow, easyType);

    for (int itemEffects in arrayEffectsInLevel3) {
      if (outStaticHealthModel().isUnFinish(itemEffects)) {
        moveBusiness().calculateHealthOfMove(itemEffects, easyType);
      } else {
        basicHealth += moveBusiness()
            .adjustHealthAtRow(nRow, easyType, itemEffects, easyType);
      } //endi
    } //endf

    return basicHealth;
  }

  bool isEffectingLevel4AtRow(int nEffectingRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (OutRightEnum.RIGHT_STATIC ==
        originBusiness().symbolOutRightAtRow(nEffectingRow, easyType)) {
      if (_inputLogicBusiness.isSymbolHealthStrong(nEffectingRow, easyType))
        bResult = true;
      //else cont.
    } else
      colog("error!");

    return bResult;
  }

  List effectingArrayAtLevel4Row(int nRow, EasyTypeEnum easyType) {
    List arrayEffects = [];
    String basicEarth = logicModel().getSymbolEarth(nRow, easyType);

    List levelArray =
        originBusiness().rowArrayAtOutRightLevel(OutRightEnum.RIGHT_STATIC);

    for (int itemRow in levelArray) {
      if (nRow != itemRow) {
        if (isEffectingLevel4AtRow(itemRow, easyType)) {
          if (moveBusiness().isEffectingEarth(basicEarth, itemRow))
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

    double basicHealth =
        originBusiness().symbolBasicHealthAtRow(nRow, easyType);

    //TODO:疑问 伏神是否受到动爻的生克？伏神是否生克动爻？
    List arrayEffects =
        moveBusiness().effectingArrayAtLevel6Row(nRow, easyType);

    for (int itemEffects in arrayEffects) {
      if (outStaticHealthModel().isUnFinish(itemEffects)) {
        if (OutRightEnum.RIGHT_MOVE ==
            originBusiness().symbolOutRightAtRow(nRow, easyType)) {
          moveBusiness().calculateHealthOfMove(itemEffects, easyType);
        } else if (OutRightEnum.RIGHT_STATIC ==
            originBusiness().symbolOutRightAtRow(nRow, easyType)) {
          calculateHealthAtLevel4();
        } //endi
      }

      basicHealth += moveBusiness()
          .adjustHealthAtRow(nRow, easyType, itemEffects, EasyTypeEnum.from);
    } //endf
    return basicHealth;
  }

  ///`桥函数`//////////////////////////////////////////////////////

  bool calculateHealthAtLevel3() {
    return moveBusiness().calculateHealthAtLevel3();
  }

  void calculateHealthOfMove(int item, EasyTypeEnum easyType) {
    return moveBusiness().calculateHealthOfMove(item, easyType);
  }

  ///`加载函数`//////////////////////////////////////////////////////
  ///
  SABHealthOriginBusiness originBusiness() {
    return moveBusiness().originBusiness();
  }

  SABMoveHealthBusiness moveBusiness() {
    if (null == _moveBusiness) {
      _moveBusiness = SABMoveHealthBusiness(_inputLogicBusiness);
    }
    return _moveBusiness;
  }

  SABEasyLogicModel logicModel() {
    return _inputLogicBusiness.outLogicModel();
  }

  SABStaticHealthModel outStaticHealthModel() {
    if (null == _outStaticHealthModel) {
      _outStaticHealthModel = SABStaticHealthModel();
    }
    return _outStaticHealthModel;
  }
}
