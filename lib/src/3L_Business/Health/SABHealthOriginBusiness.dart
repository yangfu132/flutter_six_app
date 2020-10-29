import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../Logic/SABEasyLogicBusiness.dart';

/*
 
 爻的权力，比如官职的大小，官职大的可以管官职小的。
 
 月支好比省长，日支好比县长；或者 月支好比县委书记，日支好比县长。
 
 动爻好比豪强，虽然不是官员但是却有很大影响力。
 
 旺相静爻，好比富人，可以欺负穷人。
 
 休囚静爻，好比穷人，只能受气。
 
 数值表示发生变化的趋势有多大,生克其它爻的作用就越大.
 
 休囚的静爻：无生克权
 旺相的静爻：可以生克休囚的静爻
 动爻：可以生克所有的爻
 变爻：除了日月不受别人生克
 代表日月：可以生克所有爻
 
 合降低生克权，冲提高生克权
 
 这里有一个特殊的地方，变出之爻，暂时无法定论，因为他只能生克自己的动爻。
 
 并不是权力大的就能生克权利小的，而是代表生克的数值，比如每次的伤害值或者加持值，也可以叫做输出值。
 
 那有没有输入值？
 
 
 输出规则：目前只有规则没有数值
 
 旺相静爻可以影响休囚静爻；
 
 动爻（暗动）可以影响静爻与动爻；
 
 日月可以影响本爻、变爻、伏神；
 
 日将合爻，无输出能力；
 
 日将冲，旺相静爻，暗动增加输出能力；
 
 日将冲，休囚静爻，日破；
 
 输出值：对他人的影响
 
 日月的输出值是规定的
 
 其它要的输出值为自己的生命值（净值，被别人克掉的不算）
 
 
 
 防御值：被他人影响
 
 合的作用就是冻结
 
 月将合爻，不受伤害；除非日辰冲之；
 
 日主合爻，不受伤害；
 
 日月的防御值无限大，因为他们不受别人影响；
 
 其它爻的防御值为自己的生命值（净值，被别人克掉的不算），但是临的防御值与日月同
 
 生命值：
 
 日临、月临，不增不减至大之数。
 
 月：旺、余气、相、休、囚、死
 
 日：生旺墓绝
 
 占卜结果：
 
 最后还是看生命值的大小，所以说基本面的东西才是最重要的
 
 */
class SABHealthOriginBusiness {
  SABHealthOriginBusiness(this._inputLogicBusiness);

  Map<int, double> _healthMap;
  List _finishedList;

  final SABEasyLogicBusiness _inputLogicBusiness;

  ///`基础函数`//////////////////////////////////////////////////////

  void setHealth(double numHealth, int nRow) {
    _healthMap[nRow] = numHealth;
  }

  double getHealth(int nRow) {
    return _healthMap[nRow];
  }

  void addToFinishArray(int nRow) {
    if (-1 == _finishedList.indexOf(nRow)) {
      _finishedList.add(nRow);
    }
  }

  bool isUnFinish(int nRow) {
    return -1 == _finishedList.indexOf(nRow);
  }

  double healthDayOrMonthOn() {
    /*
     在没有日月临的情况下，爻能够达到的最大health为日主最大值 + 月将最大值 + 月合最大值;
     因为日月临是非常强大的力量，所以取这个最大的数值，不过实际的值应该比这个更大。
     */
    double maxSeason = earthHealthAtSeason("寅", "卯");

    double maxTwelve = earthHealthAtTwelveGod("寅", "卯");

    double maxMonthTwelve =
        earthHealthAtTwelveGod("寅", "卯") * (maxSeason * 3 / 10 / maxTwelve);

    double fResult =
        maxTwelve + (maxSeason + maxMonthTwelve) + healthMonthPair();

    return fResult;
  }

  double healthMonthPair() {
    double fResult = 0.0;
    int siIndex = arraySeason().indexOf("死");
    int xiangIndex = arraySeason().indexOf("相");
    if (-1 != siIndex && -1 != xiangIndex) {
      fResult = intervalSeason() * (siIndex - xiangIndex);
    } else
      colog("error!");

    return fResult;
  }

  List arraySeason() {
    List arrayStrong = ["旺", "相", "余气", "休", "囚", "死"];

    return arrayStrong;
  }

