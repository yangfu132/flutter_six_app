import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../Health/SABEasyHealthBusiness.dart';
import '../Health/SABHealthModel.dart';
import '../Logic/SABEasyLogicModel.dart';
import 'SABEasyAnalysisModel.dart';
import '../Easy/SABEasyWordsModel.dart';
import '../Easy/SABEasyDigitModel.dart';

class SABEasyAnalysisBusiness {
  final SABEasyHealthBusiness _inputHealthBusiness;

  SABEasyAnalysisBusiness(this._inputHealthBusiness);

  SABEasyAnalysisModel _analysisModel;

  ///`basic`//////////////////////////////////////////////////////

  String positionAtMerge(int nRow) {
    String strResult = "";

    if (0 <= nRow && nRow < 6) {
      strResult = positionAtRow(nRow, EasyTypeEnum.from);
    } else if (ROW_CHNAGE_BEGIN <= nRow && nRow < ROW_CHNAGE_END) {
      strResult = positionAtRow(nRow - ROW_CHNAGE_BEGIN, EasyTypeEnum.to);
    } else if (ROW_FLY_BEGIN <= nRow && nRow < ROW_FLY_END) {
      strResult = positionAtRow(nRow - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    }
    //else cont.

    return strResult;
  }

  String positionAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    if (EasyTypeEnum.from == easyType) {
      List arrayPosition = ["上爻", "五爻", "四爻", "三爻", "二爻", "初爻"];
      strResult = arrayPosition[nRow];
    } else if (EasyTypeEnum.to == easyType) {
      List arrayPosition = ["上爻变", "五爻变", "四爻变", "三爻变", "二爻变", "初爻变"];
      strResult = arrayPosition[nRow];
    } else if (EasyTypeEnum.hide == easyType) {
      List arrayPosition = ["上爻伏神", "五爻伏神", "四爻伏神", "三爻伏神", "二爻伏神", "初爻伏神"];
      strResult = arrayPosition[nRow];
    }
    //else cont.

    return strResult;
  }

  ///`强弱`//////////////////////////////////////////////////////

  String getStrongTogether(String itemEarth) {
    return "";
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////

  String resultParentEffectAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = parentEffectAtRow(nRow, easyType);
    String strPair = symbolMovePairDescriptionAtRow(nRow, easyType);
    strResult = strResult + "\r\n" + strPair;
    return strResult;
  }

  String parentEffectAtRow(int nIndex, EasyTypeEnum easyType) {
    String result = "";

    if (logicModel().bStaticEasy)
      result = staticEffectedAtRow(nIndex, easyType);
    else
      result = movementEffectedAtRow(nIndex, easyType);

    return result;
  }

  String movementEffectedAtRow(int nIndex, EasyTypeEnum easyType) {
    String result = "";

    String stringSymbol = wordsModel().getSymbolName(nIndex, easyType);

    if (null != stringSymbol) {
      List arrayEffects = healthModel().listMoveRight;

      //把自己从列表中移除
      if (EasyTypeEnum.from == easyType) arrayEffects.remove(nIndex);
      //else cont.

      //卦有动爻能克静爻，即使静爻旺相亦不能克动爻。
      result = symbolEffected(nIndex, easyType, arrayEffects);

      //六爻安静，旺相之爻可以生得休囚之爻，亦可以克得休囚之爻。
      if (!digitModel().isMovementAtRow(nIndex)) {
        String staticResult = staticEffectedAtRow(nIndex, easyType);
        result = SACContext.appendToString(result, staticResult);
      } //endi
    } else
      colog("error!");

    return result;
  }

  String staticEffectedAtRow(int nIndex, EasyTypeEnum easyType) {
    //六爻安静，旺相之爻可以生得休囚之爻，亦可以克得休囚之爻。

    String result = "";

    String stringSymbol = wordsModel().getSymbolName(nIndex, easyType);
    if (null != stringSymbol) {
      List arrayEffects = logicModel().listStaticSeasonStrong;
      //把自己从列表中移除
      if (EasyTypeEnum.from == easyType) arrayEffects.remove(nIndex);
      //else cont.

      if (!logicModel().isSeasonStrong(nIndex, easyType)) {
        result = symbolEffected(nIndex, easyType, arrayEffects);
      }
      //else cont.
    } else
      colog("error!");

    return result;
  }

