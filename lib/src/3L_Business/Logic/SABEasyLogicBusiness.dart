﻿import '../../1L_Context/SACContext.dart';
import '../../1L_Context/SACGlobal.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';
import '../Easy/SABEasyBusiness.dart';
import '../Easy/SABEasyDigitModel.dart';
import '../Easy/SABEasyWordsModel.dart';
import '../Easy/SABElementModel.dart';
import 'SABEasyLogicDelegate.dart';
import 'SABEasyLogicModel.dart';

class SABEasyLogicBusiness {
  SABEasyLogicBusiness(this._inputEasyModel, this._inputDelegate);
  final SABEasyDigitModel _inputEasyModel;
  SABEasyLogicDelegate _inputDelegate;
  SABEarthBranchBusiness _branchBusiness;
  SABEasyBusiness _easyBusiness;
  SABEasyLogicModel _outLogicModel;

  //属性：用神的索引号
  int _usefulDeityRow = globalRowInvalid;

  ///`六亲歌章第五`//////////////////////////////////////////////////////

  String _symbolRelative(int intRow) {
    String theEarth =
        inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);
    String basicEarth =
        inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.hide);

    return branchBusiness().earthRelative(theEarth, basicEarth);
  }

  List arrayFromRowOfParent(String parent) {
    return arrayRowWithParent(parent, EasyTypeEnum.from);
  }

  List arrayRowWithParent(String parent, EasyTypeEnum easyTypeEnum) {
    List parrentArray = List();

    for (int intRow = 0; intRow < 6; intRow++) {
      String stringSymbolParent =
          inputEasyWordsModel().getSmbolParent(intRow, easyTypeEnum);
      if (stringSymbolParent == parent) {
        parrentArray.add(intRow);
      }
      //else cont.
    } //endf

    return parrentArray;
  }

  ///`世应章第六 -- 世（Life） 应（Goal）`/////////////////////////////////////////

  String roleDescriptionAtRow(int intIndex) {
    String strResult = "";
    if (intIndex == getLifeIndex()) {
      strResult = "世";
    } else if (intIndex == getGoalIndex()) {
      strResult = "应";
    }

    return strResult;
  }

  ///`动变章第七`//////////////////////////////////////////////////////
  bool isSymbolChangeGuiAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    if (null != strTo) {
      String fromElement = earthElement(fromEarth);
      String toElement = earthElement(strTo);
      String parent = SABElementModel.elementRelative(fromElement, toElement);
      bResult = "官鬼" == parent;
    }
    //else cont.

    return bResult;
  }

  ///`用神章第八--用神旺相`//////////////////////////////////////////////////////
  bool isUsefulDeityChangeToConflict() {
    return isSymbolChangeConflictAtRow(usefulDeityRow());
  }

  bool isUsefulDeityChangeToRestricts() {
    return isSymbolChangeRestrictAtRow(usefulDeityRow());
  }

  bool isUsefulDeityStrong() {
    bool bResult = false;

    int usefulIndex = usefulDeityRow();
    if (0 <= usefulIndex && usefulIndex <= 5) {
      bResult = isSymbolHealthStrong(usefulIndex, EasyTypeEnum.from);
    } else if (ROW_MONTH == usefulIndex) {
      bResult = true;
      colog("error!");
    } else if (ROW_DAY == usefulIndex) {
      bResult = true;
      colog("error!");
    } else if (ROW_FLY_BEGIN <= usefulIndex) {
      usefulIndex -= ROW_FLY_BEGIN;
      if (0 <= usefulIndex && usefulIndex <= 5) {
        bResult = isSymbolHealthStrong(usefulIndex, EasyTypeEnum.hide);
      } else
        colog("error!");
    } else
      colog("error!");

    return bResult;
  }

  String elementOfUsefulDeity() {
    String strUsefulElement = "";
    int usefulIndex = usefulDeityRow();
    if (usefulIndex == globalRowInvalid) {
      //没有指定用神
    } else if (usefulIndex < 6) {
      String usefulfromEarth = earthAtFromRow(usefulIndex);
      strUsefulElement = earthElement(usefulfromEarth);
    } else if (usefulIndex == ROW_MONTH) {
      strUsefulElement = monthElement();
    } else if (usefulIndex == ROW_DAY) {
      strUsefulElement = dayElement();
    } else if (usefulIndex >= ROW_FLY_BEGIN) {
      strUsefulElement = inputEasyWordsModel()
          .getSmbolElement(usefulIndex - ROW_FLY_BEGIN, EasyTypeEnum.hide);
    } else
      colog("error!");

    return strUsefulElement;
  }

  String usefulEarth() {
    String stringEarth = "";
    int usefulIndex = usefulDeityRow();
    if (0 <= usefulIndex && usefulIndex < 6) {
      stringEarth = earthAtFromRow(usefulIndex);
    } else {
      stringEarth = earthAtHideRow(usefulIndex - ROW_FLY_BEGIN);
    } //endi

    return stringEarth;
  }

  int usefulDeityRow() {
    if ("" != getUsefulDeity()) {
      if (globalRowInvalid == _usefulDeityRow) {
        _usefulDeityRow = indexOfUseDeityInEasy(EasyTypeEnum.from);
      }
    } else
      _usefulDeityRow = globalRowInvalid;

    _usefulDeityRow = globalRowInvalid == _usefulDeityRow ? 0 : _usefulDeityRow;

    return _usefulDeityRow;
  }

  void clearUsefulRow() {
    _usefulDeityRow = globalRowInvalid;
  }

  ///`用神元神忌神仇神章第九`//////////////////////////////////////////////////////
  String dietyAtRow(int intIndex, EasyTypeEnum enumEasyType) {
    String strResult = "";

    if (enumEasyType == EasyTypeEnum.from) {
      int usefulIndex = usefulDeityRow();
      if (usefulIndex == intIndex) {
        strResult = "用神";
      } else if (usefulIndex - ROW_FLY_BEGIN == intIndex) {
        strResult = "飞神";
      } else {
        String usefulElement = elementOfUsefulDeity();
        String currentElement =
            branchBusiness().earthElement(earthAtFromRow(intIndex));

        String parent =
            SABElementModel.elementRelative(usefulElement, currentElement);
        if ("父母" == parent) {
          strResult = "元神";
        } else if ("官鬼" == parent) {
          strResult = "忌神";
        } else if ("妻财" == parent) {
          strResult = "仇神";
        }
        //else cont.
      }
    } else if (EasyTypeEnum.to == enumEasyType)
      strResult = "变爻";
    else if (EasyTypeEnum.hide == enumEasyType) strResult = "伏神";
    //else cont.

    return strResult;
  }

  ///`--生世克世`//////////////////////////////////////////////////////
  List lifeBornArray() {
    String lifeElement = inputEasyWordsModel()
        .getSmbolElement(getLifeIndex(), EasyTypeEnum.from);
    return arrayParent("父母", lifeElement);
  }

  List lifeEnemyArray() {
    String lifeElement = inputEasyWordsModel()
        .getSmbolElement(getLifeIndex(), EasyTypeEnum.from);
    return arrayParent("官鬼", lifeElement);
  }

  List arrayParent(String strParent, String strElement) {
    List arrayResult = [];
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String tempParent =
          SABElementModel.elementRelative(strElement, currentElement);
      if (tempParent == strParent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  ///`元神忌神衰旺章第十`//////////////////////////////////////////////////////
  bool isDeityValid(int intIndex) {
    bool bResult = true;
    List arrayBorns = bornDeityIndexArray();
    if (-1 != arrayBorns.indexOf(intIndex)) {
      if (isBornDeityInValidAtRow(intIndex))
        bResult = false;
      else
        bResult = isBornDeityValidAtRow(intIndex);
    }
    //else cont.

    List arrayRestricts = restrictsDeityIndexArray();
    if (-1 != arrayRestricts.indexOf(intIndex)) {
      if (isRestrictDeityInvalidAtRow(intIndex))
        bResult = false;
      else
        bResult = isRestrictDeityValidAtRow(intIndex);
    }
    //else cont.

    return bResult;
  }

  List bornDeityIndexArray() {
    List arrayResult = List();
    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("父母" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List restrictsDeityIndexArray() {
    List arrayResult = List();

    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("官鬼" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List enemyDeityRowArray() {
    List arrayResult = List();

    String usefulElement = elementOfUsefulDeity();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          branchBusiness().earthElement(earthAtFromRow(intIndex));
      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("妻财" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  bool isRestrictDeityValidAtRow(int intRow) {
    bool bResult = false;

    /*
     忌神动而克害用神者有五：
     
     忌神旺相或遇日月动爻生扶或临日月者，一也。
     忌神动化回头生化进神者，二也。
     忌神旺动临空化空，三也。
     忌神长生帝旺于日辰，四也。
     忌神与仇神同动，五也。
     以上之忌神者如斧钺之忌神也，诸占大凶。
     */

    //忌神旺相或遇日月动爻生扶或临日月者，一也。
    String strSymbolBase = symbolAtRow(intRow, EasyTypeEnum.from);
    bool bStrong = isSymbolSeasonStrong(strSymbolBase);
    bool bOnMonth = _isSymbolOnMonth(strSymbolBase);
    bool bOnDay = _isSymbolOnDay(strSymbolBase);
    bool bMonthBorn = _isSymbolMoveBorn(strSymbolBase);
    bool bDayBorn = _isSymbolDayBorn(strSymbolBase);
    bool bMoveBorn = isSymbolBornedByMoveAtRow(intRow, EasyTypeEnum.from);
    if (bStrong || bOnMonth || bOnDay || bMonthBorn || bDayBorn || bMoveBorn) {
      bResult = true;
    } else {
      //忌神动化回头生化进神者，二也。
      bool bToBorn = isSymbolChangeBornAtRow(intRow);
      bool bForward = isSymbolChangeForwardAtRow(intRow);
      if (bToBorn || bForward) {
        bResult = true;
      } else {
        //忌神旺动临空化空，三也。
        bool bStrong = isSymbolSeasonStrong(strSymbolBase);
        bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
        bool bToEmpty = isSymbolChangeEmpty(intRow);
        bool bMoving = isMovementAtRow(intRow);
        if (bStrong && bMoving && bEmpty && bToEmpty) {
          bResult = true;
        } else {
          //忌神长生帝旺于日辰，四也。
          String stringEarthBase = _symbolEarth(strSymbolBase);
          String stringTewleveDeity =
              branchBusiness().earthTwelveDeity(stringEarthBase, dayEarth());
          if ("长生" == stringTewleveDeity || "帝旺" == stringTewleveDeity)
            bResult = true;
          else {
            //忌神与仇神同动，五也。
            bool bMoving = isMovementAtRow(intRow);
            bool bEnemyMoving = false;
            List listEnemyDeityRow = enemyDeityRowArray();
            for (int intIndex in listEnemyDeityRow) {
              bEnemyMoving = isMovementAtRow(intIndex);
              if (bEnemyMoving) break;
              //else cont.
            } //endf

            bResult = bMoving && bEnemyMoving;
          } //endi
        } //endi
      } //endi

    } //endi
    return bResult;
  }

  bool isBornDeityValidAtRow(int intIndex) {
    /*
     元神能生用神者有五：元神旺相或临日月或动爻生扶者，一也。
     元神动化回头生及化进神者，二也。
     元神长生帝旺于日辰，三也。
     元神与忌神同动，四也。
     元神旺动临空化空，五也。
     */
    bool bResult = false;

    String stringSymbolBase = symbolAtRow(intIndex, EasyTypeEnum.from);

    //元神旺相或临日月或动爻生扶者，一也。
    bool bStrong = isSymbolSeasonStrong(stringSymbolBase);
    bool bOnMonth = _isSymbolOnMonth(stringSymbolBase);
    bool bOnDay = _isSymbolOnDay(stringSymbolBase);
    bool bMoveBorn = isSymbolBornedByMoveAtRow(intIndex, EasyTypeEnum.from);
    if (bStrong || bOnMonth || bOnDay || bMoveBorn) {
      bResult = true;
    } else {
      //元神动化回头生及化进神者，二也。
      bool bToBorn = isSymbolChangeBornAtRow(intIndex);
      bool bForward = isSymbolChangeForwardAtRow(intIndex);
      if (bToBorn || bForward) {
        bResult = true;
      } else {
        //元神长生帝旺于日辰，三也。
        String stringEarthBase = _symbolEarth(stringSymbolBase);
        String stringTewleveDeity =
            branchBusiness().earthTwelveDeity(stringEarthBase, dayEarth());
        if ("长生" == stringTewleveDeity || "帝旺" == stringTewleveDeity)
          bResult = true;
        else {
          //元神与忌神同动，四也。
          bool bMoving = isMovementAtRow(intIndex);
          bool bRestrictMoving = false;
          List listRestrictsDeityIndex = restrictsDeityIndexArray();
          for (int numIndex in listRestrictsDeityIndex) {
            bRestrictMoving = isMovementAtRow(numIndex);
            if (bRestrictMoving) break;
            //else cont.
          } //endf

          if (bMoving && bRestrictMoving) {
            bResult = true;
          } else {
            //元神旺动临空化空，五也。
            bool bStrong = isSymbolSeasonStrong(stringSymbolBase);
            bool bEmpty = isEmptyAtRow(intIndex, EasyTypeEnum.from);
            bool bToEmpty = isSymbolChangeEmpty(intIndex);
            if (bStrong && bMoving && bEmpty && bToEmpty) {
              bResult = true;
            }
            //else cont.
          } //endi
        } //endi
      } //endi
    } //endi

    return bResult;
  }

  bool isBasicInvalidAtRow(int intRow) {
    bool bResult = false;

    //休囚不动，动而休囚被日月动爻克者，一也。
    String basicSymbol = symbolAtFromRow(intRow);
    bool bSeasonStrong = isSymbolSeasonStrong(basicSymbol);
    if (!isMovementAtRow(intRow)) {
      bResult = bSeasonStrong;
    } else {
      String stringBasicElement =
          branchBusiness().earthElement(earthAtFromRow(intRow));
      //判断月建是否克此爻

      String strMonthParent =
          SABElementModel.elementRelative(stringBasicElement, monthElement());
      bool bMonthRestricts = "官鬼" == strMonthParent;

      //判断日建是否克此爻
      String strDayParent =
          SABElementModel.elementRelative(stringBasicElement, dayElement());
      bool bDayRestricts = "官鬼" == strDayParent;

      bool bMoveRestricts =
          isSymbolRestrictedByMoveAtIndex(intRow, EasyTypeEnum.from);

      bResult =
          !bSeasonStrong && bMonthRestricts && bDayRestricts && bMoveRestricts;
    } //endi

    return bResult;
  }

  bool isRestrictDeityInvalidAtRow(int intRow) {
    bool bResult = false;

    EasyTypeEnum enumEasyType = EasyTypeEnum.from;

    /*
     忌神虽动又有不能克用神者有七：
     忌神休囚不动，动而休囚被日月动爻克者，一也。
     忌神静临空破，二也。
     忌神入三墓，三也。
     忌神衰动化退神，四也。
     忌神衰而又绝，五也。
     忌神动化绝化克化破化散，六也。
     忌神与元神同动，七也。
     此忌神者乃无力之忌神也，诸占化凶为吉。
     */

    //忌神休囚不动，动而休囚被日月动爻克者，一也。
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //忌神静临空破，二也。
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken = MonthConflictEnum.Conflict_Broken ==
          _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
      bool bMoving = inputEasyWordsModel().isMovementAtRow(intRow);
      if ((!bMoving && bEmpty && bBroken))
        bResult = true;
      else {
        //忌神入三墓，三也。
        if (isSymbolMuAtRow(intRow, enumEasyType))
          bResult = true;
        else {
          //忌神衰动化退神，四也。
          bool bShuai = isSymbolShuaiAtRow(intRow, enumEasyType);
          bool bFrowardBack = isSymbolChangeBackAtRow(intRow);

          if (bShuai && bFrowardBack) {
            bResult = true;
          } else {
            //忌神衰而又绝，五也。
            bool bJue = isSymbolJueAtRow(intRow, enumEasyType);
            if (bShuai && bJue)
              bResult = true;
            else {
              //忌神动化绝化克化破化散，六也。
              bool bRestrict = false;
              String fromEarth = earthAtFromRow(intRow);
              String toEarth = earthAtToRow(intRow);

              //化克
              if ("" != toEarth)
                bRestrict = isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              String toSymbol = symbolAtToRow(intRow);
              if (toSymbol != "") {
                bToDayBroken = isSymbolDayBrokenAtRow(intRow, enumEasyType);
                bToMonthBroken = (MonthConflictEnum.Conflict_Broken ==
                    _symbolConflictStateOnMonth(intRow, EasyTypeEnum.to));
              }
              //else cont.

              if (bRestrict || bToDayBroken || bToMonthBroken) {
                bResult = true;
              } else {
                //忌神与元神同动，七也。
                bool bBornMoving = false;
                List listBornDeityIndex = bornDeityIndexArray();
                for (int numIndex in listBornDeityIndex) {
                  bBornMoving = isMovementAtRow(numIndex);
                  if (bBornMoving) break;
                  //else cont.
                } //endf

                if (bMoving && bBornMoving) {
                  bResult = true;
                }
              } //endi
            } //endi
          } //endi
        } //endi
      } //endi
    } //endi

    return bResult;
  }

  bool isBornDeityInValidAtRow(int intRow) {
    bool bResult = true;
    EasyTypeEnum easyType = EasyTypeEnum.from;
    /*
     元神虽现又有不能生用神者用六：
     以上见生不生，为无用之元神也，虽有如无。
     */
    //元神休囚不动，或动而休囚又被伤克者，一也。
    String bornSymbol = symbolAtFromRow(intRow);
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //元神休囚又逢旬空月破，二也。
      bool bStrong = isSymbolSeasonStrong(bornSymbol);
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken = MonthConflictEnum.Conflict_Broken ==
          _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
      if ((!bStrong && bEmpty) || (!bStrong && bBroken))
        bResult = true;
      else {
        //元神休囚动化退神，三也。
        bool bFrowardBack = isSymbolChangeBackAtRow(intRow);
        if (!bStrong && bFrowardBack) {
          bResult = true;
        } else {
          //元神衰而又绝，四也。
          bool bShuai = isSymbolShuaiAtRow(intRow, easyType);
          bool bJue = isSymbolJueAtRow(intRow, easyType);
          if (bShuai && bJue)
            bResult = true;
          else {
            //元神入三墓，五也。
            if (isSymbolMuAtRow(intRow, easyType))
              bResult = true;
            else {
              //元神休囚动而化绝化克化破化散，六也。
              bool bRestrict = false;
              String fromEarth = earthAtFromRow(intRow);
              String toEarth = earthAtToRow(intRow);
              if ("" != toEarth)
                bRestrict = isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              String toSymbol = symbolAtToRow(intRow);
              if ("" != toSymbol) {
                bToDayBroken = isSymbolDayBrokenAtRow(intRow, easyType);
                bToMonthBroken = (MonthConflictEnum.Conflict_Broken ==
                    _symbolConflictStateOnMonth(intRow, EasyTypeEnum.to));
              }
              //else cont.

              if (!bStrong) {
                if (bJue || bRestrict || bToMonthBroken || bToDayBroken)
                  bResult = true;
                //else cont.
              }
              //else cont.

            } //endi
          } //endi
        } //endi

      } //endi

    } //endi
    return bResult;
  }

//墓
  bool isSymbolMuAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    //个人猜测应该是日月动三者合力的结果
    //墓与生相对，看此爻在三者上差额
    if (easyType == EasyTypeEnum.from) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);

      String monthTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, monthEarth());
      String dayTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, dayEarth());

      String toTwelve = earthTwelveDeity(fromEarth, toEarth);

      int nValue = 0;

      if ("长生" == monthTwelve) nValue++;
      //else cont.

      if ("长生" == dayTwelve) nValue++;
      //else cont.

      if ("长生" == toTwelve) nValue++;
      //else cont.

      if ("墓" == monthTwelve) nValue--;
      //else cont.

      if ("墓" == dayTwelve) nValue--;
      //else cont.

      if ("墓" == toTwelve) nValue--;
      //else cont.

      bResult = nValue < 0;
    } else
      colog("error!");

    return bResult;
  }

//衰
  bool isSymbolShuaiAtRow(int intRow, EasyTypeEnum easyType) {
    //无动爻生，日月上不敌，即是衰。
    bool bResult = false;

    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from)
      stringSymbol = symbolAtFromRow(intRow);
    else
      colog("error!");

    //
    bool bBorn = _isSymbolMoveBorn(stringSymbol);

    //月克日生或月生日克，是相敌。月破日生或月生日破是不敌等等。
    //还有月合日克或日合月克是可敌。

    bool bBalance = false;

    bool bOnDay = _isSymbolOnDay(stringSymbol);
    bool bOnMonth = _isSymbolOnMonth(stringSymbol);

    if (bOnDay || bOnMonth)
      bBalance = true;
    else {
      //生克
      bool bMonthBorn = _isSymbolMonthBorn(stringSymbol);
      bool bDayBorn = _isSymbolDayBorn(stringSymbol);
      bool bMonthRestrict = _isSymbolMonthRestrict(stringSymbol);
      bool bDayRestrict = _isSymbolDayRestrict(stringSymbol);

      //冲合
      bool bDayConflict = _isSymbolDayConflict(stringSymbol);
      bool bDayPair = _isSymbolDayPair(stringSymbol);
      bool bMonthConflict = _isSymbolMonthConflict(stringSymbol);
      bool bMonthPair = _isSymbolMonthPair(stringSymbol);

      if (bMonthRestrict) {
        bBalance = bDayBorn;
      } else if (bDayRestrict) {
        bBalance = bMonthBorn;
      } else if (bMonthConflict) {
        bBalance = bDayPair;
      } else if (bDayConflict) {
        bBalance = bMonthPair;
      } else
        bBalance = true;
    } //endi

    bResult = !bBorn && !bBalance;

    return bResult;
  }

