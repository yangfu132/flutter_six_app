import 'package:flutter/material.dart';
import '../../1L_Context/SACGlobal.dart';
import '../Health/SABSymbolHealthModel.dart';
import '../Easy/SABSymbolWordsModel.dart';
import '../Logic/SABSymbolLogicModel.dart';
import '../Analysis/SABSymbolAnalysisModel.dart';

class SABSymbolDetailModel {
  SABSymbolDetailModel(this.inputAnalysisSymbol) {
    this.stringDeity = logicModel().getDiety(EasyTypeEnum.from);
    this.stringAnimal = wordsModel().stringAnimal;
    configSymbolAndHealth();
    configMonthOrDayRelation();
  }

  SABSymbolAnalysisModel inputAnalysisSymbol;
  String stringDeity; //事情
  String stringAnimal; //六神
  String stringHideSymbolH; //伏神生克
  String stringHideMonthR;
  String stringHideDayR;
  String stringHideEasy;
  String stringHealth;
  String stringConflictOrPair; //六爻冲合
  String stringFromMonthR;
  String stringFromDayR;
  String stringFromEasySymbolH;
  String stringGoal; //世应
  String stringChange; //进化
  String stringToEasySymbolH;
  String stringToMonthR;
  String stringToDayR;

  void configSymbolAndHealth() {
    if ('用神' == this.stringDeity) {
      this.stringHideSymbolH = wordsModel().getSymbolName(EasyTypeEnum.hide) +
          '[' +
          healthSymbol().stringHideHealth +
          ']';
    } else
      this.stringHideSymbolH = '';

    this.stringFromEasySymbolH = wordsModel().getSymbolName(EasyTypeEnum.from) +
        '[' +
        healthSymbol().stringFromEasySymbolHealth +
        ']';

    if (wordsModel().bMovement) {
      this.stringToEasySymbolH = wordsModel().getSymbolName(EasyTypeEnum.to) +
          '[' +
          healthSymbol().stringHideHealth +
          ']';
    } else
      this.stringToEasySymbolH = '';
  }

  void configMonthOrDayRelation() {
    this.stringHideMonthR = '';
    if ('用神' == this.stringDeity) {
      this.stringHideMonthR =
          analysisSymbol().getMonthRelation(EasyTypeEnum.hide);
      this.stringHideDayR = analysisSymbol().getDayRelation(EasyTypeEnum.hide);
    } else {
      this.stringHideMonthR = '';
      this.stringHideDayR = '';
    }

    this.stringFromMonthR =
        analysisSymbol().getMonthRelation(EasyTypeEnum.from);
    ;
    this.stringFromDayR = analysisSymbol().getDayRelation(EasyTypeEnum.from);

    if (wordsModel().bMovement) {
      this.stringToMonthR = analysisSymbol().getMonthRelation(EasyTypeEnum.to);
      this.stringToDayR = analysisSymbol().getDayRelation(EasyTypeEnum.to);
    } else {
      this.stringToMonthR = '';
      this.stringToDayR = '';
    }
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  SABSymbolAnalysisModel analysisSymbol() {
    return this.inputAnalysisSymbol;
  }

  SABSymbolHealthModel healthSymbol() {
    return analysisSymbol().healthSymbol;
  }

  SABSymbolLogicModel logicModel() {
    return healthSymbol().inputLogicSymbol;
  }

  SABSymbolWordsModel wordsModel() {
    return logicModel().inputWordsSymbol;
  }
}
