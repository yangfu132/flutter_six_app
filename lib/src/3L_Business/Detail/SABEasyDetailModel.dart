import '../Analysis/SABEasyAnalysisModel.dart';
import 'SABSymbolDetailModel.dart';

class SABEasyDetailModel {
  SABEasyDetailModel(this._analysisModel);
  final SABEasyAnalysisModel _analysisModel;
  String stringDetailName;
  List _listSymbols;

  List detailList() {
    List listResult = [
      [
        '事情',
        '六神',
        '六爻冲合',
        '补充月',
        '补充日',
        '本：补充',
        '世应',
        '进化',
        '变：补充',
        '变月',
        '变日',
      ]
    ];

    // String stringDeity; //事情
    // String stringAnimal; //六神
    // String stringHideSymbolH; //伏神生克
    // String stringHideMonthR;
    // String stringHideDayR;
    // String stringHideEasy;
    // String stringHealth;
    // String stringConflictOrPair; //六爻冲合
    // String stringFromMonthR;
    // String stringFromDayR;
    // String stringFromEasySymbolH;
    // String stringGoal; //世应
    // String stringChange; //进化
    // String stringToEasySymbolH;
    // String stringToMonthR;
    // String stringToDayR;

    for (SABSymbolDetailModel symbol in _symbolsArray()) {
      List listItem = [
        symbol.stringDeity,
        symbol.stringAnimal,
        symbol.stringHideSymbolH,
        symbol.stringHideMonthR,
        symbol.stringHideDayR,
        symbol.stringHideEasy,
        symbol.stringHealth,
        symbol.stringConflictOrPair,
        symbol.stringFromMonthR,
        symbol.stringFromDayR,
        symbol.stringFromEasySymbolH,
        symbol.stringGoal,
        symbol.stringChange,
        symbol.stringToEasySymbolH,
        symbol.stringToMonthR,
        symbol.stringToDayR,
      ];
      listResult.add(listItem);
    }

    return listResult;
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////

  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        ;
        SABSymbolDetailModel model =
            SABSymbolDetailModel(_analysisModel.symbolAtRow(intRow));
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolDetailModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }
}
