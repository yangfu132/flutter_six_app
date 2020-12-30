import '../Health/SABSymbolHealthModel.dart';

class SABSymbolDetailModel {
  SABSymbolDetailModel(this._healthSymbol) {
    // this.stringHealth = _healthSymbol;
  }
  SABSymbolHealthModel _healthSymbol;
  //TODO:继续细化
  String stringDeity; //事情
  String stringAnimal; //六神
  String stringHideSymbol; //伏神生克
  String stringHideMonth;
  String stringHideDay;
  String stringHideEasy;
  String stringHealth;
  String stringConflictOrPair; //六爻冲合
  String stringMonth;
  String stringDay;
  String stringFromEasy;
  String stringGoal; //世应
  String stringChange; //进化
  String stringToEasy;
  String stringToMonth;
  String stringToDay;
}
