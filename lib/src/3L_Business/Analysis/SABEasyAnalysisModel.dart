import 'SABSymbolAnalysisModel.dart';
import '../Health/SABHealthModel.dart';
import '../../1L_Context/SACGlobal.dart';

class SABEasyAnalysisModel {
  SABEasyAnalysisModel(this.inputHealthModel);
  final SABHealthModel inputHealthModel;

  List _listSymbols;

  /// `Public`//////////////////////////////////////////////////////////////

  /// `Get & Set`//////////////////////////////////////////////////////////////
  String getMonthRelation(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getMonthRelation(easyTypeEnum);
  }

  void setMonthRelation(
      int intRow, EasyTypeEnum easyTypeEnum, String stringMonthRelation) {
    symbolAtRow(intRow).setMonthRelation(easyTypeEnum, stringMonthRelation);
  }

  String getDayRelation(int intRow, EasyTypeEnum easyTypeEnum) {
    return symbolAtRow(intRow).getDayRelation(easyTypeEnum);
  }

  void setDayRelation(
      int intRow, EasyTypeEnum easyTypeEnum, String stringDayRelation) {
    symbolAtRow(intRow).setDayRelation(easyTypeEnum, stringDayRelation);
  }

  /// `加载函数`/////////////////////////////////////////////////////////////////
  List _symbolsArray() {
    if (null == _listSymbols) {
      _listSymbols = [];
      for (int intRow = 0; intRow < 6; intRow++) {
        SABSymbolAnalysisModel model =
            SABSymbolAnalysisModel(inputHealthModel.symbolAtRow(intRow));
        _listSymbols.add(model);
      }
    }
    return _listSymbols;
  }

  SABSymbolAnalysisModel symbolAtRow(int intRow) {
    return _symbolsArray()[intRow];
  }
}
