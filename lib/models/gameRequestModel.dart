import 'dart:convert';

class GameRequestModel {
  final String request;
  late Map<String, dynamic> params = Map<String, dynamic>();
  final String from;
  final String to;
  GameRequestModel ({required this.request, required this.from,required this.to});

  addParameter(String param, dynamic value) {
    params[param] = value;
  }
  String toString() {
    final Map<String, dynamic> converted = {
      "header" : {
        "type" : "request",
        "from" : from,
        "to" : to,
      },
      "request" : {
        "exec" : request,
        "params" : params,
      },
    };
    return jsonEncode(converted);
  }
}