  ///原函数名rowArrayAtLevel
  List rowArrayAtOutRightLevel(OutRightEnum level) {
    List array = [];
    for (int nRow = 0; nRow < 6; nRow++) {
      if (level == symbolOutRightAtRow(nRow, EasyTypeEnum.from)) {
        array.add(nRow);
      }
      //else cont.

    } //endf
    return array;
  }

  ///`基础health （只计算日月的影响）`///////////////////////////////////////////////

  double dayHealthValue() {
    return 100.0;
  }

  double monthHealthValue() {
    return 100.0;
  }

  double earthHealthAtTwelveGod(String basicEarth, String atEarth) {
    double fResult = 1.0;

    String twelve = _inputLogicBusiness.earthTwelveGod(basicEarth, atEarth);

    /*
     长生、冠带、临官、帝旺为四旺运
     
     沐浴、死、墓、绝为四衰运
     
     胎、养、衰、病为四平运
     
     而以生旺墓绝为影响力最大，所以把这四个作为最大和最小的值，形成下面的对应关系；
     
     整个过程是我瞎编的，对不对，需要以后对地支的研究，进行进一步的论证；
     
     */

    //TODO:论证十二神数值的正确性

    /*
     疑惑的地方是为什么寅木在子水处沐浴，为衰运，
     但是子水生寅木应该为好运啊？这不是矛盾吗？
     看来不能数字化的东西都是扯淡。
     */

    /*
     为什么不能是负数？因为动爻的休囚也可以影响别人，如果是负数，克反而会增加生命值。
     */
    double base = 0;
    double interval = 0.1;
    if ("帝旺" == twelve) {
      fResult = base + interval * 11;
    } else if ("长生" == twelve) {
      fResult = base + interval * 10;
    } else if ("临官" == twelve) {
      fResult = base + interval * 9;
    } else if ("冠带" == twelve) {
      fResult = base + interval * 8;
    } else if ("衰" == twelve) {
      fResult = base + interval * 7;
    } else if ("病" == twelve) {
      fResult = base + interval * 6;
    } else if ("养" == twelve) {
      fResult = base + interval * 5;
    } else if ("胎" == twelve) {
      fResult = base + interval * 4;
    } else if ("沐浴" == twelve) {
      fResult = base + interval * 3;
    } else if ("死" == twelve) {
      fResult = base + interval * 2;
    } else if ("墓" == twelve) {
      fResult = base + interval * 1;
    } else if ("绝" == twelve) {
      fResult = base + interval;
    } else
      colog("error!");

    return fResult;
  }

  double intervalSeason() {
    double twelveMax = earthHealthAtTwelveGod("寅", "卯");

    //表达式原因参见healthAtMonth:
    double temp = (twelveMax - twelveMax * 0.1) * 3;
    temp = temp / 4;
    temp = temp / 6;

    return temp;
  }

  double earthHealthAtSeason(String basicEarth, String atEarth) {
    double fResult = 1.0;

    String season = _inputLogicBusiness.seasonDescription(basicEarth, atEarth);
    if (null != season) {
      double base = 0;

      double interval = intervalSeason();

      if ("旺" == season) {
        fResult = base + interval * 5;
      } else if ("余气" == season) {
        fResult = base + interval * 4;
      } else if ("相" == season) {
        fResult = base + interval * 3;
      } else if ("休" == season) {
        fResult = base + interval * 2;
      } else if ("囚" == season) {
        fResult = base + interval * 1;
      } else if ("死" == season) {
        fResult = base + interval;
      } else
        colog("error!");
    } else
      colog("error!");

    return fResult;
  }

