import 'SABEightDiagramsModel.dart';
import 'SABEasyModel.dart';
import '../../Context/SACContext.dart';

class SABEasyBusiness {
  SABEasyModel _easyModel;

  //八宫数据，可以改为类方法
  SABEightDiagramsModel _eightDiagrams;

  //方法注释：生成实例
  SABEasyModel generateEasy() {
    _easyModel.generateEasyArray();
  }

  //方法注释：本卦所属八宫的第一卦
  Map placeFirstEasy() {
    String firstKey = eightDiagrams()
        .firstEasyKeyInDiagram(eightDiagrams().easyPlaceByName(fromEasyName()));
    Map fristEasy = eightDiagrams().getEasyDictionaryForKey(firstKey);
    return fristEasy;
  }

  //方法注释：本卦的卦名
  String fromEasyName() {
    String strResult = "";
    Map fromDict = fromEasyDictionary();
    if (null != fromDict) {
      strResult = fromDict["name"];
    }
    //else cont.

    return strResult;
  }

  //方法注释：本卦的信息
  Map fromEasyDictionary() {
    Map result =
        _eightDiagrams.getEasyDictionaryForKey(_easyModel.fromEasyKey());

    return result;
  }

  //方法注释：获取当前爻所在的八卦
  String eightGuaAtFromRow(int nRow) {
    String result = "";

    String fromEasyKey = _easyModel.fromEasyKey();
    if (fromEasyKey.length >= 6) {
      String guaKey = "";
      if (nRow < 3)
        guaKey = fromEasyKey.substring(0, 3);
      else
        guaKey = fromEasyKey.substring(3, 6);

      result = SABEightDiagramsModel.palaceNameForKey(guaKey);
    } else
      colog("error!");

    return result;
  }
//万年历 -----------------------------------------------------------------------
  - (EightWordCalendar*) wordCalendar
{
    if (!_wordCalendar)
    {
        //
        NSTimeInterval easyTime = [self easyTime];
        if (easyTime > 0)
        {
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:easyTime];
            _wordCalendar = [[EightWordCalendar alloc] initWithDate:date];
        }
        //else cont.此时尚未加载数据
    }
    //else cont.
    
    return _wordCalendar;
}

//加载函数-----------------------------------------------------------------------

  //方法注释：六十四卦信息的加载函数
  SABEightDiagramsModel eightDiagrams() {
    if (null == _eightDiagrams) _eightDiagrams = SABEightDiagramsModel();
    //else cont.

    return _eightDiagrams;
  }
}
