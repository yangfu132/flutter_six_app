import '../Logic/SABEasyLogicModel.dart';
import 'SABSymbolHealthModel.dart';

class SABHealthModel {
  SABHealthModel(this._inputLogicModel);
  final SABEasyLogicModel _inputLogicModel;
  bool bValidEasy = false;
  Map<int, double> _healthMap = {};
  List _finishedList = [];
  List _listSymbols;

  void setHealth(double numHealth, int nRow) {
    if (null == numHealth) {
      print('numHealth:$numHealth');
    }
    _healthMap[nRow] = numHealth;
  }

  double getHealth(int nRow) {
    if (null == _healthMap[nRow]) {
      print('nRow:$nRow');
    }
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

  /// `加载函数`/////////////////////////////////////////////////////////////////

  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        SABSymbolHealthModel model =
            SABSymbolHealthModel(_inputLogicModel.symbolAtRow(intRow));
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolHealthModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }
}
