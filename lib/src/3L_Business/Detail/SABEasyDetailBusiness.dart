import '../../1L_Context/SACGlobal.dart';
import '../Analysis/SABEasyAnalysisBusiness.dart';
import '../Detail/SABEasyDetailModel.dart';
import '../Easy/SABEasyDigitModel.dart';
import '../Health/SABEasyHealthBusiness.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../Logic/SABEasyLogicDelegate.dart';

class SABEasyDetailBusiness extends SABEasyLogicDelegate {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel);
  SABEasyLogicBusiness _logicBusiness;
  SABEasyHealthBusiness _healthBusiness;
  SABEasyDetailModel _outputDetailModel;
  SABEasyAnalysisBusiness _analysisBusiness;

  ///`SABEasyHealthDelegate`

  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType) {
    return healthBusiness().symbolHealthAtRow(nRow, easyType);
  }

  double healthCriticalValue() {
    return healthBusiness().healthCriticalValue();
  }

  List rowArrayAtOutRightLevel(OutRightEnum level) {
    return healthBusiness().rowArrayAtOutRightLevel(level);
  }

  ///`加载函数`
  SABEasyLogicBusiness logicBusiness() {
    if (null == _logicBusiness) {
      _logicBusiness = SABEasyLogicBusiness(_inputEasyModel, this);
    } //else cont.
    return _logicBusiness;
  }

  SABEasyHealthBusiness healthBusiness() {
    if (null == _healthBusiness) {
      _healthBusiness = SABEasyHealthBusiness(logicBusiness());
    } //else cont.
    return _healthBusiness;
  }

  SABEasyDetailModel outputDetailModel() {
    if (null == _outputDetailModel) {
      //TODO:细化detailmodel
      _outputDetailModel =
          SABEasyDetailModel(_analysisBusiness.outAnalysisModel());
      _outputDetailModel.stringDetailName = easyName();
      _outputDetailModel.detailList();
    }
    return _outputDetailModel;
  }

  String easyName() {
    String stringResult = '';
    String formatTime =
        logicBusiness().outLogicModel().inputWordsModel.stringFormatTime;
    String formatDate = formatTime.split(' ')[0];
    stringResult += '$formatDate ${_inputEasyModel.getUsefulDeity()} 补充';
    return stringResult;
  }
}
