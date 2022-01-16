class MonitorModel {
  final String ip;
  final String name;
  MonitorModel({required this.name, required this.ip});
  String get getIp {
    return ip;
  }

  String get getName {
    return name;
  }
}