//绝
  bool isSymbolJueAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    //个人猜测应该是日月动三者合力的结果
    //绝与帝旺相对，看此爻在三者上的绝与帝旺的差额：如果绝大于帝旺的个数
    if (easyType == EasyTypeEnum.from) {
      String fromEarth = earthAtFromRow(intRow);
      String toEarth = earthAtToRow(intRow);

      String monthTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, monthEarth());
      String dayTwelve =
          branchBusiness().earthTwelveDeity(fromEarth, dayEarth());

      String toTwelve = earthTwelveDeity(fromEarth, toEarth);

      int nValue = 0;

      if ("帝旺" == monthTwelve) nValue++;
      //else cont.

      if ("帝旺" == dayTwelve) nValue++;
      //else cont.

      if ("帝旺" == toTwelve) nValue++;
      //else cont.

      if ("绝" == monthTwelve) nValue--;
      //else cont.

      if ("绝" == dayTwelve) nValue--;
      //else cont.

      if ("绝" == toTwelve) nValue--;
      //else cont.

      bResult = nValue < 0;
    } else
      colog("error!");

    return bResult;
  }

  ///`克处逢生章第十三`//////////////////////////////////////////////////////
  bool isEffectableRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    bResult = !isSymbolOverpoweredByMonthAtRow(intRow, easyType);

    return bResult;
  }

  ///`动静生克章第十四`//////////////////////////////////////////////////////
  String movementDescriptionAtRow(int intIndex) {
    String result = "";

    if (isMovementAtRow(intIndex)) {
      result = "动";
    }

    return result;
  }

  bool isStaticEasy() {
    return fromEasyName() == toEasyName();
  }

  List staticSeasonStrong() {
    List _staticStrongArray = List();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (!isMovementAtRow(intIndex)) {
        String stringSymbol = symbolAtFromRow(intIndex);
        if (isSymbolSeasonStrong(stringSymbol))
          _staticStrongArray.add(intIndex);
        //else cont.
      }
      //else cont.
    } //endf

    return _staticStrongArray;
  }

  List moveRightArray() {
    return _inputDelegate.rowArrayAtOutRightLevel(OutRightEnum.RIGHT_MOVE);
  }

