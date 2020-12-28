import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../../4L_Service/SASStringService.dart';

import '../Easy/SABEasyDigitModel.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../Health/SABEasyHealthBusiness.dart';
import '../Analysis/SABEasyAnalysisBusiness.dart';
import '../Logic/SABEasyLogicDelegate.dart';
import '../Health/SABHealthModel.dart';
import '../Detail/SABEasyDetailModel.dart';

class SABEasyDetailBusiness extends SABEasyLogicDelegate {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel);
  SABEasyLogicBusiness _logicBusiness;
  SABEasyHealthBusiness _healthBusiness;
  SABEasyDetailModel _outputDetailModel;

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
      _outputDetailModel = SABEasyDetailModel(_healthBusiness.outHealthModel());
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
