class GameModel {
  late String nameId;
  late String name;
  late String iconUrl;
  late String bannerUrl;
  late String description;
  late String monitorPage;
  late String controllerPage;
  GameModel() {}
  set setNameid(value) {
    nameId = value;
  }
  set setName(value) {
    name = value;
  }
  set setIconUrl(value) {
    iconUrl = value;
  }
  set setBannerUrl(value) {
    bannerUrl = value;
  }
  set setDescription(value) {
    description = value;
  }
  set setMonitorPage(value) {
    monitorPage = value;
  }
  set setControllerPage(value) {
    controllerPage = value;
  }
  String get getNameId {
    return nameId;
  }
  String get getName {
    return name;
  }
  String get getIconUrl {
    return iconUrl;
  }
  String get getBannerUrl {
    return bannerUrl;
  }
  String get getDescription{
    return description;
  }
   String get getMonitorPage {
    return monitorPage;
  }
  String get getControllerPage {
    return controllerPage;
  }

  Map<String, dynamic> toObject () {
    return {
      "gameId" : nameId,
      "monitor" : monitorPage,
      "controller" : controllerPage,
      "banner": bannerUrl,
      "icon" : iconUrl,
      "name" : name,
    };
  }
  
}