  String symbolEffected(int intRow, EasyTypeEnum easyType, List arrayEffects) {
    String strResult = "";

    String basicEarth = logicModel().getSmbolEarth(intRow, easyType);

    for (int numItem in arrayEffects) {
      String earth = wordsModel().getSmbolEarth(numItem, EasyTypeEnum.from);
      String stringElement =
          wordsModel().getSmbolElement(numItem, EasyTypeEnum.from);
      bool bEffect = logicModel().isEffectable(numItem, EasyTypeEnum.from);

      String strEffect = bEffect ? "" : "无效：";

      if (_inputLogicBusiness.isEarthBorn(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "生";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "生";
        } //endi
      } else if (_inputLogicBusiness.isEarthRestricts(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "克";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              stringElement +
              "克";
        } //endi
      }
      //else cont.
    } //endf

    return strResult;
  }

  ///`动静生克冲合章第十五`//////////////////////////////////////////////////////

  String changeAnalysisAtRow(int nRow) {
    String result = "";

    String fromEarth = _inputLogicBusiness.earthAtFromRow(nRow);
    String toEarth = _inputLogicBusiness.earthAtToRow(nRow);
    if ("" != toEarth) {
      if (_inputLogicBusiness.isSymbolChangeBornAtRow(nRow))
        result = SACContext.appendToString(result, "回头生");
      //else cont.

      if (_inputLogicBusiness.isSymbolChangeBornAtRow(nRow))
        result = SACContext.appendToString(result, "回头克");
      //else cont.

      if (_inputLogicBusiness.isSymbolChangeConflictAtRow(nRow))
        result = SACContext.appendToString(result, "回头冲");
      //else cont.

      String strPair = changePairDescriptionAtRow(nRow);
      if ("" != strPair) result = SACContext.appendToString(result, strPair);
      //else cont.

      String strForwardOrBack =
          _inputLogicBusiness.symbolForwardOrBack(fromEarth, toEarth);
      if ("" != strForwardOrBack)
        result = SACContext.appendToString(result, strForwardOrBack);
      //else cont.

      String strTwelveDeity =
          _inputLogicBusiness.earthTwelveDeity(fromEarth, toEarth);
      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "墓" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        if ("" != result)
          result = "\r\n化$strTwelveDeity";
        else
          result = "化$strTwelveDeity";
      }
      //else cont.

      bool bToEmpty = _inputLogicBusiness.isSymbolChangeEmpty(nRow);
      if (bToEmpty) result = SACContext.appendToString(result, "化空");
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////

  String getMonthRelationAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String stringSymbol = wordsModel().getSymbolName(nRow, easyType);

    if ("" != stringSymbol) {
      String strEarth = logicModel().getSmbolEarth(nRow, easyType);

      String strMonth = _inputLogicBusiness.monthEarth();

      if (logicModel().isOnMonth(nRow, easyType))
        strResult = SACContext.appendToString(strResult, "[临]");
      //else cont.

      String monthBroken = monthBrokenDescriptionAtRow(nRow, easyType);
      if ("" != monthBroken)
        strResult = SACContext.appendToString(strResult, monthBroken);
      //else cont.

      String strPair = earthMonthPairDescription(strEarth);
      if ("" != strPair)
        strResult = SACContext.appendToString(strResult, strPair);
      //else cont.

      String strTwelveDeity =
          _inputLogicBusiness.earthTwelveDeity(strEarth, strMonth);
      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        String strMark = "[$strTwelveDeity]";
        strResult = SACContext.appendToString(strResult, strMark);
      }
      //else cont.

    }
    //else cont.

