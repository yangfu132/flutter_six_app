///全App唯一的单利
///
class SABSingletonBusiness {
  // 工厂模式
  factory SABSingletonBusiness() => _getInstance();
  static SABSingletonBusiness get instance => _getInstance();
  static SABSingletonBusiness _instance;

  Map<String, dynamic> clearableMap;

  SABSingletonBusiness._internal() {
    // 初始化
  }

  static SABSingletonBusiness _getInstance() {
    if (_instance == null) {
      _instance = new SABSingletonBusiness._internal();
    }
    return _instance;
  }

  ///note:释放所有临时对象
  static clear() {
    SABSingletonBusiness.instance.clearableMap.clear();
  }

  ///note:保存临时对象
  static sharedClass(String key, dynamic value) {
    SABSingletonBusiness.instance.clearableMap[key] = value;
  }
}