//被动爻生
  bool isSymbolBornedByMoveAtRow(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;

    if (isEffectableRow(intIndex, easyType)) {
      String stringSymbol = "";

      if (easyType == EasyTypeEnum.from)
        stringSymbol = symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = symbolAtHideRow(intIndex);
      //else cont.

      bResult = _isSymbolMoveBorn(stringSymbol);
    }
    //else cont.

    return bResult;
  }

  bool _isSymbolBorn(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String earth = _symbolEarth(stringSymbol);
      String earthOther = _symbolEarth(otherSymbol);
      bResult = isEarthBorn(earthOther, earth);
    }
    //else cont.

    return bResult;
  }

//被动爻生
  bool _isSymbolMoveBorn(String stringSymbol) {
    bool bResult = false;
    List arrayEffects = moveRightArray();
    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (_isSymbolBorn(stringSymbol, stringSymbolItem)) {
        bResult = true;
        break;
      }
      //else cont.

    } //endf
    return bResult;
  }

//被静爻生
  bool isSymbolBornedByStaticAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from) {
      if (!isMovementAtRow(intIndex)) stringSymbol = symbolAtFromRow(intIndex);
      //else cont.
    } else if (easyType == EasyTypeEnum.hide)
      stringSymbol = symbolAtHideRow(intIndex);
    else
      colog("error!");

    if ("" != stringSymbol) {
      List arrayEffects = staticSeasonStrong();

      for (int numItem in arrayEffects) {
        String stringSymbolItem = symbolAtFromRow(numItem);
        if (_isSymbolBorn(stringSymbol, stringSymbolItem)) {
          bResult = true;
          break;
        }
        //else cont.

      } //endf
    }
    //else cont.

    return bResult;
  }

//被动爻克
  bool isSymbolRestrictedByMoveAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    List arrayEffects = moveRightArray();

    String stringSymbol = "";

    if (easyType == EasyTypeEnum.from)
      stringSymbol = symbolAtFromRow(intIndex);
    else if (easyType == EasyTypeEnum.hide)
      stringSymbol = symbolAtHideRow(intIndex);
    else
      colog("error!");

    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (isEffectableRow(numItem, EasyTypeEnum.from)) {
        if (_isSymbolRestrict(stringSymbol, stringSymbolItem)) {
          bResult = true;
          break;
        }
        //else cont.
      }
      //else cont.
    } //endf
    return bResult;
  }