  double earthHealthAtMonthAndDay(
      String basicEarth, String monthEarth, String dayEarth) {
    double fResult = earthHealthAtSeason(basicEarth, monthEarth);

    /*
     日主最大值为十二神的帝旺（1.2），为什么是1.2见healthAtTwelveGod的论述；
     《易冒》日主章第二十三
     “若以日月配爻象，用神投月将，则先论旺相休囚死，后论长生沐浴冠带临官帝旺衰病死墓绝胎养之法，如土爻用神，遇于巳月应相，其绝则轻，虽不可谓无绝，相与绝较，得相犹十之七，如遇申月其土则休，以生较休，得生犹十之七也。若日辰之生绝则独重，金遇巳而生者十之九，土遇巳而绝者十之九，唯以长生十二法而定衰旺。”
     
     x表示转化率，五法值表示五法影响的最大值；
     得到表达式为 月将十二神最大值 * x = 五法最大值 (3/10);
     
     《易冒》月将章第二十二 "日月之力相较，若月克日生，吉得十之八，日克月生，吉得十之七"
     得到表达式为 日主十二神最大值 - （月将五法最大值 + 月将十二神最大值 * x） = 日主十二神最大值 * 0.1;
     
     其中 月将十二神最大值 = 日主十二神最大值；也就是说十二神最大值是一样的。
     
     解出表达式 五法最大值 = 3/8; x = 5 / 22;
     
     */

    double maxSeason = earthHealthAtSeason("寅", "卯");

    double maxTwelve = earthHealthAtTwelveGod("寅", "卯");

    fResult += earthHealthAtTwelveGod(basicEarth, monthEarth) *
        (maxSeason * 3 / 10 / maxTwelve);

    if (_inputLogicBusiness.isEarthOnMonth(basicEarth, monthEarth)) {
      //月临
      fResult = healthDayOrMonthOn();
    } else if (_inputLogicBusiness.isEarthPairMonth(basicEarth, monthEarth)) {
      /*
         《增删卜易》六合章第十九 “爻静或与日月动爻合者，得合而起，即使爻值休囚亦有旺相之意。”
         但此处应该有问题，静爻是没有办法与别人合的；所以应该是爻静与日月合，休囚亦有旺相之意。
         */

      //月合
      if (fResult < healthCriticalValue())
        fResult = healthCriticalValue() * 1.1;
      //else cont.
    }
    //else cont.

    return fResult;
  }

  double earthHealthAtDayEarth(String basicEarth, String dayEarth) {
    double fResult = earthHealthAtTwelveGod(basicEarth, dayEarth);
    //日临
    if (_inputLogicBusiness.isOnDayEarth(basicEarth, dayEarth)) {
      fResult = healthDayOrMonthOn();
    } else if (_inputLogicBusiness.isEarthPairDay(basicEarth, dayEarth)) {
      //日合
      if (fResult < healthCriticalValue())
        fResult = healthCriticalValue() * 1.1;
      //else cont.
    }
    //else cont.

    return fResult;
  }

  double symbolBasicHealthAtRow(int nRow, EasyTypeEnum easyType) {
    double fResult = 0.0;

    String stringSymbol = _inputLogicBusiness.symbolAtRow(nRow, easyType);

    if ("" != stringSymbol) {
      String basicEarth = _inputLogicBusiness.symbolEarth(stringSymbol);

      //日
      if (_inputLogicBusiness.isEmptyAtRow(nRow, easyType))
        fResult = 0;
      else
        fResult =
            earthHealthAtDayEarth(basicEarth, _inputLogicBusiness.dayEarth());

      //月
      if (MonthBrokenEnum.Broken_NO !=
          _inputLogicBusiness.symbolConflictStateOnMonth(
              stringSymbol, _inputLogicBusiness.monthEarth()))
        fResult += 0;
      else
        fResult += earthHealthAtMonthAndDay(basicEarth,
            _inputLogicBusiness.monthEarth(), _inputLogicBusiness.dayEarth());
    } else
      colog("error!");

    return fResult;
  }

  double healthCriticalValue() {
    double fResult = 0.0;

    fResult = earthHealthAtDayEarth("寅", "巳");

    //TODO:月是有十二法与五法合算的，出入这个参数是否代表临界值；
    fResult += earthHealthAtMonthAndDay("寅", "巳", "巳");

    return fResult;
  }

  bool isBaseHealthStrong(int nRow, EasyTypeEnum easyType) {
    bool bResult = false;

    if (0 <= nRow && nRow < 6) {
      double health = symbolBasicHealthAtRow(nRow, easyType);

      bResult = health > healthCriticalValue();
    } else
      colog("error!");

    return bResult;
  }

  ///`输出值与输出权`//////////////////////////////////////////////////////

  double dayOutRight() {
    return 100;
  }

  double monthOutRight() {
    return 100;
  }

  OutRightEnum symbolOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;

    if (EasyTypeEnum.from == easyType) {
      fResult = fromOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.to == easyType) {
      fResult = toOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.hide == easyType) {
      fResult = hideOutRightAtRow(hashCode, easyType);
    } else
      colog("error!");

