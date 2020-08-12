///说明：
///Easy: 一次占卜实例
///place：八宫
///Branch：地支
///Trunk：天干
///EightDiagrams：八卦

enum EasyTypeEnum {
  from, //本卦
  to, //变卦
  hide, //伏卦
}

//note：代表无效的爻索引数，当未被复制的时候使用；
final int ROW_INVALID = -1;

//note：代表月柱对应到卦中的爻索引数；
final int ROW_MONTH = 7;

//note：代表日柱对应到卦中的爻索引数；
final int ROW_DAY = 8;

//note：代表伏卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
final int ROW_FLY_BEGIN = 10;

///note：代表伏卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
final int ROW_FLY_END = 16;

///note：代表变卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
final int ROW_CHNAGE_BEGIN = 20;

///note：代表变卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
final int ROW_CHNAGE_END = 26;

///最大防御值，不受生克影响
final double MAX_DEFENSIVE = 1.0;

enum EmptyEnum {
  Empty_NO, //非空
  Empty_YES, //空
  Empty_Conflict, //冲空不空
  Empty_False, //假空
  Empty_Real, //真空
  Empty_NoUseful, //用神未现
}

enum MonthBrokenEnum {
  Broken_NO, //非月破
  Broken_YES, //月破
  Broken_OnDay, //临日柱，不破
  Broken_Move, //动爻，不破
  Broken_DayBorn, //日生，不破
  Broken_MoveBorn, //动生，不破
}

enum DayConflictEnum {
  Conflict_NO, //非日冲
  Conflict_YES, //日冲
  Conflict_BROKEN, //日冲，弱而破
  Conflict_SAN, //旺相冲之不散，衰弱冲之则散,TODO:程序中都是按照散写的
  Conflict_BackMove, //日冲，强而暗动
}

//输出权利：有权对其他爻发生作用的权利
enum OutRightEnum {
  RIGHT_NULL, //0
  RIGHT_NULL1, //1,占位符，无意义
  RIGHT_NULL2, //2,占位符，无意义
  RIGHT_MOVE, //3,动
  RIGHT_STATIC, //4,静
  RIGHT_EMPTY, //5,空
  RIGHT_HIDE, //6,伏神
}