//被静爻克

  bool isSymbolRestrictedByStaticAtIndex(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;
    if (!isMovementAtRow(intIndex)) {
      String stringSymbol = "";
      if (easyType == EasyTypeEnum.from)
        stringSymbol = symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = symbolAtHideRow(intIndex);
      //else cont.

      if (!isSymbolSeasonStrong(stringSymbol)) {
        List arrayEffects = staticSeasonStrong();

        for (int numItem in arrayEffects) {
          String stringSymbolItem = symbolAtFromRow(numItem);
          if (_isSymbolRestrict(stringSymbol, stringSymbolItem)) {
            bResult = true;
            break;
          }
          //else cont.

        } //endf
      }
      //else cont.
    }
    //else cont.

    return bResult;
  }

  bool _isSymbolRestrict(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String stringEarth = _symbolEarth(stringSymbol);
      String stringEarthOther = _symbolEarth(otherSymbol);
      bResult = isEarthRestricts(stringEarthOther, stringEarth);
    }
    //else cont.
    return bResult;
  }

  /// `动静生克冲合章第十五`/////////////////////////////////////////////

  ///动化回头生
  bool isSymbolChangeBornAtRow(int intIndex) {
    bool bResult = false;
    if (isMovementAtRow(intIndex)) {
      String strFrom = earthAtFromRow(intIndex);
      String strTo = earthAtToRow(intIndex);
      bResult = isEarthBorn(strTo, strFrom);
    }
    //else cont.

    return bResult;
  }

  ///动化回头克
  bool isSymbolChangeRestrictAtRow(int intRow) {
    bool bResult = false;

    if (0 <= intRow && intRow <= 5) {
      String fromEarth = earthAtFromRow(intRow);
      String strTo = earthAtToRow(intRow);
      if (null != strTo) bResult = isEarthRestricts(strTo, fromEarth);
      //else cont.
    } else
      colog("error!");

    return bResult;
  }

  ///动化回头冲
  bool isSymbolChangeConflictAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    if (null != strTo) bResult = isEarthConflict(fromEarth, strTo);
    //else cont.

    return bResult;
  }

  ///`四时旺相章第又十五`//////////////////////////////////////////////////////
  String _symbolSeason(String stringSymbol) {
    return branchBusiness()
        .seasonDescription(monthEarth(), _symbolEarth(stringSymbol));
  }

  bool isSymbolSeasonStrong(String stringSymbol) {
    bool bResult = false;

    if (null != stringSymbol && "" != stringSymbol) {
      String stringSeason = _symbolSeason(stringSymbol);
      bResult = "旺" == stringSeason;
      bResult = bResult || "相" == stringSeason;
      bResult = bResult || "余气" == stringSeason;
    } else
      colog('error');

    return bResult;
  }

  bool isSymbolHealthStrong(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    double fHealth = _inputDelegate.symbolHealthAtRow(intRow, easyType);
    if (null != fHealth)
      bResult = fHealth > _inputDelegate.healthCriticalValue();
    else
      colog('error');

    return bResult;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////
  String monthElement() {
    return earthElement(monthEarth());
  }

  bool _isSymbolOnMonth(String stringSymbol) {
    return monthEarth() == _symbolEarth(stringSymbol);
  }

  bool isEarthPairMonth(String basicEarth, String monthEarth) {
    bool bResult = false;

    String strPair = earthSixPair(basicEarth);

    bResult = strPair == monthEarth;

    return bResult;
  }

  bool isEarthOnMonth(String basicEarth, String monthEarth) {
    return monthEarth == basicEarth;
  }

  bool _isSymbolMonthBorn(String stringSymbol) {
    String strMonth = monthEarth();

    String strEarth = _symbolEarth(stringSymbol);

    bool bBorn = isEarthBorn(strMonth, strEarth);

    return bBorn;
  }

  bool _isSymbolMonthRestrict(String stringSymbol) {
    String strMonth = monthEarth();

    String strEarth = _symbolEarth(stringSymbol);
    bool bRestricted = isEarthRestricts(strMonth, strEarth);

    return bRestricted;
  }

  bool _isSymbolMonthConflict(String stringSymbol) {
    String strMonth = monthEarth();

    String strEarth = _symbolEarth(stringSymbol);

    bool bConflicted = isEarthConflict(strMonth, strEarth);

    return bConflicted;
  }

  bool isMovementStrongAtRow(int intRow) {
    //月建以下情况之一，不能克伤动爻；
    bool bResult = false;

    String stringSymbol = symbolAtFromRow(intRow);
    String strEarth = earthAtFromRow(intRow);

    //1 临日建，日生。
    String strDay = dayEarth();
    bool bOnDay = _isSymbolOnDay(stringSymbol);
    bool bBornByDay = isEarthBorn(strDay, strEarth);

    //2 动变回头生。
    bool bBornByChange = isSymbolChangeBornAtRow(intRow);

    //3 动变进。
    bool bChangeForward = isSymbolChangeForwardAtRow(intRow);

    //4 有旺动爻生。

    bool bBornByMoving = false;
    List arrayEffects = [0, 1, 2, 3, 4, 5];
    List arrayMovement = movementArrayInArray(arrayEffects);
    for (int numItem in arrayMovement) {
      String stringSymbol = symbolAtFromRow(numItem);
      String season = _symbolSeason(stringSymbol);
      if ("旺" == season) {
        String moveEarth = earthAtFromRow(numItem);
        if (isEarthBorn(moveEarth, strEarth)) {
          bBornByMoving = false;
          break;
        }
        //else cont.
      }
      //else cont.

    } //endf

    bResult = bOnDay ||
        bBornByDay ||
        bBornByChange ||
        bChangeForward ||
        bBornByMoving;

    return bResult;
  }

//月建亦能制服动爻
  bool isSymbolOverpoweredByMonthAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    String stringSymbol = symbolAtRow(intRow, easyType);

    String strEarth = _symbolEarth(stringSymbol);
    String strMonth = monthEarth();
    bool bRestricted = isEarthRestricts(strMonth, strEarth);
    if (bRestricted) {
      if (easyType == EasyTypeEnum.from) {
        if (isMovementAtRow(intRow)) {
          bResult = !isMovementStrongAtRow(intRow);
        }
        //else cont.
      }
      //else cont.
    }
    //else cont.

    return bResult;
  }

  /// `日辰章第十七`/////////////////////////////////////////////
  String dayElement() {
    return earthElement(dayEarth());
  }

  bool isEarthOnDay(String basicEarth, String dayEarth) {
    return dayEarth == basicEarth;
  }

  bool isConflictDayEarth(String basicEarth, String dayEarth) {
    bool result = false;

    result = isEarthConflict(basicEarth, dayEarth);

    return result;
  }

  bool isSymbolConflictDayAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (0 <= intRow && intRow < 6) {
      String stringSymbol = symbolAtRow(intRow, easyType);
      if (bResult) {
        bResult = _isSymbolDayConflict(stringSymbol);
      }
    } else
      colog("error!");

    return bResult;
  }

  bool _isSymbolDayBorn(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = _symbolEarth(stringSymbol);

    bool bBorn = isEarthBorn(strDayEarth, strEarth);

    return bBorn;
  }

  bool _isSymbolDayRestrict(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = _symbolEarth(stringSymbol);
    bool bRestricted = isEarthRestricts(strDayEarth, strEarth);

    return bRestricted;
  }

  bool _isSymbolDayConflict(String stringSymbol) {
    String strDayEarth = dayEarth();

    String strEarth = _symbolEarth(stringSymbol);

    bool bConflicted = isEarthConflict(strDayEarth, strEarth);

    return bConflicted;
  }

//冲衰弱之静爻则为日破
  bool isSymbolDayBrokenAtRow(int intRow, EasyTypeEnum easyType) {
    bool result = false;

    if (!isSymbolHealthStrong(intRow, easyType)) {
      String strDay = dayEarth();
      if (!inputEasyWordsModel().isMovementAtRow(intRow)) {
        result = isEarthConflict(
            strDay, inputEasyWordsModel().getSymbolEarth(intRow, easyType));
      }
      //else cont.
    }
    //else cont.

    return result;
  }

//冲衰弱之静爻则为日破
  DayConflictEnum _symbolDayConflictState(int intRow, EasyTypeEnum easyType) {
    DayConflictEnum nResult = DayConflictEnum.Conflict_NO;
    String stringSymbol = inputEasyWordsModel().getSymbolName(intRow, easyType);
    bool bConflict = branchBusiness().isEarthConflict(
        dayEarth(), inputEasyWordsModel().getSymbolEarth(intRow, easyType));
    if (bConflict) {
      nResult = DayConflictEnum.Conflict_YES;

      if (inputEasyWordsModel().isMovementAtRow(intRow)) {
        if (isSymbolSeasonStrong(stringSymbol))
          nResult = DayConflictEnum.Conflict_SAN;
        else
          nResult = DayConflictEnum.Conflict_SAN;
      } else {
        if (isSymbolSeasonStrong(stringSymbol))
          nResult = DayConflictEnum.Conflict_BackMove;
        else
          nResult = DayConflictEnum.Conflict_BROKEN;
      } //endi
    }
    //else cont.

    return nResult;
  }

  bool _isSymbolOnDay(String stringSymbol) {
    return isEarthOnDay(_symbolEarth(stringSymbol), dayEarth());
  }

  ///`六合章第十九`//////////////////////////////////////////////////////

//六合卦
  bool _isEasySixPair(Map easyDictionary) {
    bool bResult = false;

    List symbolPairArray = [];

    List dataArray = easyDictionary["data"];

    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = _symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = _symbolEarth(dataArray[indexOther]);
          String strPair =
              branchBusiness().sixPairDescription(basicEarth, otherEarth);
          if ("" != strPair) {
            if (-1 == symbolPairArray.indexOf(index))
              symbolPairArray.add(index);
            //else cont.

            if (-1 == symbolPairArray.indexOf(indexOther))
              symbolPairArray.add(indexOther);
            //else cont.

            break;
          }
        }
        //else cont.

      } //endf
    } //endf

    bResult = (6 == symbolPairArray.length);

    return bResult;
  }

  bool isPairSymbolAtRow(int intRow, int nOtherRow) {
    bool bResult = false;

    String strPair = branchBusiness().earthSixPair(earthAtFromRow(intRow));

    bResult = (strPair == earthAtFromRow(nOtherRow));

    return bResult;
  }

/*
 比如男人自测婚姻
 世：自己
 生世：自己父母
 克世：自己的限制条件
 
 用神：这家事情本身
 元神：有利条件
 忌神：限制条件
 
 应：对方
 生应：对方父母
 克应：对方的限制条件
 */

  ///`--爻的六合分析`//////////////////////////////////////////////////////
  bool _isSymbolDayPair(String stringSymbol) {
    String strEarth = _symbolEarth(stringSymbol);

    return branchBusiness().isEarthPairDay(strEarth, dayEarth());
  }

  bool _isSymbolMonthPair(String stringSymbol) {
    String strEarth = _symbolEarth(stringSymbol);

    bool bResult = isEarthPairMonth(strEarth, monthEarth());

    return bResult;
  }

  ///`--爻的三合`//////////////////////////////////////////////////////

  List virtualEarthThreePair(List arrayPair, List arrayRow) {
    List arrayResult = [];

    List arrayEarth = inputEasyWordsModel().earthAtMergeRowArray(arrayRow);

    List arrayRowPaired = [];
    for (String item in arrayPair) {
      if (-1 != arrayEarth.indexOf(item)) {
        arrayRowPaired.add(arrayEarth.indexOf(item));
      }
      //else cont.
    } //endf

    if (arrayRowPaired.length == 3) {
      List movementArray = moveRightArray();

      for (String item in arrayRowPaired) {
        if (-1 == movementArray.indexOf(item)) arrayResult.add(item);
        //else cont.
      } //endf
    }
    //else cont.

    return arrayResult;
  }

  ///`六冲章第二十`//////////////////////////////////////////////////////
  bool _isEasySixConflict(Map easyDictionary) {
    bool bResult = false;

    List conflictArray = [];

    List dataArray = easyDictionary["data"];
    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = _symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = _symbolEarth(dataArray[indexOther]);
          if (isEarthConflict(basicEarth, otherEarth)) {
            conflictArray.add(index);
            break;
          }
        }
        //else cont.

      } //endf
    } //endf

    bResult = (6 == conflictArray.length);

    return bResult;
  }

  ///`暗动章第二十二`//////////////////////////////////////////////////////

