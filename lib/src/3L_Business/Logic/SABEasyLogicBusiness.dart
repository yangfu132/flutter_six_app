import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Easy/SABEasyModel.dart';
import '../Easy/SABEasyBusiness.dart';
import '../Easy/SABElementModel.dart';
import '../EarthBranch/SABEarthBranchBusiness.dart';

class SABEasyLogicBusiness {
  final SABEasyModel _inputEasyModel;
  SABEasyBusiness _easyBusiness;
  SABEarthBranchBusiness _branchBusiness;
  //属性：用神的索引号
  int _usefulGodRow = globalRowInvalid;
  SABEasyLogicBusiness(this._inputEasyModel) {
    _easyBusiness = SABEasyBusiness(_inputEasyModel);
    _branchBusiness = SABEarthBranchBusiness();
  }

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return 0;
  }

  double healthCriticalValue() {
    return 0;
  }

  List rowArrayAtLevel(OutRightEnum level) {
    return [];
  }

  ///`六亲歌章第五`//////////////////////////////////////////////////////

  String symbolRelative(String theSymbol, String basicSymbol) {
    String theEarth = _easyBusiness.symbolEarth(theSymbol);
    String basicEarth = _easyBusiness.symbolEarth(basicSymbol);
    return _branchBusiness.earthRelative(theEarth, basicEarth);
  }

  List arrayFromRowOfParent(String parent) {
    return arrayRowWithParent(parent, _easyBusiness.fromEasyDictionary());
  }

  List arrayRowWithParent(String parent, Map easyDictionary) {
    List usefulArray = List();

    List easyEasy = easyDictionary["data"];
    for (int index = 0; index < 6; index++) {
      String stringSymbolParent = _easyBusiness.symbolParent(easyEasy[index]);
      if (stringSymbolParent == parent) {
        usefulArray.add(index);
      }
      //else cont.
    } //endf

    return usefulArray;
  }

  ///`世应章第六 -- 世（Life） 应（Goal）`/////////////////////////////////////////

  String roleDescriptionAtRow(int intIndex) {
    String strResult = "";
    Map fromDict = _easyBusiness.fromEasyDictionary();
    if (null != fromDict) {
      if (intIndex == _easyBusiness.getLifeIndex()) {
        strResult = "世";
      } else if (intIndex == _easyBusiness.goalIndex()) {
        strResult = "应";
      }
    }
    //else cont.

    return strResult;
  }

  ///`动变章第七`//////////////////////////////////////////////////////
  bool isSymbolChangeGuiAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = _easyBusiness.earthAtFromRow(intRow);
    String strTo = _easyBusiness.earthAtFromRow(intRow);
    if (null != strTo) {
      String fromElement = _branchBusiness.earthElement(fromEarth);
      String toElement = _branchBusiness.earthElement(strTo);
      String parent = SABElementModel.elementRelative(fromElement, toElement);
      bResult = "官鬼" == parent;
    }
    //else cont.

    return bResult;
  }

  ///`用神章第八--用神旺相`//////////////////////////////////////////////////////
  bool isUsefulGodChangeToConflict() {
    return isSymbolChangeConflictAtRow(usefulGodRow());
  }

  bool isUsefulGodChangeToRestricts() {
    return isSymbolChangeRestrictAtRow(usefulGodRow());
  }

  bool isUsefulGodStrong() {
    bool bResult = false;

    int usefulIndex = usefulGodRow();
    if (0 <= usefulIndex && usefulIndex <= 5) {
      bResult = isSymbolHealthStrong(usefulIndex, EasyTypeEnum.from);
    } else if (ROW_MONTH == usefulIndex) {
      colog("error!");
    } else if (ROW_DAY == usefulIndex) {
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

  String elementOfUsefulGod() {
    String strUsefulElement = "";
    int usefulIndex = usefulGodRow();
    if (usefulIndex == globalRowInvalid) {
      //没有指定用神
    } else if (usefulIndex < 6) {
      String usefulfromEarth = _easyBusiness.earthAtFromRow(usefulIndex);
      strUsefulElement = _branchBusiness.earthElement(usefulfromEarth);
    } else if (usefulIndex == ROW_MONTH) {
      strUsefulElement = monthElement();
    } else if (usefulIndex == ROW_DAY) {
      strUsefulElement = dayElement();
    } else if (usefulIndex >= ROW_FLY_BEGIN) {
      String hideSymbol =
          _easyBusiness.symbolAtHideRow(usefulIndex - ROW_FLY_BEGIN);
      strUsefulElement = _easyBusiness.symbolElement(hideSymbol);
    } else
      colog("error!");

    return strUsefulElement;
  }

  String usefulEarth() {
    String stringSymbol = "";

    int usefulIndex = usefulGodRow();

    if (0 <= usefulIndex && usefulIndex < 6) {
      stringSymbol = _easyBusiness.symbolAtFromRow(usefulIndex);
    } else {
      usefulIndex = usefulIndex - ROW_FLY_BEGIN;
      stringSymbol = _easyBusiness.symbolAtHideRow(usefulIndex);
    } //endi

    String earth = _easyBusiness.symbolEarth(stringSymbol);

    return earth;
  }

  int usefulGodRow() {
    if ("" != _inputEasyModel.getUsefulGod()) {
      if (globalRowInvalid == _usefulGodRow) {
        _usefulGodRow = indexOfUseGodInEasy(_easyBusiness.fromEasyDictionary());
      }
    } else
      _usefulGodRow = globalRowInvalid;

    _usefulGodRow = globalRowInvalid == _usefulGodRow ? 0 : _usefulGodRow;

    return _usefulGodRow;
  }

  void clearUsefulRow() {
    _usefulGodRow = globalRowInvalid;
  }

  ///`用神元神忌神仇神章第九`//////////////////////////////////////////////////////
  String godAtRow(int intIndex, EasyTypeEnum enumEasyType) {
    String strResult = "";

    if (enumEasyType == EasyTypeEnum.from) {
      int usefulIndex = usefulGodRow();
      if (usefulIndex == intIndex) {
        strResult = "用神";
      } else if (usefulIndex - ROW_FLY_BEGIN == intIndex) {
        strResult = "飞神";
      } else {
        String usefulElement = elementOfUsefulGod();
        String currentElement = _branchBusiness
            .earthElement(_easyBusiness.earthAtFromRow(intIndex));

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
    String lifeSymbol = _easyBusiness.symbolAtRow(
        _easyBusiness.getLifeIndex(), EasyTypeEnum.from);
    String lifeElement = _easyBusiness.symbolElement(lifeSymbol);
    return arrayParent("父母", lifeElement);
  }

  List lifeEnemyArray() {
    String lifeSymbol = _easyBusiness.symbolAtRow(
        _easyBusiness.getLifeIndex(), EasyTypeEnum.from);
    String lifeElement = _easyBusiness.symbolElement(lifeSymbol);
    return arrayParent("官鬼", lifeElement);
  }

  List arrayParent(String strParent, String strElement) {
    List arrayResult = [];
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          _branchBusiness.earthElement(_easyBusiness.earthAtFromRow(intIndex));

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
  bool isGodValid(int intIndex) {
    bool bResult = true;
    List arrayBorns = bornGodIndexArray();
    if (-1 != arrayBorns.indexOf(intIndex)) {
      if (isBornGodInValidAtRow(intIndex))
        bResult = false;
      else
        bResult = isBornGodValidAtRow(intIndex);
    }
    //else cont.

    List arrayRestricts = restrictsGodIndexArray();
    if (-1 != arrayRestricts.indexOf(intIndex)) {
      if (isRestrictGodInvalidAtRow(intIndex))
        bResult = false;
      else
        bResult = isRestrictGodValidAtRow(intIndex);
    }
    //else cont.

    return bResult;
  }

  List bornGodIndexArray() {
    List arrayResult = List();
    String usefulElement = elementOfUsefulGod();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          _branchBusiness.earthElement(_easyBusiness.earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("父母" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List restrictsGodIndexArray() {
    List arrayResult = List();

    String usefulElement = elementOfUsefulGod();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          _branchBusiness.earthElement(_easyBusiness.earthAtFromRow(intIndex));

      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("官鬼" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  List enemyGodRowArray() {
    List arrayResult = List();

    String usefulElement = elementOfUsefulGod();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      String currentElement =
          _branchBusiness.earthElement(_easyBusiness.earthAtFromRow(intIndex));
      String parent =
          SABElementModel.elementRelative(usefulElement, currentElement);
      if ("妻财" == parent) {
        arrayResult.add(intIndex);
      }
      //else cont.

    } //endf

    return arrayResult;
  }

  bool isRestrictGodValidAtRow(int intRow) {
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
    String strSymbolBase = _easyBusiness.symbolAtRow(intRow, EasyTypeEnum.from);
    bool bStrong = isSymbolSeasonStrong(strSymbolBase);
    bool bOnMonth = isSymbolOnMonth(strSymbolBase);
    bool bOnDay = isSymbolOnDay(strSymbolBase);
    bool bMonthBorn = isSymbolMoveBorn(strSymbolBase);
    bool bDayBorn = isSymbolDayBorn(strSymbolBase);
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
        bool bMoving = _inputEasyModel.isMovementAtRow(intRow);
        if (bStrong && bMoving && bEmpty && bToEmpty) {
          bResult = true;
        } else {
          //忌神长生帝旺于日辰，四也。
          String stringEarthBase = _easyBusiness.symbolEarth(strSymbolBase);
          String stringTewleveGod = _branchBusiness.earthTwelveGod(
              stringEarthBase, _easyBusiness.dayEarth());
          if ("长生" == stringTewleveGod || "帝旺" == stringTewleveGod)
            bResult = true;
          else {
            //忌神与仇神同动，五也。
            bool bMoving = _inputEasyModel.isMovementAtRow(intRow);
            bool bEnemyMoving = false;
            List listEnemyGodRow = enemyGodRowArray();
            for (int intIndex in listEnemyGodRow) {
              bEnemyMoving = _inputEasyModel.isMovementAtRow(intIndex);
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

  bool isBornGodValidAtRow(int intIndex) {
    /*
     元神能生用神者有五：元神旺相或临日月或动爻生扶者，一也。
     元神动化回头生及化进神者，二也。
     元神长生帝旺于日辰，三也。
     元神与忌神同动，四也。
     元神旺动临空化空，五也。
     */
    bool bResult = false;

    String stringSymbolBase =
        _easyBusiness.symbolAtRow(intIndex, EasyTypeEnum.from);

    //元神旺相或临日月或动爻生扶者，一也。
    bool bStrong = isSymbolSeasonStrong(stringSymbolBase);
    bool bOnMonth = isSymbolOnMonth(stringSymbolBase);
    bool bOnDay = isSymbolOnDay(stringSymbolBase);
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
        String stringEarthBase = _easyBusiness.symbolEarth(stringSymbolBase);
        String stringTewleveGod = _branchBusiness.earthTwelveGod(
            stringEarthBase, _easyBusiness.dayEarth());
        if ("长生" == stringTewleveGod || "帝旺" == stringTewleveGod)
          bResult = true;
        else {
          //元神与忌神同动，四也。
          bool bMoving = _inputEasyModel.isMovementAtRow(intIndex);
          bool bRestrictMoving = false;
          List listRestrictsGodIndex = restrictsGodIndexArray();
          for (int numIndex in listRestrictsGodIndex) {
            bRestrictMoving = _inputEasyModel.isMovementAtRow(numIndex);
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
    String basicSymbol = _easyBusiness.symbolAtFromRow(intRow);
    bool bSeasonStrong = isSymbolSeasonStrong(basicSymbol);
    if (!_inputEasyModel.isMovementAtRow(intRow)) {
      bResult = bSeasonStrong;
    } else {
      String stringBasicElement =
          _branchBusiness.earthElement(_easyBusiness.earthAtFromRow(intRow));
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

  bool isRestrictGodInvalidAtRow(int intRow) {
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
    String basicSymbol = _easyBusiness.symbolAtFromRow(intRow);
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //忌神静临空破，二也。
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken =
          MonthBrokenEnum.Broken_YES == symbolMonthBrokenState(basicSymbol);
      bool bMoving = _easyBusiness.isSymbolMovement(basicSymbol);
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
              String fromEarth = _easyBusiness.earthAtFromRow(intRow);
              String toEarth = _easyBusiness.earthAtFromRow(intRow);

              //化克
              if ("" != toEarth)
                bRestrict =
                    _branchBusiness.isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              String toSymbol = _easyBusiness.symbolAtChangeRow(intRow);
              if (toSymbol != "") {
                bToDayBroken = isSymbolDayBrokenAtRow(intRow, enumEasyType);
                bToMonthBroken = (MonthBrokenEnum.Broken_YES ==
                    symbolMonthBrokenState(toSymbol));
              }
              //else cont.

              if (bRestrict || bToDayBroken || bToMonthBroken) {
                bResult = true;
              } else {
                //忌神与元神同动，七也。
                bool bBornMoving = false;
                List listBornGodIndex = bornGodIndexArray();
                for (int numIndex in listBornGodIndex) {
                  bBornMoving = _inputEasyModel.isMovementAtRow(numIndex);
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

  bool isBornGodInValidAtRow(int intRow) {
    bool bResult = true;
    EasyTypeEnum easyType = EasyTypeEnum.from;
    /*
     元神虽现又有不能生用神者用六：
     以上见生不生，为无用之元神也，虽有如无。
     */
    //元神休囚不动，或动而休囚又被伤克者，一也。
    String bornSymbol = _easyBusiness.symbolAtFromRow(intRow);
    if (isBasicInvalidAtRow(intRow)) {
      bResult = true;
    } else {
      //元神休囚又逢旬空月破，二也。
      bool bStrong = isSymbolSeasonStrong(bornSymbol);
      bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.from);
      bool bBroken =
          MonthBrokenEnum.Broken_YES == symbolMonthBrokenState(bornSymbol);
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
              String fromEarth = _easyBusiness.earthAtFromRow(intRow);
              String toEarth = _easyBusiness.earthAtFromRow(intRow);
              if ("" != toEarth)
                bRestrict =
                    _branchBusiness.isEarthRestricts(toEarth, fromEarth);
              //else cont.

              //化破
              bool bToDayBroken = false;
              bool bToMonthBroken = false;
              String toSymbol = _easyBusiness.symbolAtChangeRow(intRow);
              if ("" != toSymbol) {
                bToDayBroken = isSymbolDayBrokenAtRow(intRow, easyType);
                bToMonthBroken = (MonthBrokenEnum.Broken_YES ==
                    symbolMonthBrokenState(toSymbol));
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
    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from)
      stringSymbol = _easyBusiness.symbolAtFromRow(intRow);
    else
      colog("error!");

    String fromEarth = _easyBusiness.symbolEarth(stringSymbol);
    String toEarth = _easyBusiness.earthAtFromRow(intRow);

    String monthTwelve =
        _branchBusiness.earthTwelveGod(fromEarth, _easyBusiness.monthEarth());
    String dayTwelve =
        _branchBusiness.earthTwelveGod(fromEarth, _easyBusiness.dayEarth());

    String toTwelve = _branchBusiness.earthTwelveGod(fromEarth, toEarth);

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

    return bResult;
  }

//衰
  bool isSymbolShuaiAtRow(int intRow, EasyTypeEnum easyType) {
    //无动爻生，日月上不敌，即是衰。
    bool bResult = false;

    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from)
      stringSymbol = _easyBusiness.symbolAtFromRow(intRow);
    else
      colog("error!");

    //
    bool bBorn = isSymbolMoveBorn(stringSymbol);

    //月克日生或月生日克，是相敌。月破日生或月生日破是不敌等等。
    //还有月合日克或日合月克是可敌。

    bool bBalance = false;

    bool bOnDay = isSymbolOnDay(stringSymbol);
    bool bOnMonth = isSymbolOnMonth(stringSymbol);

    if (bOnDay || bOnMonth)
      bBalance = true;
    else {
      //生克
      bool bMonthBorn = isSymbolMonthBorn(stringSymbol);
      bool bDayBorn = isSymbolDayBorn(stringSymbol);
      bool bMonthRestrict = isSymbolMonthRestrict(stringSymbol);
      bool bDayRestrict = isSymbolDayRestrict(stringSymbol);

      //冲合
      bool bDayConflict = isSymbolDayConflict(stringSymbol);
      bool bDayPair = isSymbolDayPair(stringSymbol);
      bool bMonthConflict = isSymbolMonthConflict(stringSymbol);
      bool bMonthPair = isSymbolMonthPair(stringSymbol);

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
    String stringSymbol = "";
    if (easyType == EasyTypeEnum.from)
      stringSymbol = _easyBusiness.symbolAtFromRow(intRow);
    else
      colog("error!");

    String fromEarth = _easyBusiness.symbolEarth(stringSymbol);
    String toEarth = _easyBusiness.earthAtFromRow(intRow);

    String monthTwelve =
        _branchBusiness.earthTwelveGod(fromEarth, _easyBusiness.monthEarth());
    String dayTwelve =
        _branchBusiness.earthTwelveGod(fromEarth, _easyBusiness.dayEarth());

    String toTwelve = _branchBusiness.earthTwelveGod(fromEarth, toEarth);

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

    if (_inputEasyModel.isMovementAtRow(intIndex)) {
      result = "动";
    }

    return result;
  }

  bool isStaticEasy() {
    return _easyBusiness.fromEasyName() == _easyBusiness.toEasyName();
  }

  List staticSeasonStrong() {
    List _staticStrongArray = List();
    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (!_inputEasyModel.isMovementAtRow(intIndex)) {
        String stringSymbol = _easyBusiness.symbolAtFromRow(intIndex);
        if (isSymbolSeasonStrong(stringSymbol))
          _staticStrongArray.add(intIndex);
        //else cont.
      }
      //else cont.
    } //endf

    return _staticStrongArray;
  }

  List movementIndexArray() {
    List movementArray = List();

    List arrayLevel = rowArrayAtLevel(OutRightEnum.RIGHT_MOVE);
    for (int intRow in arrayLevel) {
      if (!_inputEasyModel.isMovementAtRow(intRow)) {
        if (isSymbolHealthStrong(intRow, EasyTypeEnum.from))
          movementArray.add(intRow);
        //else cont.
      } else
        movementArray.add(intRow);
    } //endf

    return movementArray;
  }

//被动爻生
  bool isSymbolBornedByMoveAtRow(int intIndex, EasyTypeEnum easyType) {
    bool bResult = false;

    if (isEffectableRow(intIndex, easyType)) {
      String stringSymbol = "";

      if (easyType == EasyTypeEnum.from)
        stringSymbol = _easyBusiness.symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = _easyBusiness.symbolAtHideRow(intIndex);
      //else cont.

      bResult = isSymbolMoveBorn(stringSymbol);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolBorn(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String earth = _easyBusiness.symbolEarth(stringSymbol);
      String earthOther = _easyBusiness.symbolEarth(otherSymbol);
      bResult = _branchBusiness.isEarthBorn(earthOther, earth);
    }
    //else cont.

    return bResult;
  }

//被动爻生
  bool isSymbolMoveBorn(String stringSymbol) {
    bool bResult = false;
    List arrayEffects = movementIndexArray();
    for (int numItem in arrayEffects) {
      String stringSymbolItem = _easyBusiness.symbolAtFromRow(numItem);
      if (isSymbolBorn(stringSymbol, stringSymbolItem)) {
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
      if (!_inputEasyModel.isMovementAtRow(intIndex))
        stringSymbol = _easyBusiness.symbolAtFromRow(intIndex);
      //else cont.
    } else if (easyType == EasyTypeEnum.hide)
      stringSymbol = _easyBusiness.symbolAtHideRow(intIndex);
    else
      colog("error!");

    if ("" != stringSymbol) {
      List arrayEffects = staticSeasonStrong();

      for (int numItem in arrayEffects) {
        String stringSymbolItem = _easyBusiness.symbolAtFromRow(numItem);
        if (isSymbolBorn(stringSymbol, stringSymbolItem)) {
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
    List arrayEffects = movementIndexArray();

    String stringSymbol = "";

    if (easyType == EasyTypeEnum.from)
      stringSymbol = _easyBusiness.symbolAtFromRow(intIndex);
    else if (easyType == EasyTypeEnum.hide)
      stringSymbol = _easyBusiness.symbolAtHideRow(intIndex);
    else
      colog("error!");

    for (int numItem in arrayEffects) {
      String stringSymbolItem = _easyBusiness.symbolAtFromRow(numItem);
      if (isEffectableRow(numItem, EasyTypeEnum.from)) {
        if (isSymbolRestrict(stringSymbol, stringSymbolItem)) {
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
    if (!_inputEasyModel.isMovementAtRow(intIndex)) {
      String stringSymbol = "";
      if (easyType == EasyTypeEnum.from)
        stringSymbol = _easyBusiness.symbolAtFromRow(intIndex);
      else if (easyType == EasyTypeEnum.hide)
        stringSymbol = _easyBusiness.symbolAtHideRow(intIndex);
      //else cont.

      if (!isSymbolSeasonStrong(stringSymbol)) {
        List arrayEffects = staticSeasonStrong();

        for (int numItem in arrayEffects) {
          String stringSymbolItem = _easyBusiness.symbolAtFromRow(numItem);
          if (isSymbolRestrict(stringSymbol, stringSymbolItem)) {
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

  bool isSymbolRestrict(String stringSymbol, String otherSymbol) {
    bool bResult = false;

    if ("" != stringSymbol && "" != otherSymbol) {
      String stringEarth = _easyBusiness.symbolEarth(stringSymbol);
      String stringEarthOther = _easyBusiness.symbolEarth(otherSymbol);
      bResult = _branchBusiness.isEarthRestricts(stringEarthOther, stringEarth);
    }
    //else cont.
    return bResult;
  }

  /// `动静生克冲合章第十五`/////////////////////////////////////////////

//动化回头生
  bool isSymbolChangeBornAtRow(int intIndex) {
    bool bResult = false;
    if (_inputEasyModel.isMovementAtRow(intIndex)) {
      String strFrom = _easyBusiness.earthAtFromRow(intIndex);
      String strTo = _easyBusiness.earthAtChangeRow(intIndex);
      bResult = _branchBusiness.isEarthBorn(strTo, strFrom);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolChangeRestrictAtRow(int intRow) {
    bool bResult = false;

    if (0 <= intRow && intRow <= 5) {
      String fromEarth = _easyBusiness.earthAtFromRow(intRow);
      String strTo = _easyBusiness.earthAtFromRow(intRow);
      if (null != strTo)
        bResult = _branchBusiness.isEarthRestricts(strTo, fromEarth);
      //else cont.
    } else
      colog("error!");

    return bResult;
  }

  bool isSymbolChangeConflictAtRow(int intRow) {
    bool bResult = false;
    String fromEarth = _easyBusiness.earthAtFromRow(intRow);
    String strTo = _easyBusiness.earthAtFromRow(intRow);
    if (null != strTo)
      bResult = _branchBusiness.isEarthConflict(fromEarth, strTo);
    //else cont.

    return bResult;
  }

  ///`四时旺相章第又十五`//////////////////////////////////////////////////////
  String symbolSeason(String stringSymbol) {
    return _branchBusiness.seasonDescription(
        _easyBusiness.monthEarth(), _easyBusiness.symbolEarth(stringSymbol));
    ;
  }

  bool isSymbolSeasonStrong(String stringSymbol) {
    bool bResult = false;

    if ("" != stringSymbol) {
      String stringSeason = symbolSeason(stringSymbol);
      bResult = "旺" == stringSeason;
      bResult = bResult || "相" == stringSeason;
      bResult = bResult || "余气" == stringSeason;
    }
    //else cont.

    return bResult;
  }

  bool isSymbolHealthStrong(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    double fHealth = symbolHealthAtRow(intRow, easyType);
    bResult = fHealth > healthCriticalValue();

    return bResult;
  }

  ///`月将章第十六`//////////////////////////////////////////////////////
  String monthElement() {
    return _branchBusiness.earthElement(_easyBusiness.monthEarth());
  }

  bool isSymbolOnMonth(String stringSymbol) {
    return _easyBusiness.monthEarth() ==
        _easyBusiness.symbolEarth(stringSymbol);
  }

  bool isEarthPairMonth(String basicEarth, String monthEarth) {
    bool bResult = false;

    String strPair = _branchBusiness.earthSixPair(basicEarth);

    bResult = strPair == monthEarth;

    return bResult;
  }

  bool isEarthOnMonth(String basicEarth, String monthEarth) {
    return monthEarth == basicEarth;
  }

  bool isSymbolMonthBorn(String stringSymbol) {
    String strMonth = _easyBusiness.monthEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    bool bBorn = _branchBusiness.isEarthBorn(strMonth, strEarth);

    return bBorn;
  }

  bool isSymbolMonthRestrict(String stringSymbol) {
    String strMonth = _easyBusiness.monthEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);
    bool bRestricted = _branchBusiness.isEarthRestricts(strMonth, strEarth);

    return bRestricted;
  }

  bool isSymbolMonthConflict(String stringSymbol) {
    String strMonth = _easyBusiness.monthEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    bool bConflicted = _branchBusiness.isEarthConflict(strMonth, strEarth);

    return bConflicted;
  }

  bool isMovementStrongAtRow(int intRow) {
    //月建以下情况之一，不能克伤动爻；
    bool bResult = false;

    String stringSymbol = _easyBusiness.symbolAtFromRow(intRow);
    String strEarth = _easyBusiness.earthAtFromRow(intRow);

    //1 临日建，日生。
    String strDay = _easyBusiness.dayEarth();
    bool bOnDay = isSymbolOnDay(stringSymbol);
    bool bBornByDay = _branchBusiness.isEarthBorn(strDay, strEarth);

    //2 动变回头生。
    bool bBornByChange = isSymbolChangeBornAtRow(intRow);

    //3 动变进。
    bool bChangeForward = isSymbolChangeForwardAtRow(intRow);

    //4 有旺动爻生。

    bool bBornByMoving = false;
    List arrayEffects = [0, 1, 2, 3, 4, 5];
    List arrayMovement = movementArrayInArray(arrayEffects);
    for (int numItem in arrayMovement) {
      String stringSymbol = _easyBusiness.symbolAtFromRow(numItem);
      String season = symbolSeason(stringSymbol);
      if ("旺" == season) {
        String moveEarth = _easyBusiness.earthAtFromRow(numItem);
        if (_branchBusiness.isEarthBorn(moveEarth, strEarth)) {
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
    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);
    String strMonth = _easyBusiness.monthEarth();
    bool bRestricted = _branchBusiness.isEarthRestricts(strMonth, strEarth);
    if (bRestricted) {
      if (easyType == EasyTypeEnum.from) {
        if (_inputEasyModel.isMovementAtRow(intRow)) {
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
    return _branchBusiness.earthElement(_easyBusiness.dayEarth());
  }

  bool isOnDayEarth(String basicEarth, String dayEarth) {
    return dayEarth == basicEarth;
  }

  bool isConflictDayEarth(String basicEarth, String dayEarth) {
    bool result = false;

    result = _branchBusiness.isEarthConflict(basicEarth, dayEarth);

    return result;
  }

  bool isSymbolConflictDayAtRow(int intRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (0 <= intRow && intRow < 6) {
      String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);
      if (bResult) {
        bResult = isSymbolDayConflict(stringSymbol);
      }
    } else
      colog("error!");

    return bResult;
  }

  bool isSymbolDayBorn(String stringSymbol) {
    String strDayEarth = _easyBusiness.dayEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    bool bBorn = _branchBusiness.isEarthBorn(strDayEarth, strEarth);

    return bBorn;
  }

  bool isSymbolDayRestrict(String stringSymbol) {
    String strDayEarth = _easyBusiness.dayEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);
    bool bRestricted = _branchBusiness.isEarthRestricts(strDayEarth, strEarth);

    return bRestricted;
  }

  bool isSymbolDayConflict(String stringSymbol) {
    String strDayEarth = _easyBusiness.dayEarth();

    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    bool bConflicted = _branchBusiness.isEarthConflict(strDayEarth, strEarth);

    return bConflicted;
  }

//冲衰弱之静爻则为日破
  bool isSymbolDayBrokenAtRow(int intRow, EasyTypeEnum easyType) {
    bool result = false;

    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);

    if ("" != stringSymbol) {
      if (!isSymbolHealthStrong(intRow, easyType)) {
        String strDay = _easyBusiness.dayEarth();
        if (!_easyBusiness.isSymbolMovement(stringSymbol)) {
          result = _branchBusiness.isEarthConflict(
              strDay, _easyBusiness.symbolEarth(stringSymbol));
        }
        //else cont.
      }
      //else cont.
    } else
      colog("error!");

    return result;
  }

//冲衰弱之静爻则为日破
  DayConflictEnum symbolDayConflictState(String stringSymbol) {
    DayConflictEnum nResult = DayConflictEnum.Conflict_NO;

    String strDay = _easyBusiness.dayEarth();
    bool bConflict = _branchBusiness.isEarthConflict(
        strDay, _easyBusiness.symbolEarth(stringSymbol));
    if (bConflict) {
      nResult = DayConflictEnum.Conflict_YES;

      if (_easyBusiness.isSymbolMovement(stringSymbol)) {
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

  bool isSymbolOnDay(String stringSymbol) {
    return _easyBusiness.dayEarth() == _easyBusiness.symbolEarth(stringSymbol);
  }

  ///`六合章第十九`//////////////////////////////////////////////////////

//六合卦
  bool isEasySixPair(Map easyDictionary) {
    bool bResult = false;

    List symbolPairArray = [];

    List dataArray = easyDictionary["data"];

    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = _easyBusiness.symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = _easyBusiness.symbolEarth(dataArray[indexOther]);
          String strPair =
              _branchBusiness.sixPairDescription(basicEarth, otherEarth);
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

  bool isEarthPairDay(String basicEarth, String dayEarth) {
    bool bResult = false;

    String strPair = _branchBusiness.earthSixPair(basicEarth);

    bResult = strPair == dayEarth;

    return bResult;
  }

  bool isPairSymbolAtRow(int intRow, int nOtherRow) {
    bool bResult = false;

    String strPair =
        _branchBusiness.earthSixPair(_easyBusiness.earthAtFromRow(intRow));

    bResult = (strPair == _easyBusiness.earthAtFromRow(nOtherRow));

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
  bool isSymbolDayPair(String stringSymbol) {
    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    return isEarthPairDay(strEarth, _easyBusiness.dayEarth());
  }

  bool isSymbolMonthPair(String stringSymbol) {
    String strEarth = _easyBusiness.symbolEarth(stringSymbol);

    bool bResult = isEarthPairMonth(strEarth, _easyBusiness.monthEarth());

    return bResult;
  }

  ///`--爻的三合`//////////////////////////////////////////////////////

  List earthAtMergeRowArray(List arrayRow) {
    List arrayEarth = [];

    for (int intItem in arrayRow) {
      arrayEarth.add(_easyBusiness.earthAtMergeRow(intItem));
    } //endf

    return arrayEarth;
  }

  List virtualEarthThreePair(List arrayPair, List arrayRow) {
    List arrayResult = [];

    List arrayEarth = earthAtMergeRowArray(arrayRow);

    List arrayRowPaired = [];
    for (String item in arrayPair) {
      if (-1 != arrayEarth.indexOf(item)) {
        arrayRowPaired.add(arrayEarth.indexOf(item));
      }
      //else cont.
    } //endf

    if (arrayRowPaired.length == 3) {
      List movementArray = movementIndexArray();

      for (String item in arrayRowPaired) {
        if (-1 == movementArray.indexOf(item)) arrayResult.add(item);
        //else cont.
      } //endf
    }
    //else cont.

    return arrayResult;
  }

  List earthThreePairInArray(List arrayEarth) {
    List arrayResult = [];

    if (-1 != arrayEarth.indexOf("子")) {
      if (-1 != arrayEarth.indexOf("申") && -1 != arrayEarth.indexOf("辰")) {
        arrayResult.add("申子辰合成水局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("酉")) {
      if (-1 != arrayEarth.indexOf("巳") && -1 != arrayEarth.indexOf("丑")) {
        arrayResult.add("巳酉丑合成金局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("午")) {
      if (-1 != arrayEarth.indexOf("寅") && -1 != arrayEarth.indexOf("戌")) {
        arrayResult.add("寅午戌合成火局");
      }
      //else cont.
    }

    if (-1 != arrayEarth.indexOf("卯")) {
      if (-1 != arrayEarth.indexOf("亥") && -1 != arrayEarth.indexOf("未")) {
        arrayResult.add("亥卯未合成木局");
      }
      //else cont.
    }
    //else cont.

    return arrayResult;
  }

  ///`六冲章第二十`//////////////////////////////////////////////////////
  bool isEasySixConflict(Map easyDictionary) {
    bool bResult = false;

    List conflictArray = [];

    List dataArray = easyDictionary["data"];
    for (int index = 0; index < dataArray.length; index++) {
      String basicEarth = _easyBusiness.symbolEarth(dataArray[index]);
      for (int indexOther = 0; indexOther < dataArray.length; indexOther++) {
        if (index != indexOther) {
          String otherEarth = _easyBusiness.symbolEarth(dataArray[indexOther]);
          if (_branchBusiness.isEarthConflict(basicEarth, otherEarth)) {
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
    if (!_inputEasyModel.isMovementAtRow(intRow)) {
      if (isSymbolHealthStrong(intRow, easyType)) {
        result = isSymbolConflictDayAtRow(intRow, easyType);
      }
      //else cont.
    }
    //else cont.

    return result;
  }

  ///`卦变生克墓绝章第二十四`/////////////////////////////////////////////////////
  String easyParent() {
    String fromElement = _easyBusiness
        .eightDiagrams()
        .elementOfEasy(_easyBusiness.fromEasyName());
    String toElement =
        _easyBusiness.eightDiagrams().elementOfEasy(_easyBusiness.toEasyName());
    String strParent = SABElementModel.elementRelative(fromElement, toElement);
    return strParent;
  }

  ///`反伏章第二十五`//////////////////////////////////////////////////////////////
  bool isEasyRepeatedGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyWihtInRepeated() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasySame();
    //else cont.

    return bResult;
  }

  bool isEasyOutsideRepeated() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

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

    String fromPlace = _easyBusiness
        .eightDiagrams()
        .easyPlaceByName(_easyBusiness.fromEasyName());
    String toPlace = _easyBusiness
        .eightDiagrams()
        .easyPlaceByName(_easyBusiness.toEasyName());
    String strConflictPlace = dictGuaConflict[fromPlace];
    bResult = strConflictPlace == toPlace;
    return bResult;
  }

  bool isEasyRestrictsGroan() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyWihtInRestricts() {
    //内卦伏吟
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

    if (inMovementArray.length > 0 && outMovementArray.length == 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasyOutsideRestricts() {
    //外卦伏吟
    bool bResult = false;

    List inMovementArray = _inputEasyModel.inGuaMovementArray();

    List outMovementArray = _inputEasyModel.outGuaMovementArray();

    if (inMovementArray.length == 0 && outMovementArray.length > 0)
      bResult = isEasyRestricts();
    //else cont.

    return bResult;
  }

  bool isEasySame() {
    //卦变者，内外动而反伏者同一卦也, 如乾卦变震卦是也。
    bool bResult = true;

    for (int intIndex = 0; intIndex < 6; intIndex++) {
      if (_easyBusiness.earthAtFromRow(intIndex) !=
          _easyBusiness.earthAtChangeRow(intIndex)) {
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
      if (_easyBusiness.earthAtFromRow(intIndex) !=
          _easyBusiness.earthAtChangeRow(intIndex)) {
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
//        String fromEarth = _easyBusiness.earthAtFromRow(intIndex);
//        String toEarth = _easyBusiness.earthAtChangeRow(intIndex ];
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

  EmptyEnum symbolBasicEmptyState(String stringSymbol) {
    EmptyEnum nResult = EmptyEnum.Empty_False;
    if ("" != stringSymbol) {
      String earth = _easyBusiness.symbolEarth(stringSymbol);
      if (-1 != emptyEarth().indexOf(earth)) {
        String strDay = _easyBusiness.dayEarth();
        if (_branchBusiness.isEarthConflict(strDay, earth)) {
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

    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);

    if ("" != stringSymbol) {
      String earth = _easyBusiness.symbolEarth(stringSymbol);
      if (-1 != emptyEarth().indexOf(earth)) {
        String strDay = _easyBusiness.dayEarth();
        if (_branchBusiness.isEarthConflict(strDay, earth)) {
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
    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);
    bool bResult = symbolBasicEmptyState(stringSymbol) == EmptyEnum.Empty_YES;

    return bResult;
  }

  bool isSymbolChangeEmpty(int intIndex) {
    bool bResult = false;
    if (_inputEasyModel.isMovementAtRow(intIndex)) {
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
    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);

    //月破为空
    MonthBrokenEnum stateEmpty = symbolMonthBrokenState(stringSymbol);

    if (MonthBrokenEnum.Broken_NO == stateEmpty ||
        MonthBrokenEnum.Broken_Move == stateEmpty ||
        MonthBrokenEnum.Broken_MoveBorn == stateEmpty)
      ;
    else
      bResult = true;

    //有气不动亦为空
    String stringSymbolSeason = symbolSeason(stringSymbol);
    bool bWang = ("旺" == stringSymbolSeason) || ("相" == stringSymbolSeason);

    bool bMove = _easyBusiness.isSymbolMovement(stringSymbol);
    if (!bMove && !bWang) bResult = true;
    //else cont.

    //伏而被克亦为空
    if (easyType == EasyTypeEnum.hide) {
      String fromSymbol = _easyBusiness.symbolAtFromRow(intRow);
      isSymbolRestrict(stringSymbol, fromSymbol);
    }
    //else cont.

    //真空为空，真空者，春土夏金秋是木，三冬逢火是真空。
    bool bRealEmpty = "死" == symbolSeason(stringSymbol);
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

    String stringSymbol = _easyBusiness.symbolAtRow(intRow, easyType);
    String strSeason = symbolSeason(stringSymbol);

    //旺不为空；
    bResult = bResult || "旺" == strSeason;

    if (easyType == EasyTypeEnum.from) {
      bool bMove = _easyBusiness.isSymbolMovement(stringSymbol);
      //动不为空；
      bResult = bResult || bMove;
    }
    //else cont.

    //有日建生扶者，亦不为空；
    bool bDayBorn = isSymbolDayBorn(stringSymbol);
    bResult = bResult || bDayBorn;

    if (easyType == EasyTypeEnum.from || easyType == EasyTypeEnum.hide) {
      //有动爻生扶者，亦不为空；
      bool bMoveBorn = isSymbolMoveBorn(stringSymbol);
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
    String stringSymbol = _easyBusiness.symbolAtHideRow(intRow);
    return isSymbolSeasonStrong(stringSymbol);
  }

  String emptyEarth() {
    String strResult = "";

    String strSkyTrunk = _easyBusiness.skyTrunkString();
    String strDayTrunk = _easyBusiness.daySky();
    int indexTrunk = strSkyTrunk.indexOf(strDayTrunk);

    String strEarthBranch = _easyBusiness.earthBranchString();
    String strDayBranch = _easyBusiness.dayEarth();
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
    String fromEarth = _easyBusiness.earthAtFromRow(intRow);
    String strTo = _easyBusiness.earthAtFromRow(intRow);
    String strTwelve = _branchBusiness.earthTwelveGod(fromEarth, strTo);
    bResult = "墓" == strTwelve;
    return bResult;
  }

//随鬼入墓
  bool isSymbol_SuiGuiRuMu_AtRow(int intRow) {
    bool bResult = false;
    String strSymbol = _easyBusiness.symbolAtFromRow(intRow);
    String strParent = _easyBusiness.symbolParent(strSymbol);
    bool bGui = "官鬼" == strParent;
    bool bRuMu = isSymbolChangeMuAtRow(intRow);

    bResult = bGui && bRuMu;

    return bResult;
  }

  ///`月破章第二十七`//////////////////////////////////////////////////////
  MonthBrokenEnum symbolConflictStateOnMonth(
      String stringSymbol, String monthEarth) {
    MonthBrokenEnum nResult = MonthBrokenEnum.Broken_NO;
    String basicEarth = _easyBusiness.symbolEarth(stringSymbol);
    bool conflictMonth =
        _branchBusiness.isEarthConflict(basicEarth, monthEarth);
    if (conflictMonth) {
      nResult = MonthBrokenEnum.Broken_YES;

      String strDayEarth = _easyBusiness.dayEarth();
      if (strDayEarth == basicEarth)
        nResult = MonthBrokenEnum.Broken_OnDay;
      else if (_easyBusiness.isSymbolMovement(stringSymbol)) {
        nResult = MonthBrokenEnum.Broken_Move;
      } else {
        //唯静而不动，又无日辰动爻生助，实则到底而破矣。
        if (_branchBusiness.isEarthBorn(_easyBusiness.dayEarth(), basicEarth)) {
          nResult = MonthBrokenEnum.Broken_DayBorn;
        } else if (isSymbolMoveBorn(stringSymbol)) {
          nResult = MonthBrokenEnum.Broken_MoveBorn;
        }
        //else cont.
      } //endi
    }
    //else cont.

    return nResult;
  }

  MonthBrokenEnum symbolMonthBrokenState(String stringSymbol) {
    MonthBrokenEnum nResult = MonthBrokenEnum.Broken_NO;

    nResult =
        symbolConflictStateOnMonth(stringSymbol, _easyBusiness.monthEarth());

    return nResult;
  }

  ///`飞伏章第二十八`//////////////////////////////////////////////////////

  bool isHideSymbolAtRow(int intIndex) {
    return usefulGodRow() - ROW_FLY_BEGIN == intIndex;
  }

  bool isHideGodInvalidAtRow(int intRow) {
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

    String basicSymbol = _easyBusiness.symbolAtHideRow(intRow);
    if (null != basicSymbol && "" != basicSymbol) {
      //伏神休囚无气者，一也。
      bool bStrong = isSymbolHealthStrong(
          intRow, EasyTypeEnum.hide); //isSymbolSeasonStrong(basicSymbol);
      if (!bStrong) {
        bResult = true;
      } else {
        //伏神被日月冲克者，二也。
        bool bFromDayConflict =
            DayConflictEnum.Conflict_NO != symbolDayConflictState(basicSymbol);
        bool bFromMonthConflict =
            MonthBrokenEnum.Broken_NO != symbolMonthBrokenState(basicSymbol);
        bool bFromMonthRestrict = isSymbolMonthRestrict(basicSymbol);
        bool bFromDayRestrict = isSymbolDayRestrict(basicSymbol);

        if (bFromDayConflict ||
            bFromMonthConflict ||
            bFromMonthRestrict ||
            bFromDayRestrict) {
          bResult = true;
        } else {
          //伏神被旺相之飞神克害者，三也。
          String fromSymbol = _easyBusiness.symbolAtFromRow(intRow);
          String strRelative = symbolRelative(fromSymbol, basicSymbol);
          bool bFromStrong = isSymbolSeasonStrong(basicSymbol);
          if ("官鬼" == strRelative && bFromStrong) {
            bResult = true;
          } else {
            //伏神墓绝于日月飞爻者，四也。
            String basicEarth = _easyBusiness.symbolEarth(basicSymbol);
            String fromEarth = _easyBusiness.symbolEarth(fromSymbol);

            String monthTwelve = _branchBusiness.earthTwelveGod(
                basicEarth, _easyBusiness.monthEarth());
            String dayTwelve = _branchBusiness.earthTwelveGod(
                basicEarth, _easyBusiness.dayEarth());
            String fromTwelve =
                _branchBusiness.earthTwelveGod(basicEarth, fromEarth);
            if (null != monthTwelve ||
                null != dayTwelve ||
                null != fromTwelve) {
              bResult = true;
            } else {
              //伏神休囚值旬空月破者，五也。

              bool bEmpty = isEmptyAtRow(intRow, EasyTypeEnum.hide);
              bool bMonthBroken = MonthBrokenEnum.Broken_YES ==
                  symbolMonthBrokenState(fromSymbol);
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

  bool isHideGodValidAtRow(int intRow) {
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
    String basicSymbol = _easyBusiness.symbolAtHideRow(intRow);
    if (null != basicSymbol && "" != basicSymbol) {
      bool bOnDay = isSymbolOnDay(basicSymbol);
      bool bOnMonth = isSymbolOnMonth(basicSymbol);
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
          String fromSymbol = _easyBusiness.symbolAtFromRow(intRow);
          String strRelative = symbolRelative(fromSymbol, basicSymbol);
          if ("父母" == strRelative) {
            bResult = true;
          } else {
            //伏神得动爻生者，四也。
            if (isSymbolMoveBorn(basicSymbol)) {
              bResult = true;
            } else {
              //伏神得遇日月动爻冲克飞神者，五也。
              bool bFromDayConflict = DayConflictEnum.Conflict_NO !=
                  symbolDayConflictState(fromSymbol);
              bool bFromMonthConflict = MonthBrokenEnum.Broken_NO !=
                  symbolMonthBrokenState(fromSymbol);
              bool bFromMoveConflict = isSymbolMoveConflict(fromSymbol);
              bool bFromMonthRestrict = isSymbolMonthRestrict(fromSymbol);
              bool bFromDayRestrict = isSymbolDayRestrict(fromSymbol);
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
                bool bFromMonthBroken = MonthBrokenEnum.Broken_YES ==
                    symbolMonthBrokenState(fromSymbol);
                bool bFromDayBroken = DayConflictEnum.Conflict_BROKEN ==
                    symbolDayConflictState(fromSymbol);
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

  bool isSymbolMoveConflict(String stringSymbol) {
    bool bResult = false;

    List arrayEffects = movementIndexArray();

    for (int numItem in arrayEffects) {
      String stringSymbolItem = _easyBusiness.symbolAtFromRow(numItem);
      if (isEffectableRow(numItem, EasyTypeEnum.from)) {
        if (_branchBusiness.isEarthConflict(
            _easyBusiness.symbolEarth(stringSymbol),
            _easyBusiness.symbolEarth(stringSymbolItem))) {
          bResult = true;
          break;
        }
        //else cont.
      }
      //else cont.
    } //endf
    return bResult;
  }

  List usefulGodHideRowArray() {
    List usefulArray = [];
    String usefulParent = _inputEasyModel.getUsefulGod();

    if (null != usefulParent) {
      usefulArray =
          arrayRowWithParent(usefulParent, _easyBusiness.placeFirstEasy());
    }
    //else cont.

    return usefulArray;
  }

  ///`进神退神章第二十九`//////////////////////////////////////////////////////
  String symbolForwardOrBack(String fromEarth, String toEarth) {
    String result = "";

    if (_branchBusiness.isEarthForward(fromEarth, toEarth))
      result = "化进";
    else if (_branchBusiness.isEarthBack(fromEarth, toEarth)) result = "化退";
    //else cont.

    return result;
  }

  bool isSymbolChangeForwardAtRow(int intIndex) {
    bool bResult = false;
    if (_inputEasyModel.isMovementAtRow(intIndex)) {
      String fromEarth = _easyBusiness.earthAtFromRow(intIndex);
      String toEarth = _easyBusiness.earthAtChangeRow(intIndex);
      bResult = _branchBusiness.isEarthForward(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  bool isSymbolChangeBackAtRow(int intIndex) {
    bool bResult = false;
    if (_inputEasyModel.isMovementAtRow(intIndex)) {
      String fromEarth = _easyBusiness.earthAtFromRow(intIndex);
      String toEarth = _easyBusiness.earthAtChangeRow(intIndex);
      bResult = _branchBusiness.isEarthBack(fromEarth, toEarth);
    }
    //else cont.

    return bResult;
  }

  ///`两现章第三十二`//////////////////////////////////////////////////////
  List usefulGodRowArray() {
    List usefulArray = [];
    String usefulParent = _inputEasyModel.getUsefulGod();

    if (null != usefulParent) {
      usefulArray =
          arrayRowWithParent(usefulParent, _easyBusiness.fromEasyDictionary());
    }
    //else cont.

    return usefulArray;
  }

  int indexOfUseGodInEasy(Map easyDictionary) {
    int result = globalRowInvalid;

    String usefulParent = _inputEasyModel.getUsefulGod();

    if (null != usefulParent) {
      List usefulArray = arrayRowWithParent(usefulParent, easyDictionary);

      if (usefulArray.length == 1) {
        result = usefulArray[0];
      } else if (usefulArray.length == 0) {
        result = noUsefulGod();
      } else {
        result = multiUsefulGod(easyDictionary, usefulArray);
      } //endi
    }
    //else cont.

    return result;
  }

  int noUsefulGod() {
    int result = globalRowInvalid;

    String usefulParent = _inputEasyModel.getUsefulGod();

    String fromEasyName = _easyBusiness.fromEasyName();

    String fromEasyElement =
        _easyBusiness.eightDiagrams().elementOfEasy(fromEasyName);

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
        Map fristEasy = _easyBusiness.placeFirstEasy();
        result = ROW_FLY_BEGIN + indexOfUseGodInEasy(fristEasy);
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

  int multiUsefulGod(Map easyDictionary, List usefulArray) {
    int result = globalRowInvalid;

    List dataArray = easyDictionary["data"];

    result = monthBrokenUsefulGod(dataArray, usefulArray);

    return result;
  }

  int monthBrokenUsefulGod(List dataArray, List usefulArray) {
    int result = globalRowInvalid;

    List listMonthBroken = monthBrokenArray(dataArray, usefulArray);
    if (0 == listMonthBroken.length) {
      result = emptyUsefulGod(dataArray, usefulArray);
    } else if (1 == listMonthBroken.length) {
      result = listMonthBroken[0];
    } else if (listMonthBroken.length > 1) {
      result = emptyUsefulGod(dataArray, listMonthBroken);
    }
    return result;
  }

  int emptyUsefulGod(List dataArray, List usefulArray) {
    int result = globalRowInvalid;

    List listEmpty = emptyArray(dataArray, usefulArray);

    if (0 == listEmpty.length) {
      result = movementUsefulGod(dataArray, usefulArray);
    } else if (1 == listEmpty.length) {
      result = listEmpty[0];
    } else if (listEmpty.length > 1) {
      result = movementUsefulGod(dataArray, listEmpty);
    }

    return result;
  }

  int movementUsefulGod(List dataArray, List usefulArray) {
    int result = globalRowInvalid;

    List movementArray = movementArrayInArray(usefulArray);
    if (0 == movementArray.length) {
      result = strongUsefulGod(dataArray, usefulArray);
    } else if (1 == movementArray.length) {
      result = movementArray[0];
    } else if (movementArray.length > 1) {
      result = strongUsefulGod(dataArray, movementArray);
    }
    return result;
  }

  int strongUsefulGod(List dataArray, List usefulArray) {
    int result = globalRowInvalid;

    //旺、相、余气, 依次选用,有旺用旺，如果有多个旺，通过动静区分；

    List strongArray = strongUsefulArray(dataArray, usefulArray);

    if (0 == strongArray.length) {
      result = lifeOrGoalUsefulGod(dataArray, usefulArray);
    } else if (1 == strongArray.length) {
      result = strongArray[0];
    } else if (strongArray.length > 1) {
      result = lifeOrGoalUsefulGod(dataArray, strongArray);
    }

    return result;
  }

  int lifeOrGoalUsefulGod(List dataArray, List usefulArray) {
    int result = globalRowInvalid;

    //世爻位置上的用神
    int lifeIndex = _easyBusiness.getLifeIndex();

    for (int intItem in usefulArray) {
      if (lifeIndex == intItem) {
        result = lifeIndex;
        break;
      }
      //else cont.
    } //endf

    if (globalRowInvalid == result) {
      //应爻位置上的用神
      int goalIndex = _easyBusiness.goalIndex();

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
      result = unKnowUsefulGod(dataArray, usefulArray);
    }
    //else cont.

    return result;
  }

  int unKnowUsefulGod(List dataArray, List usefulArray) {
    int result = usefulArray[0]; //globalRowInvalid;

    //TODO:丰富用神的选取规则：按旺相休囚死的顺序排列；或者按照强弱顺序排序。
    //其实此时应该已经知道用神衰弱，事情很难成功。
    //    colog("error!");

    return result;
  }

  List strongUsefulArray(List dataArray, List usefulArray) {
    //舍其休囚而用旺相；
    List strongArray = List();

    int maxIndex = globalRowInvalid;
    double maxValue = -10000;

    for (int intItem in usefulArray) {
      double strongValue = symbolHealthAtRow(intItem, EasyTypeEnum.from);
      if (maxValue < strongValue) {
        maxValue = strongValue;
        maxIndex = intItem;
      }
      //else cont.
    } //endf

    for (int intItem in usefulArray) {
      double strongValue = symbolHealthAtRow(intItem, EasyTypeEnum.from);
      if (strongValue == maxValue) {
        strongArray.add(intItem);
      }
      //else cont.

    } //endi

    return strongArray;
  }

  List emptyArray(List dataArray, List usefulArray) {
    //舍其旬空而用不空；          野鹤：舍其不空而用旬空；
    List emptyArray = List();
    for (int intItem in usefulArray) {
      String stringSymbol = dataArray[intItem];
      if (symbolBasicEmptyState(stringSymbol) != EmptyEnum.Empty_NO) {
        emptyArray.add(intItem);
      }
      //else cont.
    } //endf

    return emptyArray;
  }

  List movementArrayInArray(List usefulArray) {
    //舍其静爻而用动爻；
    List movementArray = List();
    for (int intItem in usefulArray) {
      if (_inputEasyModel.isMovementAtRow(intItem)) {
        movementArray.add(intItem);
      }
      //else cont.
    } //endf

    return movementArray;
  }

  List monthBrokenArray(List dataArray, List usefulArray) {
    //古法：舍其月破而用不破；     野鹤：舍其不破而用月破(采用)；
    List monthBrokenArray = List();
    for (int intItem in usefulArray) {
      String stringSymbol = dataArray[intItem];
      if (MonthBrokenEnum.Broken_NO != symbolMonthBrokenState(stringSymbol))
        monthBrokenArray.add(intItem);
      //else cont.

    } //endf

    return monthBrokenArray;
  }
}