    return fResult;
  }

  OutRightEnum hideOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    return OutRightEnum.RIGHT_HIDE;
  }

  OutRightEnum toOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;

    return fResult;
  }

  OutRightEnum fromOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     7、旬空：无生克权
     6、休囚的静爻：无生克权
     5、旺相的静爻：可以生克休囚的静爻
     4、暗动：也叫半动，这个地方书籍不明确。我猜既然叫半动，必然不可以生克动爻，仅仅可以生克所有的静爻，比旺相静爻略强。
     3、动爻：可以生克所有的爻
     1、2代表日月：可以生克所有爻
     合是一种势，一种联系，日冲能打破这种势
     */

    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;
    String stringSymbol = _inputLogicBusiness.symbolAtRow(nRow, easyType);
    if (_inputLogicBusiness.symbolBasicEmptyState(stringSymbol) !=
        EmptyEnum.Empty_YES) {
      bool bPaireDay = _inputLogicBusiness.isSymbolDayPair(stringSymbol);
      bool bPaireMonth = _inputLogicBusiness.isSymbolMonthPair(stringSymbol);
      if (bPaireDay || bPaireMonth) {
        fResult = OutRightEnum.RIGHT_MOVE;
      } else {
        bool bConflictDay = _inputLogicBusiness.isSymbolConflictDayAtRow(
            nRow, EasyTypeEnum.from);
        bool bMove = _inputLogicBusiness.isSymbolMovement(stringSymbol);
        if (bMove)
          fResult = OutRightEnum.RIGHT_MOVE;
        else if (bConflictDay)
          fResult = OutRightEnum.RIGHT_MOVE;
        else
          fResult = OutRightEnum.RIGHT_STATIC;
      } //endi
    } else
      fResult = OutRightEnum.RIGHT_EMPTY;

    return fResult;
  }

  double dayOut() {
    double bResult = 1.2;

    return bResult;
  }

  double monthOut() {
    double bResult = 1;

    return bResult;
  }

  double conversionRateAtRow(int nRow, EasyTypeEnum easyType) {
    double fResult = 1.0;

    //TODO:转化率到底是多少

    if (_inputLogicBusiness.isEmptyAtRow(nRow, easyType))
      fResult = 0.0;
    else {
      if (_inputLogicBusiness.movementIndexArray().length > 0) {
        //动卦中静爻的作用没有那么大
        String stringSymbol = _inputLogicBusiness.symbolAtRow(nRow, easyType);
        if (!_inputLogicBusiness.isSymbolMovement(stringSymbol)) fResult = 0.5;
        //else cont.
      }
      //else cont.
    }
    //else cont.

    /*******************************************
     虽然这段代码是废话，因为临是不影响输出的；
     但是放在这里可以提醒自己不要忘记；
     if (_inputLogicBusiness.isSymbolOnMonth(stringSymbol))
     fResult = 1.0;
     //else cont.
     
     if (_inputLogicBusiness.isSymbolOnDay(stringSymbol))
     fResult = 1.0;
     //else cont.
     *******************************************/
    return fResult;
  }

  ///`防御值与防御权`//////////////////////////////////////////////////////

  double dayDefensiveRight() {
    return 100;
  }

  double monthDefensiveRight() {
    return 100;
  }

  double dayDefensive() {
    return 100.0;
  }

  double monthDefensive() {
    return 100.0;
  }

  double symbolDefensiveAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     防御值为0到1之间的数值，
     克：1代表完全不受别爻克，0为完全受克;目前只有0和1，还没有见到两者之间的数字呢。
     生：防御值不影响生
     */

    double bResult = 0.0;

    if (EasyTypeEnum.to != easyType) {
      String stringSymbol = _inputLogicBusiness.symbolAtRow(nRow, easyType);
      if ("" != stringSymbol) {
        if (_inputLogicBusiness.isSymbolOnMonth(stringSymbol))
          bResult = MAX_DEFENSIVE;
        else if (_inputLogicBusiness.isSymbolOnDay(stringSymbol))
          bResult = MAX_DEFENSIVE;
        else if (_inputLogicBusiness.isEmptyAtRow(nRow, easyType))
          bResult = MAX_DEFENSIVE;
        else if (_inputLogicBusiness.isSymbolMonthPair(stringSymbol))
          bResult = MAX_DEFENSIVE;
        else if (_inputLogicBusiness.isSymbolDayPair(stringSymbol))
          bResult = MAX_DEFENSIVE;
        //else cont.
      } else
        colog("error!");
    } else
      colog("error!");

    return bResult;
  }
}