//暗动
  bool isSymbolBackMoveAtRow(int intRow, EasyTypeEnum easyType) {
    bool result = false;
    if (!isMovementAtRow(intRow)) {
      if (isSymbolConflictDayAtRow(intRow, easyType)) {
        result = isSymbolHealthStrong(intRow, easyType);
      }
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`卦变生克墓绝章第二十四`/////////////////////////////////////////////////////
  String easyParent() {
    String fromElement = inputEasyWordsModel().stringFromElement;
    String toElement = inputEasyWordsModel().stringToElement;
    String strParent = SABElementModel.elementRelative(fromElement, toElement);
    return strParent;
  }

  ///`反伏章第二十五`//////////////////////////////////////////////////////////////
  bool isEasyRepeatedGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyWihtInRepeated() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyOutsideRepeated() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length == 0 && outMovementArray.length > 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyRestricts() {
    //反吟
    bool bResult = false;
    //卦化对冲

    Map dictGuaConflict = {
      "乾": "巽",
      "坤": "艮",
      "坎": "离",
      "离": "坎",
      "巽": "乾",
      "震": "兑",
      "艮": "坤",
      "兑": "震",
    };

    String fromPlace = inputEasyWordsModel().stringFromPlace;
    String toPlace = inputEasyWordsModel().stringToPlace;
    String strConflictPlace = dictGuaConflict[fromPlace];
    bResult = strConflictPlace == toPlace;
    return bResult;
  }

  bool isEasyRestrictsGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyWihtInRestricts() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyOutsideRestricts() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = inputEasyWordsModel().inGuaMovementArray();

    List outMovementArray = inputEasyWordsModel().outGuaMovementArray();

    if (inMovementArray.length == 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasySame() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = true;

    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (earthAtFromRow(intIndex) != earthAtToRow(intIndex)) {
        bResult = false;
        break;
      }
      //else cont.

    } //endf

    return bResult;
  }

  /// `--爻之反吟伏吟`///////////////////////////////////////////////////////////
  bool isMovementSame(List movementArray) {
    bool bResult = true;
    for (int intIndex in movementArray) {
      if (earthAtFromRow(intIndex) != earthAtToRow(intIndex)) {
        bResult = false;
        break;
      }
      //else cont.
    } //endf

    return bResult;
  }
//
//bool  isSymbolRepeated
//{
//    //爻伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length > 0 && outMovementArray.length > 0)
//        bResult = [self isMovementSame:inMovementArray] && [self isMovementSame:outMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//
//bool  isSymbolWihtInRepeated
//{
//    //内卦伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length > 0 && outMovementArray.length == 0)
//        bResult = [self isMovementSame:inMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//bool  isSymbolOutsideRepeated
//{
//    //外卦伏吟
//    bool bResult = false;
//
//    List inMovementArray = inGuaMovementArray();
//
//    List outMovementArray = outGuaMovementArray();
//
//    if ( inMovementArray.length == 0 && outMovementArray.length > 0)
//        bResult = [self isMovementSame:outMovementArray];
//    //else cont.
//
//    return bResult;
//}
//
//bool  isMovementRestricts:(List)movementArray
//{
//    //反吟
//    bool bResult = true;
//
//    for (NSNumber* numIndex in movementArray)
//    {
//        int  intIndex  = [numIndex integerValue];
//        String fromEarth = earthAtFromRow(intIndex);
//        String toEarth = earthAtToRow(intIndex ];
//        if (![self isEarthConflict:fromEarth ,toEarth])
//        {
//            bResult = false;
//            break;
//        }
//        //else cont.
//    }//endf
//
//    return bResult;
//
//    return bResult;
//}
//

  /// `--旬空章第二十六`///////////////////////////////////////////////////////////

  EmptyEnum _symbolBasicEmptyState(String stringSymbol) {
    EmptyEnum nResult = EmptyEnum.Empty_False;
    if ("" != stringSymbol) {
      String earth = _symbolEarth(stringSymbol);
      if (-1 != emptyEarth().indexOf(earth)) {
        String strDay = dayEarth();
        if (isEarthConflict(strDay, earth)) {
          //爻遇旬空，日辰冲起而为用，谓之冲空则实。
          nResult = EmptyEnum.Empty_Conflict;
        } else
          nResult = EmptyEnum.Empty_YES;
      }
      //else cont.
    } else
      nResult = EmptyEnum.Empty_NoUseful;
    //colog("用神为空");

    return nResult;
  }

  EmptyEnum symbolEmptyState(int intRow, EasyTypeEnum easyType) {
    EmptyEnum nResult = EmptyEnum.Empty_False;

    String stringSymbol = symbolAtRow(intRow, easyType);

    if ("" != stringSymbol) {
      String earth = _symbolEarth(stringSymbol);
      if (-1 != emptyEarth().indexOf(earth)) {
        String strDay = dayEarth();
        if (isEarthConflict(strDay, earth)) {
          //爻遇旬空，日辰冲起而为用，谓之冲空则实。
          nResult = EmptyEnum.Empty_Conflict;
        } else if (isFalseEmptyAtRow(intRow, easyType)) {
          nResult = EmptyEnum.Empty_False;
        } else if (isRealEmpty(intRow, easyType)) {
          nResult = EmptyEnum.Empty_Real;
        } else {
          nResult = EmptyEnum.Empty_YES;
        }
      }
      //else cont.
    } else
      colog("error!");

    return nResult;
  }

  bool isEmptyAtRow(int intRow, EasyTypeEnum easyType) {
    String stringSymbol = symbolAtRow(intRow, easyType);
    bool bResult = _symbolBasicEmptyState(stringSymbol) == EmptyEnum.Empty_YES;

    return bResult;
  }

  bool isSymbolChangeEmpty(int intIndex) {
    bool bResult = false;
    if (isMovementAtRow(intIndex)) {
      bResult = isEmptyAtRow(intIndex, EasyTypeEnum.to);
    }
    //else cont.

    return bResult;
  }

  bool isRealEmpty(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;
    /*
     月破为空，
     有气不动亦为空，
     伏而被克亦为空，
     真空为空，真空者，春土夏金秋是木，三冬逢火是真空。
     */
    String stringSymbol = symbolAtRow(intRow, easyType);

    //月破为空
    MonthConflictEnum stateEmpty =
        _symbolConflictStateOnMonth(intRow, easyType);

    if (MonthConflictEnum.Conflict_NO == stateEmpty ||
        MonthConflictEnum.Conflict_Move == stateEmpty ||
        MonthConflictEnum.Conflict_MoveBorn == stateEmpty) {
    } else
      bResult = true;

    //有气不动亦为空
    String stringSymbolSeason = _symbolSeason(stringSymbol);
    bool bWang = ("旺" == stringSymbolSeason) || ("相" == stringSymbolSeason);

    bool bMove = inputEasyWordsModel().isMovementAtRow(intRow);
    if (!bMove && !bWang) bResult = true;
    //else cont.

    //伏而被克亦为空
    if (easyType == EasyTypeEnum.hide) {
      String fromSymbol = symbolAtFromRow(intRow);
      _isSymbolRestrict(stringSymbol, fromSymbol);
    }
    //else cont.

    //真空为空，真空者，春土夏金秋是木，三冬逢火是真空。
    bool bRealEmpty = "死" == _symbolSeason(stringSymbol);
    if (bRealEmpty) bResult = true;
    return bResult;
  }

  bool isFalseEmptyAtRow(int intRow, EasyTypeEnum easyType) {
    /*
     旺不为空；
     动不为空；
     有日建动爻生扶者，亦不为空；
     动而化空，
     伏而旺相皆不为空。
     */
    bool bResult = false;

    String stringSymbol = symbolAtRow(intRow, easyType);
    String strSeason = _symbolSeason(stringSymbol);

    //旺不为空；
    bResult = bResult || "旺" == strSeason;

    if (easyType == EasyTypeEnum.from) {
      bool bMove = inputEasyWordsModel().isMovementAtRow(intRow);

      //动不为空；
      bResult = bResult || bMove;
    }
    //else cont.

    //有日建生扶者，亦不为空；
    bool bDayBorn = _isSymbolDayBorn(stringSymbol);
    bResult = bResult || bDayBorn;

    if (easyType == EasyTypeEnum.from || easyType == EasyTypeEnum.hide) {
      //有动爻生扶者，亦不为空；
      bool bMoveBorn = _isSymbolMoveBorn(stringSymbol);
      bResult = bResult || bMoveBorn;
    }
    //else cont.

    if (easyType == EasyTypeEnum.from) {
      //动而化空
      bool bChangeEmpty = isSymbolChangeEmpty(intRow);
      bResult = bResult || bChangeEmpty;
    }
    //else cont.

    if (easyType == EasyTypeEnum.hide) {
      //伏而旺相皆不为空
      bool bHideStrong = isHideSymbolSeasonStrong(intRow);
      bResult = bResult || bHideStrong;
    }
    //else cont.

    return bResult;
  }

  bool isHideSymbolSeasonStrong(int intRow) {
    String stringSymbol = symbolAtHideRow(intRow);
    return isSymbolSeasonStrong(stringSymbol);
  }

  String emptyEarth() {
    String strResult = "";

    String strSkyTrunk = skyTrunkString();
    String strDayTrunk = daySky();
    int indexTrunk = strSkyTrunk.indexOf(strDayTrunk);

    String strEarthBranch = earthBranchString();
    String strDayBranch = dayEarth();
    int indexBranch = strEarthBranch.indexOf(strDayBranch);

    int leftTrunk = strSkyTrunk.length - (indexTrunk + strDayTrunk.length);

    int leftBranch = (indexBranch + strDayBranch.length) + leftTrunk;

    int emptyLocation = leftBranch % 12;

    if (strEarthBranch.length >= 2)
      strResult = strEarthBranch.substring(emptyLocation, emptyLocation + 2);
    else
      colog("error!");

    return strResult;
  }

  ///`生旺墓绝章第又二十六`//////////////////////////////////////////////////////
  bool isSymbolChangeMuAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = earthAtFromRow(intRow);
    String strTo = earthAtToRow(intRow);
    String strTwelve = earthTwelveDeity(fromEarth, strTo);
    bResult = "墓" == strTwelve;
    return bResult;
  }