    return strResult;
  }

  ///`日辰章第十七`//////////////////////////////////////////////////////

  String getDayRelationAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String stringSymbol = wordsModel().getSymbolName(nRow, easyType);
    String strEarth = logicModel().getSmbolEarth(nRow, easyType);
    if ("" != stringSymbol) {
      String strDay = _inputLogicBusiness.dayEarth();
      String strTwelveDeity =
          _inputLogicBusiness.earthTwelveDeity(strEarth, strDay);

      if (logicModel().isOnDay(nRow, easyType))
        strResult = SACContext.appendToString(strResult, "[临]");
      //else cont.

      bool bConflicted = _inputLogicBusiness.isEarthConflict(strDay, strEarth);
      if (bConflicted) {
        if (_inputLogicBusiness.isSymbolBackMoveAtRow(nRow, easyType))
          strResult = SACContext.appendToString(strResult, "[暗动]");
        else if (_inputLogicBusiness.isSymbolDayBrokenAtRow(nRow, easyType))
          strResult = SACContext.appendToString(strResult, "[日破]");
        else
          strResult = SACContext.appendToString(strResult, "[冲]");
      }
      //else cont.

      String strPair = earthDayPairDescription(strEarth);
      if ("" != strPair)
        strResult = SACContext.appendToString(strResult, strPair);
      //else cont.

      String strEmpty = resultSymbolEmpty(nRow, easyType);
      if ("" != strEmpty)
        strResult = SACContext.appendToString(strResult, strEmpty);
      //else cont.

      if ("长生" == strTwelveDeity ||
          "帝旺" == strTwelveDeity ||
          "墓" == strTwelveDeity ||
          "绝" == strTwelveDeity) {
        String strMark = "[$strTwelveDeity]";
        strResult = SACContext.appendToString(strResult, strMark);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String resultSymbolEmpty(int nRow, EasyTypeEnum easyType) {
    String strEmpty = "";
    switch (_inputLogicBusiness.symbolEmptyState(nRow, easyType)) {
      case EmptyEnum.Empty_NO:
        break;
      case EmptyEnum.Empty_YES:
        strEmpty = "[空]";
        break;
      case EmptyEnum.Empty_False:
        strEmpty = "[假空]";
        break;
      case EmptyEnum.Empty_Real:
        strEmpty = "[真空]";
        break;
      case EmptyEnum.Empty_Conflict:
        strEmpty = "[冲空不空]";
        break;
      default:
        break;
    } //ends

    return strEmpty;
  }

  ///`六合章第十九`//////////////////////////////////////////////////////

  ///`爻的六合分析`//////////////////////////////////////////////////////

  String resultMonthPairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String strEarth = logicModel().getSmbolEarth(nRow, easyType);

    if ("" != strEarth) {
      String strMonthPair = earthMonthPairDescription(strEarth);
      if ("" != strMonthPair) {
        if (EasyTypeEnum.from == easyType) {
          if (digitModel().isMovementAtRow(nRow)) {
            strMonthPair =
                "本爻与月合: $strMonthPair; 动而逢合谓之合绊。爻动或与日月动爻合者，谓之逢合而绊住，反不能动之意。";
          } else {
            strMonthPair =
                "月合: $strMonthPair; 爻之合者，静而逢合谓之合起。爻静或与日月动爻合者，得合而起，即使爻值休囚亦有旺相之意。";
          } //endi
        } else if (EasyTypeEnum.from == easyType) {
          strMonthPair = "变爻与月合: $strMonthPair; 即使爻值休囚亦有旺相之意。";
        } else if (EasyTypeEnum.hide == easyType) {
          strMonthPair = "伏神与月合: $strMonthPair; 即使爻值休囚亦有旺相之意。";
        } else
          colog("error!");
      }
      //else cont.

      strResult = SACContext.appendToString(strResult, strMonthPair);
    }
    //else cont.

    return strResult;
  }

  String resultDayPairAtRow(int intRow, EasyTypeEnum easyType) {
    String strResult = "";

    String strPairResult = logicModel().getSmbolEarth(intRow, easyType);
    if ("" != strPairResult) {
      if (EasyTypeEnum.from == easyType) {
        if (digitModel().isMovementAtRow(intRow)) {
          strPairResult =
              "本爻与日合: $strPairResult; 动而逢合谓之合绊。爻动或与日月动爻合者，谓之逢合而绊住，反不能动之意。";
        } else {
          strPairResult =
              "本爻与日合: $strPairResult; 爻之合者，静而逢合谓之合起。爻静或与日月动爻合者，得合而起，即使爻值休囚亦有旺相之意。";
        } //endi
      } else if (EasyTypeEnum.to == easyType) {
        strPairResult = "变爻与日合: $strPairResult; 即使爻值休囚亦有旺相之意。";
      } else if (EasyTypeEnum.hide == easyType) {
        strPairResult = "伏神与日合: $strPairResult; 即使爻值休囚亦有旺相之意。";
      } else
        colog("error!");
    }
    //else cont.

    strResult = SACContext.appendToString(strResult, strPairResult);

    return strResult;
  }

  String resultMovePairAtRow(int intRow, EasyTypeEnum easyType) {
    String strResult = "";
    String baseEarth = logicModel().getSmbolEarth(intRow, easyType);
    if ("" != baseEarth) {
      if (EasyTypeEnum.from == easyType) {
        String strSymbolPair = "";
        //爻与爻合者，二也; 两爻都需要是动爻才能合
        List movementArray = healthModel().listMoveRight;
        if (movementArray.length >= 2) {
          for (int item in movementArray) {
            String tempEarth =
                logicModel().getSmbolEarth(item, EasyTypeEnum.from);
            String strPair = earthPairedDescription(baseEarth, tempEarth);
            if ("" != strPair) {
              strSymbolPair = SACContext.appendSentence(strSymbolPair, strPair);
            }
          } //endf

          if ("" != strSymbolPair) {
            strSymbolPair = "动爻与动爻合: $strSymbolPair；爻动与动爻相合，乃得他来合我，与我和好相助之意。";
            strResult = SACContext.appendToString(strResult, strSymbolPair);
          }
          //else cont.
        }
        //else cont.
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String resultChangePairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    if (EasyTypeEnum.from == easyType) {
      String strSymbolPair = changePairDescriptionAtRow(nRow);
      if ("" != strResult) {
        strSymbolPair =
            "爻动化合者：$strSymbolPair；爻动化合谓之化扶。爻动化出之爻回头相合者，谓之化扶，得他扶助之意。";
        strResult = SACContext.appendToString(strResult, strSymbolPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String earthDayPairDescription(String strEarth) {
    String strResult = "";

    if (_inputLogicBusiness.isEarthPairDay(
        strEarth, _inputLogicBusiness.dayEarth())) {
      strResult = _inputLogicBusiness.sixPairDescription(
          strEarth, _inputLogicBusiness.dayEarth());
    }
    //else cont.

    return strResult;
  }

  String earthMonthPairDescription(String strEarth) {
    String strResult = "";
    String strDay = _inputLogicBusiness.dayEarth();
    if (!_inputLogicBusiness.isEarthConflict(strDay, strEarth) &&
        !_inputLogicBusiness.isEarthConflict(
            strDay, _inputLogicBusiness.monthEarth())) {
      strResult = _inputLogicBusiness.sixPairDescription(
          strEarth, _inputLogicBusiness.monthEarth());
    }
    //else cont.

    return strResult;
  }

  String symbolMovePairDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String strSymbolPair = "";
    String basicEarth = logicModel().getSmbolEarth(nRow, easyType);

    if (logicModel().isMovementAtRow(nRow)) {
      List movementArray = healthModel().listMoveRight;
      for (int item in movementArray) {
        if (nRow != item) {
          String tempEarth =
              logicModel().getSmbolEarth(item, EasyTypeEnum.from);
          String strPair = earthPairedDescription(basicEarth, tempEarth);
          if ("" != strPair)
            strSymbolPair = SACContext.appendToString(strSymbolPair, strPair);
          //else cont.
        }
        //else cont.

      } //endf
    }
    //else cont.

    return strSymbolPair;
  }

  String earthPairedDescription(String basicEarth, String otherEarth) {
    String strResult = "";
    //爻逢合住，遇日建以冲开，谓之合处逢冲，是也。
    String strDay = _inputLogicBusiness.dayEarth();
    if (!_inputLogicBusiness.isEarthConflict(strDay, basicEarth) &&
        !_inputLogicBusiness.isEarthConflict(strDay, otherEarth)) {
      strResult =
          _inputLogicBusiness.sixPairDescription(basicEarth, otherEarth);
    }
    //else cont.

    return strResult;
  }

  String changePairDescriptionAtRow(int intRow) {
    String result = "";
    String fromEarth = logicModel().getSmbolEarth(intRow, EasyTypeEnum.from);
    String toEarth = logicModel().getSmbolEarth(intRow, EasyTypeEnum.to);
    if ("" != fromEarth && "" != toEarth)
      result = earthPairedDescription(fromEarth, toEarth);
    //else cont.
    return result;
  }

  ///`-- 爻的三合`//////////////////////////////////////////////////////

  String resultThreePair() {
    /*
     此三合者有四；
     一卦之内有三爻动而合局者，一也。
     若两爻动，一爻不动亦成合局者，二也。
     有内卦初爻三爻动，动而变出之爻成三合者，三也。
     又有外卦四爻六爻动，动而变出之爻成合者，四也。
     */

    String strResult = "";

    //一卦之内有三爻动而合局者，一也。
    strResult = SACContext.appendToString(strResult, moveThreePair());

    //有内卦初爻三爻动，动而变出之爻成三合者，三也。
    strResult = SACContext.appendToString(strResult, insideEasyThreePair());

    //外卦四爻六爻动，动而变出之爻成合者，四也。
    strResult = SACContext.appendToString(strResult, outsideEasyThreePair());

    return strResult;
  }

  String moveThreePair() {
    String strResult = "";

    //一卦之内有三爻动而合局者，一也。
    List movementArray = healthModel().listMoveRight;
    String strThreePair = subResultThreePairOfRowArray(movementArray);

    List array = [0, 1, 2, 3, 4, 5];
    String strVirtual = subResultThreePairOfRowArray(array);
    if ("" != strThreePair || "" != strVirtual) {
      strResult = SACContext.appendToString(strResult, "动爻三合");

      if ("" != strThreePair)
        strResult = SACContext.appendToString(strResult, strThreePair);
      //else cont.

      if ("" != strVirtual)
        strResult = SACContext.appendToString(strResult, strVirtual);
      //else cont.
    }
    //else cont.

    return strResult;
  }

  int moveCountInArray(List arrayPairRow) {
    int nCount = 0;
    List movementArray = healthModel().listMoveRight;
    for (String item in arrayPairRow) {
      if (-1 != movementArray.indexOf(item)) nCount++;
      //else cont.
    } //endf

    return nCount;
  }

  String subResultThreePairdAtRow(int nRow) {
    String strResult = "";

    String posionLeft = positionAtMerge(nRow);

    if (0 <= nRow && nRow < 6) {
      if (digitModel().isMovementAtRow(nRow))
        strResult = strResult + posionLeft;
      else
        strResult = strResult + "$posionLeft(待)";
    } else
      strResult = strResult + posionLeft;

    return strResult;
  }

  String subThreePairAtRowArray(List arrayPairRow) {
    String strResult = "";

    List arrayR = _inputLogicBusiness.earthThreePairInArray(
        _inputLogicBusiness.earthAtMergeRowArray(arrayPairRow));

    if (arrayR.length == 1) {
      if (moveCountInArray(arrayPairRow) >= 2) {
        String strPairItem = "";

        String strLeft = subResultThreePairdAtRow(arrayPairRow[0]);
        if ("" != strLeft)
          strPairItem = strPairItem + "$strLeft、";
        else
          colog("error!");

        String strMiddle = subResultThreePairdAtRow(arrayPairRow[1]);
        if ("" != strMiddle)
          strPairItem = strPairItem + "$strMiddle";
        else
          colog("error!");

        String strRight = subResultThreePairdAtRow(arrayPairRow[2]);
        if ("" != strRight)
          strPairItem = strPairItem + "$strRight";
        else
          colog("error!");

        for (String itemResult in arrayR) {
          strPairItem = strPairItem + itemResult;
          strResult = SACContext.appendToString(strResult, strPairItem);
        } //endf
      }
      //else cont.
    }
    //else cont. 没有匹配

    return strResult;
  }

  String subResultThreePairOfRowArray(List arrayRow) {
    String strThreePair = "";

    if (arrayRow.length >= 3) {
      for (int nFirst = 0; nFirst < arrayRow.length; nFirst++) {
        int itemLeft = arrayRow[nFirst];
        for (int nSecond = nFirst + 1; nSecond < arrayRow.length; nSecond++) {
          int itemMiddle = arrayRow[nSecond];
          for (int nThird = nSecond + 1; nThird < arrayRow.length; nThird++) {
            int itemRight = arrayRow[nThird];
            String itemResult =
                subThreePairAtRowArray([itemLeft, itemMiddle, itemRight]);
            if ("" != itemResult)
              strThreePair =
                  SACContext.appendToString(strThreePair, itemResult);
            //else cont.
          } //endf
        } //endf
      } //endf
    }
    //else cont.

    return strThreePair;
  }

  String insideEasyThreePair() {
    String strResult = "";
    //有内卦初爻三爻动，动而变出之爻成三合者，三也。

    List movementArray = healthModel().listMoveRight;
    if (-1 != movementArray.indexOf(3) && -1 != movementArray.indexOf(5)) {
      String strPair = "";
      List arrayRow1 = [];
      arrayRow1.add(3);
      arrayRow1.add(3 + ROW_CHNAGE_BEGIN);
      arrayRow1.add(5);
      String tempResult1 = subResultThreePairOfRowArray(arrayRow1);
      if ("" != tempResult1)
        strPair = SACContext.appendToString(strPair, tempResult1);
      //else cont.

      List arrayRow2 = [];
      arrayRow2.add(3);
      arrayRow2.add(5);
      arrayRow2.add(5 + ROW_CHNAGE_BEGIN);
      String tempResult2 = subResultThreePairOfRowArray(arrayRow2);
      if ("" != tempResult2)
        strPair = SACContext.appendToString(strPair, tempResult2);
      //else cont.

      if ("" != strPair) {
        strResult = SACContext.appendToString(strResult, "内卦三合:");
        strResult = SACContext.appendToString(strResult, strPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String outsideEasyThreePair() {
    String strResult = "";
    //有外卦四爻六爻动，动而变出之爻成合者，四也。
    int nFirst = 0;
    int nSecond = 0;
    List movementArray = healthModel().listMoveRight;
    if (-1 != movementArray.indexOf(nFirst) &&
        -1 != movementArray.indexOf(nSecond)) {
      String strPair = "";
      List arrayRow1 = [];
      arrayRow1.add(nFirst);
      arrayRow1.add(nFirst + ROW_CHNAGE_BEGIN);
      arrayRow1.add(nSecond);
      String tempResult1 = subResultThreePairOfRowArray(arrayRow1);
      if ("" != tempResult1)
        strPair = SACContext.appendToString(strPair, tempResult1);
      //else cont.

      List arrayRow2 = [];
      arrayRow2.add(nFirst);
      arrayRow2.add(nSecond);
      arrayRow2.add(nSecond + ROW_CHNAGE_BEGIN);

      String tempResult2 = subResultThreePairOfRowArray(arrayRow2);
      if ("" != tempResult2)
        strPair = SACContext.appendToString(strPair, tempResult2);
      //else cont.

      if ("" != strPair) {
        strResult = SACContext.appendToString(strResult, "外卦三合:");
        strResult = SACContext.appendToString(strResult, strPair);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  ///`-- 月破章第二十七`//////////////////////////////////////////////////////

  String monthBrokenDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String monthBroken = "";
    switch (logicModel().getConflictOnMonthState(nRow, easyType)) {
      case MonthConflictEnum.Conflict_NO:
        break;
      case MonthConflictEnum.Conflict_Broken:
        monthBroken = "[月破]";
        break;
      case MonthConflictEnum.Conflict_OnDay:
        monthBroken = "[冲日建不破]";
        break;
      case MonthConflictEnum.Conflict_Move:
        monthBroken = "[冲动不破]";
        break;
      case MonthConflictEnum.Conflict_DayBorn:
        monthBroken = "[冲日生不破]";
        break;
      case MonthConflictEnum.Conflict_MoveBorn:
        monthBroken = "[冲动生不破]";
        break;
      default:
        colog("error!");
        break;
    }

    return monthBroken;
  }

  ///`加载函数`//////////////////////////////////////////////////////
  SABHealthModel healthModel() {
    return _inputHealthBusiness.outHealthModel();
  }

  SABEasyLogicModel logicModel() {
    return healthModel().inputLogicModel;
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }

  SABEasyDigitModel digitModel() {
    return wordsModel().inputDigitModel;
  }

  SABEasyAnalysisModel analysisModel() {
    if (null == _analysisModel) {
      _analysisModel =
          SABEasyAnalysisModel(_inputHealthBusiness.outHealthModel());
    }
    return _analysisModel;
  }
}
