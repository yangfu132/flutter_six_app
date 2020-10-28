import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyModel.dart';
import '../Easy/SABEasyBusiness.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';

class SABEasyAnalysisBusiness {
  SABEasyModel _easyModel;
  SABEasyBusiness _easyBusiness;
  SABEasyLogicBusiness _logicBusiness;
  SABEarthBranchBusiness _branchBusiness;

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

    if (_logicBusiness.isStaticEasy())
      result = staticEffectedAtRow(nIndex, easyType);
    else
      result = movementEffectedAtRow(nIndex, easyType);

    return result;
  }

  String movementEffectedAtRow(int nIndex, EasyTypeEnum easyType) {
    String result = "";

    String stringSymbol = _easyBusiness.symbolAtRow(nIndex, easyType);

    if (null != stringSymbol) {
      List arrayEffects = _logicBusiness.movementIndexArray();

      //把自己从列表中移除
      if (EasyTypeEnum.from == easyType) arrayEffects.remove(nIndex);
      //else cont.

      //卦有动爻能克静爻，即使静爻旺相亦不能克动爻。
      result = symbolEffected(stringSymbol, arrayEffects);

      //六爻安静，旺相之爻可以生得休囚之爻，亦可以克得休囚之爻。
      if (!_easyModel.isMovementAtRow(nIndex)) {
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

    String stringSymbol = _easyBusiness.symbolAtRow(nIndex, easyType);
    if (null != stringSymbol) {
      List arrayEffects = _logicBusiness.staticSeasonStrong();
      //把自己从列表中移除
      if (EasyTypeEnum.from == easyType) arrayEffects.remove(nIndex);
      //else cont.

      if (!_logicBusiness.isSymbolSeasonStrong(stringSymbol)) {
        result = symbolEffected(stringSymbol, arrayEffects);
      }
      //else cont.
    } else
      colog("error!");

    return result;
  }

  String symbolEffected(String basicSymbol, List arrayEffects) {
    String strResult = "";

    String basicEarth = _easyBusiness.symbolEarth(basicSymbol);

    for (int numItem in arrayEffects) {
      String earth = _easyBusiness.earthAtFromRow(numItem);

      bool bEffect = _logicBusiness.isEffectableRow(numItem, EasyTypeEnum.from);

      String strEffect = bEffect ? "" : "无效：";

      if (_branchBusiness.isEarthBorn(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              _branchBusiness.earthElement(earth) +
              "生";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              _branchBusiness.earthElement(earth) +
              "生";
        } //endi
      } else if (_branchBusiness.isEarthRestricts(earth, basicEarth)) {
        if ("" == strResult) {
          strResult = strEffect +
              positionAtMerge(numItem) +
              earth +
              _branchBusiness.earthElement(earth) +
              "克";
        } else {
          strResult = "\r\n" +
              strEffect +
              positionAtMerge(numItem) +
              earth +
              _branchBusiness.earthElement(earth) +
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

    String fromEarth = _easyBusiness.earthAtFromRow(nRow);
    String toEarth = _easyBusiness.earthAtChangeRow(nRow);
    if ("" != toEarth) {
      if (_logicBusiness.isSymbolChangeBornAtRow(nRow))
        result = SACContext.appendToString(result, "回头生");
      //else cont.

      if (_logicBusiness.isSymbolChangeBornAtRow(nRow))
        result = SACContext.appendToString(result, "回头克");
      //else cont.

      if (_logicBusiness.isSymbolChangeConflictAtRow(nRow))
        result = SACContext.appendToString(result, "回头冲");
      //else cont.

      String strPair = changePairDescriptionAtRow(nRow);
      if ("" != strPair) result = SACContext.appendToString(result, strPair);
      //else cont.

      String strForwardOrBack =
          _logicBusiness.symbolForwardOrBack(fromEarth, toEarth);
      if ("" != strForwardOrBack)
        result = SACContext.appendToString(result, strForwardOrBack);
      //else cont.

      String strTwelveGod = _branchBusiness.earthTwelveGod(fromEarth, toEarth);
      if ("长生" == strTwelveGod ||
          "帝旺" == strTwelveGod ||
          "墓" == strTwelveGod ||
          "绝" == strTwelveGod) {
        if ("" != result)
          result = "\r\n化$strTwelveGod";
        else
          result = "化$strTwelveGod";
      }
      //else cont.

      bool bToEmpty = _logicBusiness.isSymbolChangeEmpty(nRow);
      if (bToEmpty) result = SACContext.appendToString(result, "化空");
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////

  String getMonthRelationAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String stringSymbol = _easyBusiness.symbolAtRow(nRow, easyType);

    if ("" != stringSymbol) {
      String strEarth = _easyBusiness.symbolEarth(stringSymbol);

      String strMonth = _easyBusiness.monthEarth();

      if (_logicBusiness.isSymbolOnMonth(stringSymbol))
        strResult = SACContext.appendToString(strResult, "[临]");
      //else cont.

      String monthBroken = monthBrokenDescriptionAtRow(nRow, easyType);
      if ("" != monthBroken)
        strResult = SACContext.appendToString(strResult, monthBroken);
      //else cont.

      String strPair = symbolMonthPairDescription(stringSymbol);
      if ("" != strPair)
        strResult = SACContext.appendToString(strResult, strPair);
      //else cont.

      String strTwelveGod = _branchBusiness.earthTwelveGod(strEarth, strMonth);
      if ("长生" == strTwelveGod || "帝旺" == strTwelveGod || "绝" == strTwelveGod) {
        String strMark = "[$strTwelveGod]";
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

    String stringSymbol = _easyBusiness.symbolAtRow(nRow, easyType);

    if ("" != stringSymbol) {
      String strEarth = _easyBusiness.symbolEarth(stringSymbol);
      String strDay = _easyBusiness.dayEarth();

      String strTwelveGod = _branchBusiness.earthTwelveGod(strEarth, strDay);

      if (_logicBusiness.isSymbolOnDay(stringSymbol))
        strResult = SACContext.appendToString(strResult, "[临]");
      //else cont.

      bool bConflicted = _branchBusiness.isEarthConflict(strDay, strEarth);
      if (bConflicted) {
        if (_logicBusiness.isSymbolBackMoveAtRow(nRow, easyType))
          strResult = SACContext.appendToString(strResult, "[暗动]");
        else if (_logicBusiness.isSymbolDayBrokenAtRow(nRow, easyType))
          strResult = SACContext.appendToString(strResult, "[日破]");
        else
          strResult = SACContext.appendToString(strResult, "[冲]");
      }
      //else cont.

      String strPair = symbolDayPairDescription(stringSymbol);
      if ("" != strPair)
        strResult = SACContext.appendToString(strResult, strPair);
      //else cont.

      String strEmpty = resultSymbolEmpty(nRow, easyType);
      if ("" != strEmpty)
        strResult = SACContext.appendToString(strResult, strEmpty);
      //else cont.

      if ("长生" == strTwelveGod ||
          "帝旺" == strTwelveGod ||
          "墓" == strTwelveGod ||
          "绝" == strTwelveGod) {
        String strMark = "[$strTwelveGod]";
        strResult = SACContext.appendToString(strResult, strMark);
      }
      //else cont.
    }
    //else cont.

    return strResult;
  }

  String resultSymbolEmpty(int nRow, EasyTypeEnum easyType) {
    String strEmpty = "";
    switch (_logicBusiness.symbolEmptyState(nRow, easyType)) {
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

    String baseSymbol = _easyBusiness.symbolAtRow(nRow, easyType);

    if ("" != baseSymbol) {
      String strMonthPair = symbolMonthPairDescription(baseSymbol);
      if ("" != strMonthPair) {
        if (EasyTypeEnum.from == easyType) {
          if (_easyModel.isMovementAtRow(nRow)) {
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

  String resultDayPairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String baseSymbol = _easyBusiness.symbolAtRow(nRow, easyType);

    if ("" != baseSymbol) {
      String strPairResult = symbolDayPairDescription(baseSymbol);

      if ("" != strPairResult) {
        if (EasyTypeEnum.from == easyType) {
          if (_easyModel.isMovementAtRow(nRow)) {
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
    }
    //else cont.

    return strResult;
  }

  String resultMovePairAtRow(int nRow, EasyTypeEnum easyType) {
    String strResult = "";

    String baseSymbol = _easyBusiness.symbolAtRow(nRow, easyType);

    if ("" != baseSymbol) {
      if (EasyTypeEnum.from == easyType) {
        String strSymbolPair = "";
        //爻与爻合者，二也; 两爻都需要是动爻才能合
        List movementArray = _logicBusiness.movementIndexArray();
        if (movementArray.length >= 2) {
          for (int item in movementArray) {
            String tempSymbol = _easyBusiness.symbolAtFromRow(item);
            String strPair = symbolPairedDescription(baseSymbol, tempSymbol);
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

  String symbolDayPairDescription(String stringSymbol) {
    String strResult = "";

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    if (_logicBusiness.isEarthPairDay(strEarth, _easyBusiness.dayEarth())) {
      strResult = _branchBusiness.sixPairDescription(
          strEarth, _easyBusiness.dayEarth());
    }
    //else cont.

    return strResult;
  }

  String symbolMonthPairDescription(String stringSymbol) {
    String strResult = "";

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    String strDay = _easyBusiness.dayEarth();
    if (!_branchBusiness.isEarthConflict(strDay, strEarth) &&
        !_branchBusiness.isEarthConflict(strDay, _easyBusiness.monthEarth())) {
      strResult = _branchBusiness.sixPairDescription(
          strEarth, _easyBusiness.monthEarth());
    }
    //else cont.

    return strResult;
  }

  String symbolMovePairDescriptionAtRow(int nRow, EasyTypeEnum easyType) {
    String strSymbolPair = "";
    String basicSymbol = _easyBusiness.symbolAtRow(nRow, easyType);
    if (_easyBusiness.isSymbolMovement(basicSymbol)) {
      List movementArray = _logicBusiness.movementIndexArray();
      for (int item in movementArray) {
        if (nRow != item) {
          String tempSymbol = _easyBusiness.symbolAtFromRow(item);
          String strPair = symbolPairedDescription(basicSymbol, tempSymbol);
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

  String symbolPairedDescription(String basicSymbol, String otherSymbol) {
    String strResult = "";
    String basicEarth = _easyBusiness.symbolEarth(basicSymbol);
    String otherEarth = _easyBusiness.symbolEarth(otherSymbol);

    //爻逢合住，遇日建以冲开，谓之合处逢冲，是也。
    String strDay = _easyBusiness.dayEarth();
    if (!_branchBusiness.isEarthConflict(strDay, basicEarth) &&
        !_branchBusiness.isEarthConflict(strDay, otherEarth)) {
      strResult = _branchBusiness.sixPairDescription(basicEarth, otherEarth);
    }
    //else cont.

    return strResult;
  }

  String changePairDescriptionAtRow(int nRow) {
    String result = "";
    String fromSymbol = _easyBusiness.symbolAtFromRow(nRow);
    String toSymbol = _easyBusiness.symbolAtChangeRow(nRow);
    if ("" != fromSymbol && "" != toSymbol)
      result = symbolPairedDescription(fromSymbol, toSymbol);
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
    List movementArray = _logicBusiness.movementIndexArray();
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
    List movementArray = _logicBusiness.movementIndexArray();
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
      if (_easyModel.isMovementAtRow(nRow))
        strResult = strResult + posionLeft;
      else
        strResult = strResult + "$posionLeft(待)";
    } else
      strResult = strResult + posionLeft;

    return strResult;
  }

  String subThreePairAtRowArray(List arrayPairRow) {
    String strResult = "";

    List arrayR = _logicBusiness.earthThreePairInArray(
        _logicBusiness.earthAtMergeRowArray(arrayPairRow));

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

    List movementArray = _logicBusiness.movementIndexArray();
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
    List movementArray = _logicBusiness.movementIndexArray();
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
    String stringSymbol = _easyBusiness.symbolAtRow(nRow, easyType);
    switch (_logicBusiness.symbolMonthBrokenState(stringSymbol)) {
      case MonthBrokenEnum.Broken_NO:
        break;
      case MonthBrokenEnum.Broken_YES:
        monthBroken = "[月破]";
        break;
      case MonthBrokenEnum.Broken_OnDay:
        monthBroken = "[冲日建不破]";
        break;
      case MonthBrokenEnum.Broken_Move:
        monthBroken = "[冲动不破]";
        break;
      case MonthBrokenEnum.Broken_DayBorn:
        monthBroken = "[冲日生不破]";
        break;
      case MonthBrokenEnum.Broken_MoveBorn:
        monthBroken = "[冲动生不破]";
        break;
      default:
        colog("error!");
        break;
    }

    return monthBroken;
  }
}
