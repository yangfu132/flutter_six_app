import '../Health/SABSymbolHealthModel.dart';
import '../Easy/SABSymbolWordsModel.dart';
import '../Logic/SABSymbolLogicModel.dart';

class SABSymbolAnalysisModel {
  SABSymbolAnalysisModel(this.healthSymbol);
  final SABSymbolHealthModel healthSymbol;

  /// `加载函数`/////////////////////////////////////////////////////////////////
  SABSymbolLogicModel logicModel() {
    return this.healthSymbol.inputLogicSymbol;
  }

  SABSymbolWordsModel wordsModel() {
    return logicModel().inputWordsSymbol;
  }
}
