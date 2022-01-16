import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:legend_app/models/monitorModel.dart';
import 'package:udp/udp.dart';

class DeviceDetection {
  //monitor detection class
  List<MonitorModel> monitorsList = [];
  StreamController<List<MonitorModel>> monitorListStreamController =
      StreamController<List<MonitorModel>>();
  DeviceDetection() {
    
  }
  void runDeviceClient() async {
    var result = '';

    UDP? receiver, sender;

    Future.wait([
      UDP.bind(Endpoint.any(port: Port(2222))).then((udp) {
        sender = udp;
        print('send udp ');
        return udp.send(
          'legend_get_monitor'.codeUnits,
          Endpoint.broadcast(port: Port(2222)),
        );
      }),
      UDP.bind(Endpoint.any(port: Port(2223))).then((udp) {
        receiver = udp;
        return udp.asStream(timeout: Duration(seconds: 5)).listen((dgram) {
          //getting the result (result = the result of the udp request)
          result = String.fromCharCodes(dgram!.data);
          Map<String, dynamic> monitorMap = jsonDecode(result);

          if (monitorMap.containsKey("server")) {
            if (monitorMap['server']) {
              //add in the list a new monitor
              addMonitor(
                  MonitorModel(name: monitorMap["name"], ip: monitorMap["ip"]));
              //adding a new state in the stream
              monitorListStreamController.sink.add(monitorsList);
              //print(result);
            }
          } else {
            //there is an a error in the transmission => do notthing
          }
        });
      }),
    ]);


    // receiving\listening

    // close the UDP instances and their sockets.
    //sender.close();
    //receiver?.close();
    //print("connection closed");
  }

  Stream<List<MonitorModel>> get monitorListStream {
    return monitorListStreamController.stream;
  }

  void addMonitor(MonitorModel monitor) {
    //TO DO check if the monitor all ready exist
    monitorsList.add(monitor);
  }


   void runDeviceServer() {
    
    InternetAddress senderAddress = InternetAddress.anyIPv4;
    Future.wait([RawDatagramSocket.bind(InternetAddress.anyIPv4, 2222)]).then((values) {
    RawDatagramSocket udpSocket = values[0];
    udpSocket.listen((RawSocketEvent e) async {
      print(e);
     
      switch(e) {
        case RawSocketEvent.read :
          Datagram? dg = udpSocket.receive();
          print('coucou');
          if(dg != null) {
            print(Utf8Codec().decode(dg.data));
            print(dg.address);
            senderAddress = dg.address;
            udpSocket.writeEventsEnabled = true;
          }
          
          
          break;
        case RawSocketEvent.write : 
          final info = NetworkInfo();
          var ip = await info.getWifiIP();
          Map<String, dynamic> objectToSend = {
            "server": true,
            "name": "Screen phone A",
            "ip": ip
          };
          String dataToSend = jsonEncode(objectToSend);
          print(senderAddress);
          print(dataToSend);
          udpSocket.send(Utf8Codec().encode(dataToSend), senderAddress, 2223);
          break;
        case RawSocketEvent.closed : 
          print('Client disconnected.');
      }
    });
  });
  }
}
