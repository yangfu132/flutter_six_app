import 'package:flutter_six_app/src/1L_Context/SACContext.dart';

import '../../1L_Context/SACContext.dart';

//类注释：此类包含八宫、八卦、六十四卦的信息
class SABEightDiagramsModel {
  Map _myAllEasyTableData;

  String elementOfDiagram(String diagram) {
    Map easyElementMap = {
      "乾": "金",
      "坤": "土",
      "坎": "水",
      "震": "木",
      "艮": "土",
      "离": "火",
      "巽": "木",
      "兑": "金"
    };

    return easyElementMap[diagram];
  }

  String elementOfEasy(String easyName) {
    String strDiagram = easyPlaceByName(easyName);
    String easyElement = elementOfDiagram(strDiagram);
    return easyElement;
  }

  String easyPlaceByName(String easyName) {
    String result = "";

    if (easyName.length >= 2) {
      result = easyName[easyName.length - 2];
    } else
      colog("error!");

    return result;
  }

  static Map earlyPlace() {
    return {
      "乾": "正南",
      "坤": "正北",
      "坎": "正西",
      "离": "正东",
      "巽": "西南",
      "震": "东北",
      "艮": "西北",
      "兑": "东南"
    };
  }

  static Map latePlace() {
    return {
      "乾": "西北",
      "坤": "西南",
      "坎": "正北",
      "离": "正南",
      "巽": "东南",
      "震": "正东",
      "艮": "东北",
      "兑": "正西"
    };
  }

  String firstEasyKeyInDiagram(String palace) {
    Map temp = {
      "乾": "111111",
      "坎": "010010",
      "艮": "100100",
      "震": "001001",
      "巽": "110110",
      "离": "101101",
      "坤": "000000",
      "兑": "011011",
    };

    return temp[palace];
  }

  static String palaceNameForKey(String key) {
    Map temp = {
      "111": "乾",
      "010": "坎",
      "100": "艮",
      "001": "震",
      "110": "巽",
      "101": "离",
      "000": "坤",
      "011": "兑",
    };

    return temp[key];
  }

  Map getEasyDictionaryForKey(String strKey) {
    Map resultDict = {};

    Map tableDictionary = easyData();
    if (tableDictionary.length == 64)
      resultDict = tableDictionary[strKey];
    else
      colog("error!");

    return resultDict;
  }

  Map easyTable() {
    Map easyTable = {
      "乾": [
        "111111",
        "111110",
        "111100",
        "111000",
        "110000",
        "100000",
        "101000",
        "101111"
      ],
      "坎": [
        "010010",
        "010011",
        "010001",
        "010101",
        "011101",
        "001101",
        "000101",
        "000010"
      ],
      "艮": [
        "100100",
        "100101",
        "100111",
        "100011",
        "101011",
        "111011",
        "110011",
        "110100"
      ],
      "震": [
        "001001",
        "001000",
        "001010",
        "001110",
        "000110",
        "010110",
        "011110",
        "011001"
      ],
      "巽": [
        "110110",
        "110111",
        "110101",
        "110001",
        "111001",
        "101001",
        "100001",
        "100110"
      ],
      "离": [
        "101101",
        "101100",
        "101110",
        "101010",
        "100010",
        "110010",
        "111010",
        "111101"
      ],
      "坤": [
        "000000",
        "000001",
        "000011",
        "000111",
        "001111",
        "011111",
        "010111",
        "010000"
      ],
      "兑": [
        "011011",
        "011010",
        "011000",
        "011100",
        "010100",
        "000100",
        "001100",
        "001011"
      ]
    };

    return easyTable;
  }

//游魂卦
  bool isDriftEasyWithKey(String easyKey) {
    bool bResult = false;
    String easyName = easyData()[easyKey]["name"];
    String strDiagrams = easyPlaceByName(easyName);
    List array = easyTable()[strDiagrams];
    bResult = (6 == array.indexOf(easyKey));
    return bResult;
  }

//归魂卦
  bool isReturnEasyWithKey(String easyKey) {
    bool bResult = false;
    String easyName = easyData()[easyKey]["name"];
    String strDiagrams = easyPlaceByName(easyName);
    List array = easyTable()[strDiagrams];
    bResult = (7 == array.indexOf(easyKey));
    return bResult;
  }

