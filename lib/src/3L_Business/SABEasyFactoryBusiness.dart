import 'ExpertCategory/SABExpertCategoryBusiness.dart';
import 'Result/SABEasyResultModel.dart';
import 'Easy/SABEasyModel.dart';

///
///
class SABEasyFactoryBusiness {
  ///UI
  void showEasyResult() async {
    SABExpertCategoryBusiness expertCategory = SABExpertCategoryBusiness();
    // dynamic vc = expert.categoryController(
    //     await expert.getsCategory(), generateEasy(expert));
  }

  ///根据输入数据，计算输出结果
  Future<SABEasyResultModel> generateEasy(
      SABExpertCategoryBusiness expertCategory) async {
    String category = await expertCategory.getsCategory();
    SABEasyModel easyModel = SABEasyModel(category /*'目的'*/, category /*'用神'*/);
    SABEasyResultModel resultModel = SABEasyResultModel();
    return resultModel;
  }
}
