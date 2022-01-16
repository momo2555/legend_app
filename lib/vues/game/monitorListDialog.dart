import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_app/models/gameModel.dart';
import 'package:legend_app/models/monitorModel.dart';
import 'package:legend_app/server/deviceDetection.dart';
import 'package:legend_app/vues/game/controller/controllerHome.dart';

class MonitorListDialog extends StatefulWidget {
  final GameModel game;
  const MonitorListDialog({ Key? key, required this.game }) : super(key: key);

  @override
  _MonitorListDialogState createState() => _MonitorListDialogState();
}



class _MonitorListDialogState extends State<MonitorListDialog> {

  late List<ListTile> _monitorsTile = [];
  late Stream<List<MonitorModel>>? _monitorModelsList;

  @override
  void initState() {
    //create the stream;
    DeviceDetection monitorDetection = DeviceDetection();
    monitorDetection.runDeviceClient();
    _monitorModelsList = monitorDetection.monitorListStream;

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context)
    );
  }
  Widget contentBox(context) {
    print('you suck');
    return Container(
     
      
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle
      ),
      child:
            
             StreamBuilder(
              stream: _monitorModelsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<MonitorModel> monitorsList =
                          snapshot.data as List<MonitorModel>;

                      for (MonitorModel monitor in monitorsList) {
                        print(monitor.name);
                        _monitorsTile.add(ListTile(
                          leading: Icon(Icons.monitor_rounded,
                              color: Theme.of(context).primaryColor),
                          title: Text(monitor.getName),
                          subtitle: Text(monitor.getIp),
                          onTap: () {
                            // TODO begin game controller actions
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ControllerHome(monitor: monitor, game: widget.game);
                            }));
                          },
                        ));
                      }

                      return ListView(
                      
                        children: _monitorsTile,
                        );
                      
                    }
                  }

                  return Container();
                },
            ),
  
     
    );
  }
}