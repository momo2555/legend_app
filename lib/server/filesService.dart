import 'dart:io';

import 'package:path_provider/path_provider.dart';

/**
 * provider files path of any app directory for setting up the http server
 */
class FilesService {

  late Directory appDirectory;
  late List<String> directories;
  FilesService() {
    directories =  ["games"];
  }

  /**
   * check if all directories are fine
   */
  Future<bool> checkFileSystem() async  {
    appDirectory = await getApplicationSupportDirectory();
    //checkin if all directories exists if not creating them
    for (var dirName in directories) {
      var dir = Directory("${appDirectory.path}/${dirName}");
      if(!(await  dir.exists())) {
        Directory newDir =await dir.create(recursive: true);

      }
    }

  
    return true;
  }
}