class SABEasyDetailModel {
  String stringDetailName = 'name';

  List _detailList;

  List detailList() {
    if (null == _detailList) {
      _detailList = [
        [
          '事情',
          '六神',
          '六爻冲合',
          '补充月',
          '补充日',
          '本：补充',
          '世应',
          '进化',
          '变：补充',
          '变月',
          '变日',
        ],
      ];
      for (int intRow = 0; intRow < 6; intRow++) {
        List<String> listValue = [
          '事情',
          '六神',
          '六爻冲合',
          '补充月',
          '补充日',
          '本：补充',
          '世应',
          '进化',
          '变：补充',
          '变月',
          '变日',
        ];
        _detailList.add(listValue);
      }
    }
    return _detailList;
  }
}
