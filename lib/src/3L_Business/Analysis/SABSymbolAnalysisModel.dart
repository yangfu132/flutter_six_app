import '../Health/SABSymbolHealthModel.dart';
import '../Easy/SABSymbolWordsModel.dart';
import '../Logic/SABSymbolLogicModel.dart';
import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';

class SABSymbolAnalysisModel {
  SABSymbolAnalysisModel(this.healthSymbol);
  final SABSymbolHealthModel healthSymbol;

  ///{
  ///monthRelation
  ///dayRelation
  ///}
  Map mapSymbolFrom = {};
  Map mapSymbolTo = {};
  Map mapSymbolHide = {};

  String getDayRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['dayRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['dayRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['dayRelation'];
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setDayRelation(EasyTypeEnum easyTypeEnum, String stringDayRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['dayRelation'] = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['dayRelation'] = stringDayRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['dayRelation'] = stringDayRelation;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  String getMonthRelation(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return mapSymbolFrom['monthRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return mapSymbolTo['monthRelation'];
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return mapSymbolHide['monthRelation'];
    } else {
      colog('easyTypeEnum:$easyTypeEnum');
      return 'easyTypeEnum:$easyTypeEnum';
    }
  }

  void setMonthRelation(EasyTypeEnum easyTypeEnum, String stringMonthRelation) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      mapSymbolFrom['monthRelation'] = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      mapSymbolTo['monthRelation'] = stringMonthRelation;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      mapSymbolHide['monthRelation'] = stringMonthRelation;
    } else
      colog('easyTypeEnum:$easyTypeEnum');
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABSymbolLogicModel logicModel() {
    return this.healthSymbol.inputLogicSymbol;
  }

  SABSymbolWordsModel wordsModel() {
    return logicModel().inputWordsSymbol;
  }
}
