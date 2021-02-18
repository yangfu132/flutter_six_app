class SABStaticHealthModel {
  List _finishedList = [];
  Map<int, double> _healthMap = {};

  void setHealth(double numHealth, int nRow) {
    if (null == numHealth) {
      print('numHealth:$numHealth');
    }
    _healthMap[nRow] = numHealth;
  }

  double getHealth(int nRow) {
    if (null == _healthMap[nRow]) {
      print('nRow:$nRow');
    }
    return _healthMap[nRow];
  }

  void addToFinishArray(int nRow) {
    if (-1 == _finishedList.indexOf(nRow)) {
      _finishedList.add(nRow);
    }
  }

  bool isUnFinish(int nRow) {
    return -1 == _finishedList.indexOf(nRow);
  }
}