  Map easyData() {
    if (null == _myAllEasyTableData) {
      Map dictionary = {};
      _myAllEasyTableData = dictionary;

      {
        List array = ["丶父母戌土", "丶兄弟申金", "丶官鬼午火", "丶父母辰土", "丶妻财寅木", "丶子孙子水"];

        dictionary["111111"] = {
          "name": "乾为天(乾)",
          "data": array,
          "世": 6,
          "应": 3
        };
      }

      {
        List array = ["丶父母戌土", "丶兄弟申金", "丶官鬼午火", "丶兄弟酉金", "丶子孙亥水", "丶丶父母丑土"];

        dictionary["111110"] = {
          "name": " 天风姤(乾)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶父母戌土", "丶兄弟申金", "丶官鬼午火", "丶兄弟申金", "丶丶官鬼午火", "丶丶父母辰土"];

        dictionary["111100"] = {
          "name": "天山遯(乾)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶父母戌土", "丶兄弟申金", "丶官鬼午火", "丶丶妻财卯木", "丶丶官鬼巳火", "丶丶父母未土"];

        dictionary["111000"] = {
          "name": "天地否(乾)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶妻财卯木", "丶官鬼巳火", "丶丶父母未土", "丶丶妻财卯木", "丶丶官鬼巳火", "丶丶父母未土"];

        dictionary["110000"] = {
          "name": "风地观(乾)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = [
          "丶妻财寅木",
          "丶丶子孙子水",
          "丶丶父母戌土",
          "丶丶妻财卯木",
          "丶丶官鬼巳火",
          "丶丶父母未土"
        ];

        dictionary["100000"] = {
          "name": "山地剥(乾)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶官鬼巳火", "丶丶父母未土", "丶兄弟酉金", "丶丶妻财卯木", "丶丶官鬼巳火", "丶丶父母未土"];

        dictionary["101000"] = {
          "name": "火地晋(乾)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶官鬼巳火", "丶丶父母未土", "丶兄弟酉金", "丶父母辰土", "丶妻财寅木", "丶子孙子水"];

        dictionary["101111"] = {
          "name": "火天大有(乾)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶兄弟子水", "丶官鬼戌土", "丶丶父母申金", "丶丶妻财午火", "丶官鬼辰土", "丶丶子孙寅木"];

        dictionary["010010"] = {
          "name": "坎为水(坎)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = ["丶丶兄弟子水", "丶官鬼戌土", "丶丶父母申金", "丶丶官鬼丑土", "丶子孙卯木", "丶妻财巳火"];

        dictionary["010011"] = {
          "name": "水泽节(坎)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶丶兄弟子水", "丶官鬼戌土", "丶丶父母申金", "丶丶官鬼辰土", "丶丶子孙寅木", "丶兄弟子水"];

        dictionary["010001"] = {
          "name": "水雷屯(坎)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶丶兄弟子水", "丶官鬼戌土", "丶丶父母申金", "丶兄弟亥水", "丶丶官鬼丑土", "丶子孙卯木"];

        dictionary["010101"] = {
          "name": "水火既济(坎)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶官鬼未土", "丶父母酉金", "丶兄弟亥水", "丶兄弟亥水", "丶丶官鬼丑土", "丶子孙卯木"];

        dictionary["011101"] = {
          "name": "泽火革(坎)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶丶官鬼戌土", "丶丶父母申金", "丶妻财午火", "丶兄弟亥水", "丶丶官鬼丑土", "丶子孙卯木"];

        dictionary["001101"] = {
          "name": "雷火丰(坎)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶丶父母酉金", "丶丶兄弟亥水", "丶丶官鬼丑土", "丶兄弟亥水", "丶丶官鬼丑土", "丶子孙卯木"];

        dictionary["000101"] = {
          "name": "地火明夷(坎)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = [
          "丶丶父母酉金",
          "丶丶兄弟亥水",
          "丶丶官鬼丑土",
          "丶丶妻财午火",
          "丶官鬼辰土",
          "丶丶子孙寅木"
        ];

        dictionary["000010"] = {
          "name": "地水师(坎)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶官鬼寅木", "丶丶妻财子水", "丶丶兄弟戌土", "丶子孙申金", "丶丶父母午火", "丶丶兄弟辰土"];

        dictionary["100100"] = {
          "name": "艮为山(艮)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = ["丶官鬼寅木", "丶丶妻财子水", "丶丶兄弟戌土", "丶妻财亥水", "丶丶兄弟丑土", "丶官鬼卯木"];

        dictionary["100101"] = {
          "name": "山火贲(艮)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶官鬼寅木", "丶丶妻财子水", "丶丶兄弟戌土", "丶兄弟辰土", "丶官鬼寅木", "丶妻财子水"];

        dictionary["100111"] = {
          "name": "山天大畜(艮)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶官鬼寅木", "丶丶妻财子水", "丶丶兄弟戌土", "丶丶兄弟丑土", "丶官鬼卯木", "丶父母巳火"];

        dictionary["100011"] = {
          "name": "山泽损(艮)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶父母巳火", "丶丶兄弟未土", "丶子孙酉金", "丶丶兄弟丑土", "丶官鬼卯木", "丶父母巳火"];

        dictionary["101011"] = {
          "name": "火泽睽(艮)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶兄弟戌土", "丶子孙申金", "丶父母午火", "丶丶兄弟丑土", "丶官鬼卯木", "丶父母巳火"];

        dictionary["111011"] = {
          "name": "天泽履(艮)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶官鬼卯木", "丶父母巳火", "丶丶兄弟未土", "丶丶兄弟丑土", "丶官鬼卯木", "丶父母巳火"];

        dictionary["110011"] = {
          "name": "风泽中孚(艮)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶官鬼卯木", "丶父母巳火", "丶丶兄弟未土", "丶子孙申金", "丶丶父母午火", "丶丶兄弟辰土"];

        dictionary["110100"] = {
          "name": "风山渐(艮)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶妻财戌土", "丶丶官鬼申金", "丶子孙午火", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["001001"] = {
          "name": "震为木(震)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        //与王虎应版本不同，但与网络上相同是在令人疑问
        List array = [
          "丶丶妻财戌土",
          "丶丶官鬼申金",
          "丶子孙午火",
          "丶丶兄弟卯木",
          "丶丶子孙巳火",
          "丶丶妻财未土"
        ];

        dictionary["001000"] = {
          "name": "雷地豫(震)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶丶妻财戌土", "丶丶官鬼申金", "丶子孙午火", "丶丶子孙午火", "丶妻财辰土", "丶丶兄弟寅木"];

        dictionary["001010"] = {
          "name": "雷水解(震)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶丶妻财戌土", "丶丶官鬼申金", "丶子孙午火", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["001110"] = {
          "name": "雷风恒(震)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶官鬼酉金", "丶丶父母亥水", "丶丶妻财丑土", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["000110"] = {
          "name": "地风升(震)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶丶父母子水", "丶妻财戌土", "丶丶官鬼申金", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["010110"] = {
          "name": "水风井(震)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶丶妻财未土", "丶官鬼酉金", "丶父母亥水", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["011110"] = {
          "name": "泽风大过(震)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶丶妻财未土", "丶官鬼酉金", "丶父母亥水", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["011001"] = {
          "name": "泽雷随(震)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶兄弟卯木", "丶子孙巳火", "丶丶妻财未土", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["110110"] = {
          "name": "巽为木(巽)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = ["丶兄弟卯木", "丶子孙巳火", "丶丶妻财未土", "丶妻财辰土", "丶兄弟寅木", "丶父母子水"];

        dictionary["110111"] = {
          "name": "风天小畜(巽)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶兄弟卯木", "丶子孙巳火", "丶丶妻财未土", "丶父母亥水", "丶丶妻财丑土", "丶兄弟卯木"];

        dictionary["110101"] = {
          "name": "风火家人(巽)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶兄弟卯木", "丶子孙巳火", "丶丶妻财未土", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["110001"] = {
          "name": "风雷益(巽)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶妻财戌土", "丶官鬼申金", "丶子孙午火", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["111001"] = {
          "name": "天雷无妄(巽)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶子孙巳火", "丶丶妻财未土", "丶官鬼酉金", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["101001"] = {
          "name": "火雷噬嗑(巽)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶兄弟寅木", "丶丶父母子水", "丶丶妻财戌土", "丶丶妻财辰土", "丶丶兄弟寅木", "丶父母子水"];

        dictionary["100001"] = {
          "name": "山雷颐(巽)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶兄弟寅木", "丶丶父母子水", "丶丶妻财戌土", "丶官鬼酉金", "丶父母亥水", "丶丶妻财丑土"];

        dictionary["100110"] = {
          "name": "山风蛊(巽)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶兄弟巳火", "丶丶子孙未土", "丶妻财酉金", "丶官鬼亥水", "丶丶子孙丑土", "丶父母卯木"];

        dictionary["101101"] = {
          "name": "离为火(离)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = ["丶兄弟巳火", "丶丶子孙未土", "丶妻财酉金", "丶妻财申金", "丶丶兄弟午火", "丶丶子孙辰土"];

        dictionary["101100"] = {
          "name": "火山旅(离)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶兄弟巳火", "丶丶子孙未土", "丶妻财酉金", "丶妻财酉金", "丶官鬼亥水", "丶丶子孙丑土"];

        dictionary["101110"] = {
          "name": "火风鼎(离)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶兄弟巳火", "丶丶子孙未土", "丶妻财酉金", "丶丶兄弟午火", "丶子孙辰土", "丶丶父母寅木"];

        dictionary["101010"] = {
          "name": "火水未济(离)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶父母寅木", "丶丶官鬼子水", "丶丶子孙戌土", "丶丶兄弟午火", "丶子孙辰土", "丶丶父母寅木"];

        dictionary["100010"] = {
          "name": "山水蒙(离)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶父母卯木", "丶兄弟巳火", "丶丶子孙未土", "丶丶兄弟午火", "丶子孙辰土", "丶丶父母寅木"];

        dictionary["110010"] = {
          "name": "风水涣(离)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶子孙戌土", "丶妻财申金", "丶兄弟午火", "丶丶兄弟午火", "丶子孙辰土", "丶丶父母寅木"];

        dictionary["111010"] = {
          "name": "天水讼(离)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶子孙戌土", "丶妻财申金", "丶兄弟午火", "丶官鬼亥水", "丶丶子孙丑土", "丶父母卯木"];

        dictionary["111101"] = {
          "name": "天火同人(离)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = [
          "丶丶子孙酉金",
          "丶丶妻财亥水",
          "丶丶兄弟丑土",
          "丶丶官鬼卯木",
          "丶丶父母巳火",
          "丶丶兄弟未土"
        ];

        dictionary["000000"] = {
          "name": "坤为土(坤)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = [
          "丶丶子孙酉金",
          "丶丶妻财亥水",
          "丶丶兄弟丑土",
          "丶丶兄弟辰土",
          "丶丶官鬼寅木",
          "丶妻财子水"
        ];

        dictionary["000001"] = {
          "name": "地雷复(坤)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶丶子孙酉金", "丶丶妻财亥水", "丶丶兄弟丑土", "丶丶兄弟丑土", "丶官鬼卯木", "丶父母巳火"];

        dictionary["000011"] = {
          "name": "地泽临(坤)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶丶子孙酉金", "丶丶妻财亥水", "丶丶兄弟丑土", "丶兄弟辰土", "丶官鬼寅木", "丶妻财子水"];

        dictionary["000111"] = {
          "name": "地天泰(坤)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶兄弟戌土", "丶丶子孙申金", "丶父母午火", "丶兄弟辰土", "丶官鬼寅木", "丶妻财子水"];

        dictionary["001111"] = {
          "name": "雷天大壮(坤)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶丶兄弟未土", "丶子孙酉金", "丶妻财亥水", "丶兄弟辰土", "丶官鬼寅木", "丶妻财子水"];

        dictionary["011111"] = {
          "name": "泽天夬(坤)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶丶妻财子水", "丶兄弟戌土", "丶丶子孙申金", "丶兄弟辰土", "丶官鬼寅木", "丶妻财子水"];

        dictionary["010111"] = {
          "name": "水天需(坤)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = [
          "丶丶妻财子水",
          "丶兄弟戌土",
          "丶丶子孙申金",
          "丶丶官鬼卯木",
          "丶丶父母巳火",
          "丶丶兄弟未土"
        ];

        dictionary["010000"] = {
          "name": "水地比(坤)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶父母未土", "丶兄弟酉金", "丶子孙亥水", "丶丶父母丑土", "丶妻财卯木", "丶官鬼巳火"];

        dictionary["011011"] = {
          "name": "兑为金(兑)",
          "data": array,
          "世": (6),
          "应": (3)
        };
      }

      {
        List array = ["丶丶父母未土", "丶兄弟酉金", "丶子孙亥水", "丶丶官鬼午火", "丶子孙辰土", "丶丶妻财寅木"];

        dictionary["011010"] = {
          "name": "泽水困(兑)",
          "data": array,
          "世": (1),
          "应": (4)
        };
      }

      {
        List array = ["丶丶父母未土", "丶兄弟酉金", "丶子孙亥水", "丶丶妻财卯木", "丶丶官鬼巳火", "丶丶父母未土"];

        dictionary["011000"] = {
          "name": "泽地萃(兑)",
          "data": array,
          "世": (2),
          "应": (5)
        };
      }

      {
        List array = ["丶丶父母未土", "丶兄弟酉金", "丶子孙亥水", "丶兄弟申金", "丶丶官鬼午火", "丶丶父母辰土"];

        dictionary["011100"] = {
          "name": "泽山咸(兑)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }

      {
        List array = ["丶丶子孙子水", "丶父母戌土", "丶丶兄弟申金", "丶兄弟申金", "丶丶官鬼午火", "丶丶父母辰土"];

        dictionary["010100"] = {
          "name": "水山蹇(兑)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = [
          "丶丶兄弟酉金",
          "丶丶子孙亥水",
          "丶丶父母丑土",
          "丶兄弟申金",
          "丶丶官鬼午火",
          "丶丶父母辰土"
        ];

        dictionary["000100"] = {
          "name": "地山谦(兑)",
          "data": array,
          "世": (5),
          "应": (2)
        };
      }

      {
        List array = ["丶丶父母戌土", "丶丶兄弟申金", "丶官鬼午火", "丶兄弟申金", "丶丶官鬼午火", "丶丶父母辰土"];

        dictionary["001100"] = {
          "name": "雷山小过(兑)",
          "data": array,
          "世": (4),
          "应": (1)
        };
      }

      {
        List array = ["丶丶父母戌土", "丶丶兄弟申金", "丶官鬼午火", "丶丶父母丑土", "丶妻财卯木", "丶官鬼巳火"];

        dictionary["001011"] = {
          "name": "雷泽归妹(兑)",
          "data": array,
          "世": (3),
          "应": (6)
        };
      }
    }
    //else cont.

    return _myAllEasyTableData;
  }
}
