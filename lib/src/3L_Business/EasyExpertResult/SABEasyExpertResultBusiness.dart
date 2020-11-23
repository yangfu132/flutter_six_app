import 'SABEasyExpertResultModel.dart';
import '../Easy/SABEasyDigitModel.dart';

class SABEasyExpertResultBusiness {
  SABEasyExpertResultModel _expertModel;

  void configResultModel(SABEasyDigitModel inputEasyModel) {}
  SABEasyExpertResultModel expertModel() {
    if (null == _expertModel) {
      _expertModel = SABEasyExpertResultModel();
    }
    return _expertModel;
  }
}
