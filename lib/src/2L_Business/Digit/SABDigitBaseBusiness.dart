import '../../Context/SACGlobal.dart';
import '../Easy/SABEasyModel.dart';

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
class SABDigitBaseBusiness {
  double symbolBasicHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return 0;
  }

  double adjustHealth(int basicRow, EasyTypeEnum baseEasyType, int effectsRow,
      EasyTypeEnum effectEasyType) {
    return 0;
  }
}