//随鬼入墓
  bool isSymbol_SuiGuiRuMu_AtRow(int intRow) {
    bool bResult = false;
    String strParent =
        inputEasyWordsModel().getSmbolParent(intRow, EasyTypeEnum.from);
    bool bGui = "官鬼" == strParent;
    bool bRuMu = isSymbolChangeMuAtRow(intRow);

    bResult = bGui && bRuMu;

    return bResult;
  }

  ///`月破章第二十七`//////////////////////////////////////////////////////
  MonthConflictEnum _symbolConflictStateOnMonth(
      int intRow, EasyTypeEnum easyTypeEnum) {
    String stringSymbol =
        inputEasyWordsModel().getSymbolName(intRow, easyTypeEnum);
    MonthConflictEnum nResult = MonthConflictEnum.Conflict_NO;
    String basicEarth = _symbolEarth(stringSymbol);
    bool conflictMonth = isEarthConflict(basicEarth, monthEarth());
    if (conflictMonth) {
      nResult = MonthConflictEnum.Conflict_Broken;

      String strDayEarth = dayEarth();
      if (strDayEarth == basicEarth)
        nResult = MonthConflictEnum.Conflict_OnDay;
      else if (inputEasyWordsModel().isMovementAtRow(intRow)) {
        nResult = MonthConflictEnum.Conflict_Move;
      } else {
        //唯静而不动，又无日辰动爻生助，实则到底而破矣。
        if (branchBusiness().isEarthBorn(dayEarth(), basicEarth)) {
          nResult = MonthConflictEnum.Conflict_DayBorn;
        } else if (_isSymbolMoveBorn(stringSymbol)) {
          nResult = MonthConflictEnum.Conflict_MoveBorn;
        }
        //else cont.
      } //endi
    }
    //else cont.

    return nResult;
  }

  ///`飞伏章第二十八`//////////////////////////////////////////////////////

  bool isHideSymbolAtRow(int intIndex) {
    return usefulDeityRow() - ROW_FLY_BEGIN == intIndex;
  }

  bool isHideDeityInvalidAtRow(int intRow) {
    bool bResult = false;
    /*
     又伏神终不得出者有五。
     伏神休囚无气者，一也。
     伏神被日月冲克者，二也。
     伏神被旺相之飞神克害者，三也。
     伏神墓绝于日月飞爻者，四也。
     伏神休囚值旬空月破者，五也。
     此五者乃无用之伏神也，虽有如无，终不能出。
     
     */

    String basicSymbol = symbolAtHideRow(intRow);
    if (null != basicSymbol && "" != basicSymbol) {
      //伏神休囚无气者，一也。
      bool bStrong = isSymbolHealthStrong(
          intRow, EasyTypeEnum.hide); //isSymbolSeasonStrong(basicSymbol);
      if (!bStrong) {
        bResult = true;
      } else {
        //伏神被日月冲克者，二也。
        bool bFromDayConflict = DayConflictEnum.Conflict_NO !=
            _symbolDayConflictState(intRow, EasyTypeEnum.hide);
        bool bFromMonthConflict = MonthConflictEnum.Conflict_NO !=
            _symbolConflictStateOnMonth(intRow, EasyTypeEnum.hide);
        bool bFromMonthRestrict = _isSymbolMonthRestrict(basicSymbol);
        bool bFromDayRestrict = _isSymbolDayRestrict(basicSymbol);

        if (bFromDayConflict ||
            bFromMonthConflict ||
            bFromMonthRestrict ||
            bFromDayRestrict) {
          bResult = true;
        } else {
          //伏神被旺相之飞神克害者，三也。
          String fromSymbol = symbolAtFromRow(intRow);
          String strRelative = _symbolRelative(intRow);
          bool bFromStrong = isSymbolSeasonStrong(basicSymbol);
          if ("官鬼" == strRelative && bFromStrong) {
            bResult = true;
          } else {
            //伏神墓绝于日月飞爻者，四也。
            String basicEarth = _symbolEarth(basicSymbol);
            String fromEarth =
                inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);

            String monthTwelve =
                branchBusiness().earthTwelveDeity(basicEarth, monthEarth());
            String dayTwelve =
                branchBusiness().earthTwelveDeity(basicEarth, dayEarth());
            String fromTwelve = earthTwelveDeity(basicEarth, fromEarth);
            if (null != monthTwelve ||
                null != dayTwelve ||
                null != fromTwelve) {
              bResult = true;
            } else {
              //伏神休囚值旬空月破者，五也。

              bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.hide);
              bool bMonthBroken = MonthConflictEnum.Conflict_Broken ==
                  _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
              if (bEmpty || bMonthBroken || !bStrong) {
                bResult = true;
              }
              //else cont.
            }
          } //endi
        } //endi
      } //endi
    }
    //else cont.

    return bResult;
  }

  bool isHideDeityValidAtRow(int intRow) {
    bool bResult = false;
    /*
     伏神有用者有六；
     伏神得日月者，一也。
     伏神旺相者，二也。
     伏神得飞神生者，三也。
     伏神得动爻生者，四也。
     伏神得遇日月动爻冲克飞神者，五也。
     伏神得遇飞神空破休囚墓绝者，六也。
     */

    //伏神得日月者，一也。
    String basicSymbol = symbolAtHideRow(intRow);
    if (null != basicSymbol && "" != basicSymbol) {
      bool bOnDay = _isSymbolOnDay(basicSymbol);
      bool bOnMonth = _isSymbolOnMonth(basicSymbol);
      if (bOnDay || bOnMonth) {
        bResult = true;
      } else {
        //伏神旺相者，二也。
        if (isSymbolHealthStrong(
            intRow, EasyTypeEnum.hide)) //;isSymbolSeasonStrong(basicSymbol]
        {
          bResult = true;
        } else {
          //伏神得飞神生者，三也。
          String fromSymbol = symbolAtFromRow(intRow);
          String strRelative = _symbolRelative(intRow);
          if ("父母" == strRelative) {
            bResult = true;
          } else {
            //伏神得动爻生者，四也。
            if (_isSymbolMoveBorn(basicSymbol)) {
              bResult = true;
            } else {
              //伏神得遇日月动爻冲克飞神者，五也。
              bool bFromDayConflict = DayConflictEnum.Conflict_NO !=
                  _symbolDayConflictState(intRow, EasyTypeEnum.from);
              bool bFromMonthConflict = MonthConflictEnum.Conflict_NO !=
                  _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
              bool bFromMoveConflict = _isSymbolMoveConflict(fromSymbol);
              bool bFromMonthRestrict = _isSymbolMonthRestrict(fromSymbol);
              bool bFromDayRestrict = _isSymbolDayRestrict(fromSymbol);
              bool bFromMoveRestrict =
                  isSymbolRestrictedByMoveAtIndex(intRow, EasyTypeEnum.from);

              if (bFromDayConflict ||
                  bFromMonthConflict ||
                  bFromMoveConflict ||
                  bFromMonthRestrict ||
                  bFromDayRestrict ||
                  bFromMoveRestrict) {
                bResult = true;
              } else {
                //伏神得遇飞神空破休囚墓绝者，六也。
                bool bFromEmpty = isEmptyAtRow(intRow, EasyTypeEnum.hide);
                bool bFromMonthBroken = MonthConflictEnum.Conflict_Broken ==
                    _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from);
                bool bFromDayBroken = DayConflictEnum.Conflict_BROKEN ==
                    _symbolDayConflictState(intRow, EasyTypeEnum.from);
                bool bFromStrong = isSymbolSeasonStrong(fromSymbol);

                bool bFromMu = isSymbolMuAtRow(intRow, EasyTypeEnum.from);
                bool bFromJue = isSymbolJueAtRow(intRow, EasyTypeEnum.from);
                if (bFromEmpty ||
                    bFromMonthBroken ||
                    bFromDayBroken ||
                    !bFromStrong ||
                    bFromMu ||
                    bFromJue) {
                  bResult = true;
                }
                //else cont.

              } //endi
            } //endi
          } //endi
        } //endi
      } //endi
    }
    //else cont.

    return bResult;
  }

  bool _isSymbolMoveConflict(String stringSymbol) {
    bool bResult = false;

    List arrayEffects = moveRightArray();

    for (int numItem in arrayEffects) {
      String stringSymbolItem = symbolAtFromRow(numItem);
      if (isEffectableRow(numItem, EasyTypeEnum.from)) {
        if (isEarthConflict(
            _symbolEarth(stringSymbol), _symbolEarth(stringSymbolItem))) {
          bResult = true;
          break;
        }
        //else cont.
      }
      //else cont.
    } //endf
    return bResult;
  }

  List usefulDeityHideRowArray() {
    List usefulArray = [];
    String usefulParent = getUsefulDeity();

    if (null != usefulParent) {
      usefulArray = arrayRowWithParent(usefulParent, EasyTypeEnum.hide);
    }
    //else cont.

    return usefulArray;
  }

  ///`进神退神章第二十九`//////////////////////////////////////////////////////
  String symbolForwardOrBack(int nRow) {
    String result = "";
    String fromEarth =
        inputEasyWordsModel().getSymbolEarth(nRow, EasyTypeEnum.from);
    String toEarth =
        inputEasyWordsModel().getSymbolEarth(nRow, EasyTypeEnum.to);
    if (branchBusiness().isEarthForward(fromEarth, toEarth))
      result = "化进";
    else if (branchBusiness().isEarthBack(fromEarth, toEarth)) result = "化退";
    //else cont.

    return result;
  }

  bool isSymbolChangeForwardAtRow(int nRow) {
    bool bResult = false;
    if (isMovementAtRow(nRow)) {
      String fromEarth = earthAtFromRow(nRow);
      String toEarth = earthAtToRow(nRow);
      bResult = branchBusiness().isEarthForward(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolChangeBackAtRow(int intIndex) {
    bool bResult = false;
    if (isMovementAtRow(intIndex)) {
      String fromEarth = earthAtFromRow(intIndex);
      String toEarth = earthAtToRow(intIndex);
      bResult = branchBusiness().isEarthBack(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  ///`两现章第三十二`//////////////////////////////////////////////////////
  List usefulDeityRowArray() {
    List usefulArray = [];
    String usefulParent = getUsefulDeity();

    if (null != usefulParent) {
      usefulArray = arrayRowWithParent(usefulParent, EasyTypeEnum.from);
    }
    //else cont.

    return usefulArray;
  }

  int indexOfUseDeityInEasy(EasyTypeEnum easyTypeEnum) {
    int result = globalRowInvalid;

    String usefulParent = getUsefulDeity();

    if (null != usefulParent) {
      List usefulArray = arrayRowWithParent(usefulParent, easyTypeEnum);

      if (usefulArray.length == 1) {
        result = usefulArray[0];
      } else if (usefulArray.length == 0) {
        result = noUsefulDeity();
      } else {
        result = multiUsefulDeity(easyTypeEnum, usefulArray);
      } //endi
    }
    //else cont.

    return result;
  }

  int noUsefulDeity() {
    int result = globalRowInvalid;

    String usefulParent = getUsefulDeity();

    String fromEasyElement = inputEasyWordsModel().stringFromElement;

    String stringMonthElement = monthElement();
    String monthParent =
        SABElementModel.elementRelative(fromEasyElement, stringMonthElement);
    if (monthParent == usefulParent) {
      result = ROW_MONTH;
    } else {
      String stringDayElement = dayElement();
      String dayParent =
          SABElementModel.elementRelative(fromEasyElement, stringDayElement);
      if (dayParent == usefulParent) {
        result = ROW_DAY;
      } else {
        result = ROW_FLY_BEGIN + indexOfUseDeityInEasy(EasyTypeEnum.hide);
      } //endi
    } //endi

    return result;
  }

/****************************************************************
 古法：舍其月破而用不破；     野鹤：舍其不破而用月破(采用)；
 舍其旬空而用不空；          野鹤：舍其不空而用旬空；
 舍其静爻而用动爻；
 舍其休囚而用旺相；
 舍其被伤而用不伤。
 ****************************************************************/

  int multiUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = globalRowInvalid;

    List listMonthBroken = monthBrokenArray(easyTypeEnum, usefulArray);
    if (0 == listMonthBroken.length) {
      result = emptyUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == listMonthBroken.length) {
      result = listMonthBroken[0];
    } else if (listMonthBroken.length > 1) {
      result = emptyUsefulDeity(easyTypeEnum, listMonthBroken);
    }
    return result;
  }

  int emptyUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = globalRowInvalid;

    List listEmpty = emptyArray(easyTypeEnum, usefulArray);

    if (0 == listEmpty.length) {
      result = movementUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == listEmpty.length) {
      result = listEmpty[0];
    } else if (listEmpty.length > 1) {
      result = movementUsefulDeity(easyTypeEnum, listEmpty);
    }

    return result;
  }

  int movementUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = globalRowInvalid;

    List movementArray = movementArrayInArray(usefulArray);
    if (0 == movementArray.length) {
      result = strongUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == movementArray.length) {
      result = movementArray[0];
    } else if (movementArray.length > 1) {
      result = strongUsefulDeity(easyTypeEnum, movementArray);
    }
    return result;
  }

  int strongUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = globalRowInvalid;

    //旺、相、余气, 依次选用,有旺用旺，如果有多个旺，通过动静区分；

    List strongArray = strongUsefulArray(easyTypeEnum, usefulArray);

    if (0 == strongArray.length) {
      result = lifeOrGoalUsefulDeity(easyTypeEnum, usefulArray);
    } else if (1 == strongArray.length) {
      result = strongArray[0];
    } else if (strongArray.length > 1) {
      result = lifeOrGoalUsefulDeity(easyTypeEnum, strongArray);
    }

    return result;
  }

  int lifeOrGoalUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = globalRowInvalid;

    //世爻位置上的用神
    int lifeIndex = getLifeIndex();

    for (int intItem in usefulArray) {
      if (lifeIndex == intItem) {
        result = lifeIndex;
        break;
      }
      //else cont.
    } //endf

    if (globalRowInvalid == result) {
      //应爻位置上的用神
      int goalIndex = getGoalIndex();

      for (int intItem in usefulArray) {
        if (goalIndex == intItem) {
          result = goalIndex;
          break;
        }
        //else cont.
      } //endf
    }
    //else cont.

    if (globalRowInvalid == result) {
      result = unKnowUsefulDeity(easyTypeEnum, usefulArray);
    }
    //else cont.

    return result;
  }

  int unKnowUsefulDeity(EasyTypeEnum easyTypeEnum, List usefulArray) {
    int result = usefulArray[0]; //globalRowInvalid;

    //TODO:丰富用神的选取规则：按旺相休囚死的顺序排列；或者按照强弱顺序排序。
    //其实此时应该已经知道用神衰弱，事情很难成功。
    //    colog("error!");

    return result;
  }

  List strongUsefulArray(EasyTypeEnum easyTypeEnum, List usefulArray) {
    //舍其休囚而用旺相；
    List strongArray = List();

    double maxValue = -10000;

    for (int intItem in usefulArray) {
      double strongValue =
          _inputDelegate.symbolHealthAtRow(intItem, easyTypeEnum);
      if (maxValue < strongValue) {
        maxValue = strongValue;
      }
      //else cont.
    } //endf

    for (int intItem in usefulArray) {
      double strongValue =
          _inputDelegate.symbolHealthAtRow(intItem, easyTypeEnum);
      if (strongValue == maxValue) {
        strongArray.add(intItem);
      }
      //else cont.

    } //endi

    return strongArray;
  }

  List emptyArray(EasyTypeEnum easyTypeEnum, List usefulArray) {
    //舍其旬空而用不空；          野鹤：舍其不空而用旬空；
    List listEmpty = List();
    for (int intRow in usefulArray) {
      String stringSymbol =
          inputEasyWordsModel().getSymbolName(intRow, easyTypeEnum);
      if (_symbolBasicEmptyState(stringSymbol) != EmptyEnum.Empty_NO) {
        listEmpty.add(intRow);
      }
      //else cont.
    } //endf

    return listEmpty;
  }

  List movementArrayInArray(List usefulArray) {
    //舍其静爻而用动爻；
    List movementArray = List();
    for (int intItem in usefulArray) {
      if (isMovementAtRow(intItem)) {
        movementArray.add(intItem);
      }
      //else cont.
    } //endf

    return movementArray;
  }

  List monthBrokenArray(EasyTypeEnum easyTypeEnum, List usefulArray) {
    //古法：舍其月破而用不破；     野鹤：舍其不破而用月破(采用)；
    List listMonthBroken = List();
    for (int intRow in usefulArray) {
      if (MonthConflictEnum.Conflict_NO !=
          _symbolConflictStateOnMonth(intRow, easyTypeEnum))
        listMonthBroken.add(intRow);
      //else cont.

    } //endf

    return listMonthBroken;
  }

  ///`earthBranch 桥函数`//////////////////////////////////////////////////////
  String earthSixPair(String earth) {
    return branchBusiness().earthSixPair(earth);
  }

  String getSixConflict(String basicEarth) {
    return branchBusiness().getSixConflict(basicEarth);
  }

  bool isEarthBorn(String earth, String basicEarth) {
    return branchBusiness().isEarthBorn(earth, basicEarth);
  }

  String earthElement(String earth) {
    return branchBusiness().earthElement(earth);
  }

  bool isEarthRestricts(String earth, String basicEarth) {
    return branchBusiness().isEarthRestricts(earth, basicEarth);
  }

  String earthTwelveDeity(String itemEarth, String atEarth) {
    return branchBusiness().earthTwelveDeity(itemEarth, atEarth);
  }

  bool isEarthConflict(String basicEarth, String otherEarth) {
    return branchBusiness().isEarthConflict(basicEarth, otherEarth);
  }

  String sixPairDescription(String basicEarth, String otherEarth) {
    return branchBusiness().sixPairDescription(basicEarth, otherEarth);
  }

  String seasonDescription(String monthEarth, String _earthName) {
    return branchBusiness().seasonDescription(monthEarth, _earthName);
  }

  ///`EasyBusiness 桥函数`//////////////////////////////////////////////////////
  String _symbolEarth(String stringSymbol) {
    return easyBusiness().symbolEarth(stringSymbol);
  }

  Map _fromEasyDictionary() {
    return inputEasyWordsModel().mapFromEasy;
  }

  Map _toEasyDictionary() {
    return inputEasyWordsModel().mapToEasy;
  }

  String fromEasyName() {
    return inputEasyWordsModel().stringFromName;
  }

  String toEasyName() {
    return inputEasyWordsModel().stringToName;
  }

  String fromEasyKey() {
    return inputEasyWordsModel().inputDigitModel.fromEasyKey();
  }

  String toEasyKey() {
    return inputEasyWordsModel().inputDigitModel.toEasyKey();
  }

  String getUsefulDeity() {
    return inputEasyWordsModel().inputDigitModel.getUsefulDeity();
  }

  int getLifeIndex() {
    return inputEasyWordsModel().getLifeIndex();
  }

  int getGoalIndex() {
    return inputEasyWordsModel().getGoalIndex();
  }

  String symbolAtRow(int intRow, EasyTypeEnum enumEasyType) {
    return inputEasyWordsModel().getSymbolName(intRow, enumEasyType);
  }

  String symbolAtFromRow(int intRow) {
    return inputEasyWordsModel().getSymbolName(intRow, EasyTypeEnum.from);
  }

  ///原名symbolAtChangeRow,更改为symbolAtToRow
  String symbolAtToRow(int intRow) {
    return inputEasyWordsModel().getSymbolName(intRow, EasyTypeEnum.to);
  }

  String symbolAtHideRow(int intRow) {
    return inputEasyWordsModel().getSymbolName(intRow, EasyTypeEnum.hide);
  }

  String symbolNameAtMergeRow(int intRow) {
    return inputEasyWordsModel().symbolNameAtMergeRow(intRow);
  }

  String monthEarth() {
    return inputEasyWordsModel().stringMonthEarth;
  }

  String daySky() {
    return inputEasyWordsModel().stringDaySky;
  }

  String dayEarth() {
    return inputEasyWordsModel().stringDayEarth;
  }

  String earthAtFromRow(int intRow) {
    return inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.from);
  }

  ///原名为earthAtChangeRow,更改为earthAtToRow
  String earthAtToRow(int intRow) {
    return inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.to);
  }

  String earthAtHideRow(int intRow) {
    return inputEasyWordsModel().getSymbolEarth(intRow, EasyTypeEnum.hide);
  }

  bool isMovementAtRow(int intRow) {
    return inputEasyWordsModel().isMovementAtRow(intRow);
  }

  ///`加载函数`//////////////////////////////////////////////////////

  ///此函数包含十天干
  String skyTrunkString() {
    return "甲乙丙丁戊己庚辛壬癸";
  }

  ///此函数包含十二地支
  String earthBranchString() {
    return "子丑寅卯辰巳午未申酉戌亥";
  }

  SABEarthBranchBusiness branchBusiness() {
    if (null == _branchBusiness) {
      _branchBusiness = SABEarthBranchBusiness();
    } //else cont.
    return _branchBusiness;
  }

  SABEasyWordsModel inputEasyWordsModel() {
    return easyBusiness().outEasyWordsModel();
  }

  SABEasyBusiness easyBusiness() {
    if (null == _easyBusiness) {
      _easyBusiness = SABEasyBusiness(_inputEasyModel);
    } //else cont.
    return _easyBusiness;
  }

  SABEasyLogicModel outLogicModel() {
    if (null == _outLogicModel) {
      _outLogicModel = SABEasyLogicModel(inputEasyWordsModel());

      _outLogicModel.bStaticEasy = isStaticEasy();

      _outLogicModel.setIsEasySixPair(
          EasyTypeEnum.from, _isEasySixPair(_fromEasyDictionary()));

      _outLogicModel.setIsEasySixPair(
          EasyTypeEnum.to, _isEasySixPair(_toEasyDictionary()));

      _outLogicModel.setIsEasySixPair(
          EasyTypeEnum.hide, _isEasySixPair(easyBusiness().placeFirstEasy()));

      _outLogicModel.setIsEasySixConflict(
          EasyTypeEnum.from, _isEasySixConflict(_fromEasyDictionary()));

      _outLogicModel.setIsEasySixConflict(
          EasyTypeEnum.to, _isEasySixConflict(_toEasyDictionary()));

      _outLogicModel.setIsEasySixConflict(EasyTypeEnum.hide,
          _isEasySixConflict(easyBusiness().placeFirstEasy()));

      _outLogicModel.listStaticSeasonStrong = staticSeasonStrong();

      ///爻的基础信息
      for (int intRow = 0; intRow < 6; intRow++) {
        _outLogicModel.setIsSymbolChangeBorn(
            intRow, isSymbolChangeBornAtRow(intRow));

        _outLogicModel.setIsSymbolChangeRestrict(
            intRow, isSymbolChangeConflictAtRow(intRow));

        _outLogicModel.setIsSymbolChangeConflict(
            intRow, isSymbolChangeConflictAtRow(intRow));

        _outLogicModel.setSymbolForwardOrBack(
            intRow, symbolForwardOrBack(intRow));
        _outLogicModel.setIsSymbolBackMove(
            intRow, isSymbolBackMoveAtRow(intRow, EasyTypeEnum.from));

        ///IsOnMonth
        _outLogicModel.setIsOnMonth(intRow, EasyTypeEnum.from,
            _isSymbolOnMonth(symbolAtFromRow(intRow)));

        _outLogicModel.setIsOnMonth(
            intRow, EasyTypeEnum.to, _isSymbolOnMonth(symbolAtToRow(intRow)));

        _outLogicModel.setIsOnMonth(intRow, EasyTypeEnum.hide,
            _isSymbolOnMonth(symbolAtHideRow(intRow)));

        ///IsOnDay
        _outLogicModel.setIsOnDay(
            intRow, EasyTypeEnum.from, _isSymbolOnDay(symbolAtFromRow(intRow)));

        _outLogicModel.setIsOnDay(
            intRow, EasyTypeEnum.to, _isSymbolOnDay(symbolAtToRow(intRow)));

        _outLogicModel.setIsOnDay(
            intRow, EasyTypeEnum.hide, _isSymbolOnDay(symbolAtHideRow(intRow)));

        ///IsMonthPair
        _outLogicModel.setIsMonthPair(intRow, EasyTypeEnum.from,
            _isSymbolMonthPair(symbolAtFromRow(intRow)));

        _outLogicModel.setIsMonthPair(
            intRow, EasyTypeEnum.to, _isSymbolMonthPair(symbolAtToRow(intRow)));

        _outLogicModel.setIsMonthPair(intRow, EasyTypeEnum.hide,
            _isSymbolMonthPair(symbolAtHideRow(intRow)));

        ///IsDayPair
        _outLogicModel.setIsDayPair(intRow, EasyTypeEnum.from,
            _isSymbolDayPair(symbolAtFromRow(intRow)));

        _outLogicModel.setIsDayPair(
            intRow, EasyTypeEnum.to, _isSymbolDayPair(symbolAtToRow(intRow)));

        _outLogicModel.setIsDayPair(intRow, EasyTypeEnum.hide,
            _isSymbolDayPair(symbolAtHideRow(intRow)));

        ///IsEffectable
        _outLogicModel.setIsEffectable(intRow, EasyTypeEnum.from,
            isEffectableRow(intRow, EasyTypeEnum.from));

        _outLogicModel.setIsEffectable(
            intRow, EasyTypeEnum.to, isEffectableRow(intRow, EasyTypeEnum.to));

        _outLogicModel.setIsEffectable(intRow, EasyTypeEnum.hide,
            isEffectableRow(intRow, EasyTypeEnum.hide));

        ///IsSymbolDayBroken
        _outLogicModel.setIsSymbolDayBroken(intRow, EasyTypeEnum.from,
            isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.from));

        _outLogicModel.setIsSymbolDayBroken(intRow, EasyTypeEnum.to,
            isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.to));

        _outLogicModel.setIsSymbolDayBroken(intRow, EasyTypeEnum.hide,
            isSymbolDayBrokenAtRow(intRow, EasyTypeEnum.hide));

        ///IsSeasonStrong
        _outLogicModel.setIsSeasonStrong(intRow, EasyTypeEnum.from,
            isSymbolSeasonStrong(symbolAtFromRow(intRow)));

        _outLogicModel.setIsSeasonStrong(intRow, EasyTypeEnum.to,
            isSymbolSeasonStrong(symbolAtToRow(intRow)));

        _outLogicModel.setIsSeasonStrong(intRow, EasyTypeEnum.hide,
            isSymbolSeasonStrong(symbolAtRow(intRow, EasyTypeEnum.hide)));

        ///BasicEmptyState
        _outLogicModel.setBasicEmptyState(intRow, EasyTypeEnum.from,
            _symbolBasicEmptyState(symbolAtFromRow(intRow)));

        _outLogicModel.setBasicEmptyState(intRow, EasyTypeEnum.to,
            _symbolBasicEmptyState(symbolAtToRow(intRow)));

        _outLogicModel.setBasicEmptyState(intRow, EasyTypeEnum.hide,
            _symbolBasicEmptyState(symbolAtHideRow(intRow)));

        ///Diety
        _outLogicModel.setDiety(
            intRow, EasyTypeEnum.from, dietyAtRow(intRow, EasyTypeEnum.from));

        _outLogicModel.setDiety(
            intRow, EasyTypeEnum.to, dietyAtRow(intRow, EasyTypeEnum.to));

        _outLogicModel.setDiety(
            intRow, EasyTypeEnum.hide, dietyAtRow(intRow, EasyTypeEnum.hide));

        ///symbolEmptyState
        _outLogicModel.setSymbolEmptyState(intRow, EasyTypeEnum.from,
            symbolEmptyState(intRow, EasyTypeEnum.from));

        _outLogicModel.setSymbolEmptyState(
            intRow, EasyTypeEnum.to, symbolEmptyState(intRow, EasyTypeEnum.to));

        _outLogicModel.setSymbolEmptyState(intRow, EasyTypeEnum.hide,
            symbolEmptyState(intRow, EasyTypeEnum.hide));
      }

      //此信息依赖爻的基础信息
      for (int intRow = 0; intRow < 6; intRow++) {
        ///ConflictOnMonth
        _outLogicModel.setConflictOnMonthState(intRow, EasyTypeEnum.from,
            _symbolConflictStateOnMonth(intRow, EasyTypeEnum.from));

        _outLogicModel.setConflictOnMonthState(intRow, EasyTypeEnum.to,
            _symbolConflictStateOnMonth(intRow, EasyTypeEnum.to));

        _outLogicModel.setConflictOnMonthState(intRow, EasyTypeEnum.hide,
            _symbolConflictStateOnMonth(intRow, EasyTypeEnum.hide));

        _outLogicModel.setConflictOnDayState(intRow, EasyTypeEnum.from,
            _symbolDayConflictState(intRow, EasyTypeEnum.from));

        _outLogicModel.setConflictOnDayState(intRow, EasyTypeEnum.to,
            _symbolDayConflictState(intRow, EasyTypeEnum.to));

        _outLogicModel.setConflictOnDayState(intRow, EasyTypeEnum.hide,
            _symbolDayConflictState(intRow, EasyTypeEnum.hide));
      }

      ///endf

    }
    return _outLogicModel;
  }
}
