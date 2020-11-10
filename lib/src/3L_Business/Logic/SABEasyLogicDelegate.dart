import '../../1L_Context/SACGlobal.dart';

abstract class SABEasyLogicDelegate {
  double symbolHealthAtRow(int nRow, EasyTypeEnum easyType);

  double healthCriticalValue();

  List rowArrayAtOutRightLevel(OutRightEnum level);
}
