///输出Easy的结果文案

import '../Easy/SABEasyModel.dart';
import '../Health/SABEasyHealthBusiness.dart';
import '../../4L_Service/SASStringService.dart';

class SABResultBusiness {
  SABEasyModel inputModel;
  SABEasyHealthBusiness digitBusiness;
  SABResultBusiness() {
    digitBusiness.inputModel = inputModel;
  }
  String resultUsefulGode() {
    return "${inputModel.getUsefulGod()}，类像参见用神爻。";
  }

//基于世爻与用神的判定结果
  String resultSymbol() {
    String strResult = '卦体为主，世用为辅，如果是平常卦就以世用为主。';
    bool bValidEasy = digitBusiness.calculateHealth();
    if (bValidEasy) {
      strResult =
          SASStringService.appendToString(strResult, subresultSymbolStandard());
    } else
      strResult = SASStringService.appendToString(strResult, '六爻乱动，必须重新占卜！');
    return strResult;
  }

  String subresultSymbolStandard() {
    //General principles 普通原则：世用两旺

    String strResult = "";

    //生克
    // double lifeHealth = [self lifeHealth] - [self healthCriticalValue];

//         double lifeHealth = [self lifeHealth] - [self healthCriticalValue];
//  usefulHealth = [self usefulHealth] - [self healthCriticalValue];

//     if ( lifeHealth > 0  && usefulHealth > 0 )
//     {
//         strResult = [NSString stringWithFormat:@"世爻(%.4f)、用神(%.4f)两旺，事情可成",lifeHealth,usefulHealth];
//     }
//     else if ( lifeHealth > 0 && usefulHealth <= 0)
//     {
//         strResult = [NSString stringWithFormat:@"世爻旺(%.4f)，用神衰(%.4f)，用神失陷，事情难成",lifeHealth,usefulHealth];
//     }
//     else if (lifeHealth == 0 && usefulHealth > 0)
//     {
//         strResult = [NSString stringWithFormat:@"世爻平(%.4f)，用神旺(%.4f)，世爻未知",lifeHealth,usefulHealth];
//     }
//     else if ( lifeHealth == 0 && usefulHealth == 0 )
//     {
//         strResult = [NSString stringWithFormat:@"世爻平(%.4f)，用神平(%.4f)，世爻用神皆未知",lifeHealth,usefulHealth];
//     }
//     else if (lifeHealth == 0 && usefulHealth < 0)
//     {
//         strResult = [NSString stringWithFormat:@"世爻平(%.4f)，用神衰(%.4f)，用神失陷，事情难成。",lifeHealth,usefulHealth];
//     }
//     else if ( lifeHealth < 0 && usefulHealth >= 0 )
//     {
//         strResult = [NSString stringWithFormat:@"世爻衰(%.4f)，用神旺(%.4f)，世爻失陷，恐有不测。",lifeHealth,usefulHealth];
//     }
//     else if ( lifeHealth < 0 && usefulHealth < 0)
//     {
//         strResult = [NSString stringWithFormat:@"世爻(%f)、用神(%f)两衰，世爻失陷，十分不利",lifeHealth,usefulHealth];
//     }
//     else
//         CO_LOG(@"error!");

    return strResult;
  }

  String resultEasy() {
    return '';
  }

//反伏或者回头冲
  String resultRepeatedOrConflict() {
    return '';
  }

//六合卦或者六冲卦
  String resultSixPairOrConflict() {
    return '';
  }

//应期
  String resultHappenTime() {
    return '';
  }

  String easySixPairResult() {
    return '';
  }

  String easySixAgainstResult() {
    return '';
  }

  String resultEasyConflict() {
    return '';
  }

  String resultEasyRepeated() {
    return '';
  }

  String resultSixPairOrConflictTitle() {
    return '';
  }
}
