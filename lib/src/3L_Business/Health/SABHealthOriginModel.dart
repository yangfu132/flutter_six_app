class SABHealthOriginModel {
  // List _finishedList = [];
  // Map<int, double> _healthMap = {};

  // void setHealth(double numHealth, int nRow) {
  //   if (null == numHealth) {
  //     print('numHealth:$numHealth');
  //   }
  //   _healthMap[nRow] = numHealth;
  // }

  // double getHealth(int nRow) {
  //   if (null == _healthMap[nRow]) {
  //     print('nRow:$nRow');
  //   }
  //   return _healthMap[nRow];
  // }

  // void addToFinishArray(int nRow) {
  //   if (-1 == _finishedList.indexOf(nRow)) {
  //     _finishedList.add(nRow);
  //   }
  // }

  // bool isUnFinish(int nRow) {
  //   return -1 == _finishedList.indexOf(nRow);
  // }

  ///`基础函数`//////////////////////////////////////////////////////

  List arraySeason() {
    List arrayStrong = ["旺", "相", "余气", "休", "囚", "死"];

    return arrayStrong;
  }

  ///`基础health （只计算日月的影响）`///////////////////////////////////////////////

  double dayHealthValue() {
    return 100.0;
  }

  double monthHealthValue() {
    return 100.0;
  }

  ///`输出值与输出权`//////////////////////////////////////////////////////

  double dayOut() {
    double bResult = 1.2;

    return bResult;
  }

  double monthOut() {
    double bResult = 1;

    return bResult;
  }

  ///`输出值与输出权`//////////////////////////////////////////////////////
  double dayOutRight() {
    return 100;
  }

  double monthOutRight() {
    return 100;
  }
}
