import 'SABSymbolAnalysisModel.dart';
import '../Health/SABHealthModel.dart';

class SABEasyAnalysisModel {
  SABEasyAnalysisModel(this._healthModel);
  final SABHealthModel _healthModel;

  List _listSymbols;
  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        SABSymbolAnalysisModel model =
            SABSymbolAnalysisModel(_healthModel.symbolAtRow(intRow));
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolAnalysisModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }
}
