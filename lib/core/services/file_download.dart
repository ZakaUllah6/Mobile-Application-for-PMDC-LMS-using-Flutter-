import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

Future downloadFile(String url, {bool video = false}) async {
  var dio = Dio();
  dio.interceptors.add(LogInterceptor());
  try {
    var response = await dio.get(
      url,
      //  onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        // receiveTimeout: 0,
      ),
    );
    // final contentDisposition = response.headers['content-disposition'];
    // final fileName = RegExp('filename[^;=\n]*=([\'\"]?)([^\'\"]*)\\1')
    //     .firstMatch(contentDisposition.toString())

    //     ?.group(2);
    var savePath;
    if (video) {
      savePath = '/storage/emulated/0/Download/.mp4';
    } else {
      final fileName = File(url).path.split('/').last.split('?').first;
      print(fileName); // Output: file.txt
      savePath = '/storage/emulated/0/Download/$fileName';
    }

    var file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    print("downloaded");
    await raf.close();
  } catch (e) {}
}

// downloadFileLocally(Response<dynamic> response) async {
//   Directory? directory = Platform.isAndroid
//       ? await getExternalStorageDirectory()
//       : await getApplicationDocumentsDirectory();
//   final fullPath =
//       '${directory?.path}/NewDirectory'; //create new directory here

//   Directory(fullPath).createSync(recursive: true);

//   List<int> intList = [];

//   if (response.data != null) {
//     intList = response.data.cast<int>().toList();
//   }

//   Uint8List? bytes = Uint8List.fromList(intList);

//   File? file;
//   final path =
//       '${iosDirectory?.path}/NewDirectory/$fileType-${fileNameHere}.pdf';
//   file = File(path);

//   try {
//     await file.writeAsBytes(
//         bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
//   } on FileSystemException catch (err) {
//     // handle error
//   }
// }
