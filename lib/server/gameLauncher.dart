import 'dart:io';


/**
 * hhtp test server
 */
class GameLauncher {
  GameLauncher() {

  }

  runServer() async {
    
   HttpServer.bind(InternetAddress.anyIPv4, 2224).then((server) {
     
     server.listen((event) {
       
       event.response.write("wesh la mif");
       print('uri = ' + event.uri.toString());
       event.response.close();
      });
   }
   );
  
  }
}