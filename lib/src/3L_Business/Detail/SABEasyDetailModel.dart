import '../Analysis/SABEasyAnalysisModel.dart';
import 'SABSymbolDetailModel.dart';

class SABEasyDetailModel {
  SABEasyDetailModel(this._analysisModel);
  final SABEasyAnalysisModel _analysisModel;
  String stringDetailName;
  List _listSymbols;

  List detailList() {
    if (null == _listSymbols) {
      _listSymbols = [
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
        ],
      ];
      for (int intRow = 0; intRow < 6; intRow++) {
        List<String> listValue = [
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
        ];
        _listSymbols.add(listValue);
      }
    }
    return _listSymbols;
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
