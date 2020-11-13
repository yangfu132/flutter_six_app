import '../../1L_Context/SACGlobal.dart';
import '../../1L_Context/SACContext.dart';
import '../../4L_Service/SASStringService.dart';

import '../Easy/SABEasyDigitModel.dart';
import '../Logic/SABEasyLogicBusiness.dart';
import '../Health/SABEasyHealthBusiness.dart';
import '../Analysis/SABEasyAnalysisBusiness.dart';
import '../Logic/SABEasyLogicDelegate.dart';
import '../Health/SABHealthModel.dart';

class SABEasyDetailBusiness extends SABEasyLogicDelegate {
  final SABEasyDigitModel _inputEasyModel;
  SABEasyDetailBusiness(this._inputEasyModel);
  SABEasyLogicBusiness _logicBusiness;
  SABEasyHealthBusiness _healthBusiness;
  void aaaa() {}

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
}
