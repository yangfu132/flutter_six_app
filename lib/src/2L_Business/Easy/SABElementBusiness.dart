/*
 类说明：五行
 */

class SABElementBusiness {
  //方法注释：两个五行之间的关系
  static String elementRelative(String basicElement, String otherElement) {
    Map tempData = {
      "金金": "兄弟",
      "金木": "妻财",
      "金水": "子孙",
      "金火": "官鬼",
      "金土": "父母",
      "木金": "官鬼",
      "木木": "兄弟",
      "木水": "父母",
      "木火": "子孙",
      "木土": "妻财",
      "水金": "父母",
      "水木": "子孙",
      "水水": "兄弟",
      "水火": "妻财",
      "水土": "官鬼",
      "火金": "妻财",
      "火木": "父母",
      "火水": "官鬼",
      "火火": "兄弟",
      "火土": "子孙",
      "土金": "子孙",
      "土木": "官鬼",
      "土水": "妻财",
      "土火": "父母",
      "土土": "兄弟"
    };
    String strKey = '$basicElement$otherElement';
    String strParent = tempData[strKey];
    return strParent;
  }
}
