import 'package:flutter/material.dart';
import '../../1L_Context/SACGlobal.dart';
import '../Health/SABSymbolHealthModel.dart';
import '../Easy/SABSymbolWordsModel.dart';
import '../Logic/SABSymbolLogicModel.dart';

class SABSymbolDetailModel {
  SABSymbolDetailModel(this.healthSymbol) {
    this.stringDeity = logicModel().getDiety(EasyTypeEnum.from);
    this.stringAnimal = wordsModel().stringAnimal;
    configSymbolAndHealth();
  }
  SABSymbolHealthModel healthSymbol;
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
          healthSymbol.stringHideHealth +
          ']';
    } else
      this.stringHideSymbolH = '';

    this.stringFromEasySymbolH = wordsModel().getSymbolName(EasyTypeEnum.from) +
        '[' +
        healthSymbol.stringFromEasySymbolHealth +
        ']';

    if (wordsModel().bMovement) {
      this.stringToEasySymbolH = wordsModel().getSymbolName(EasyTypeEnum.to) +
          '[' +
          healthSymbol.stringHideHealth +
          ']';
    } else
      this.stringToEasySymbolH = '';
  }

  void configMonthRelation() {
    this.stringHideMonthR = '';
    if ('用神' == this.stringDeity) {
      this.stringHideMonthR = '';
      this.stringHideDayR = '';
    } else {
      this.stringHideMonthR = '';
      this.stringHideDayR = '';
    }

    this.stringFromMonthR = '';
    this.stringFromDayR = '';

    if (wordsModel().bMovement) {
      this.stringToMonthR = '';
      this.stringToDayR = '';
    } else {
      this.stringToMonthR = '';
      this.stringToDayR = '';
    }
  }

  String aaa(EasyTypeEnum easyTypeEnum) {
    //if (logicModel().getConflictOnDayState(easyTypeEnum)) {}
    return '';
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABSymbolLogicModel logicModel() {
    return this.healthSymbol.inputLogicSymbol;
  }

  SABSymbolWordsModel wordsModel() {
    return logicModel().inputWordsSymbol;
  }
}
