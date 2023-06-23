import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Provider/favorits_provider.dart';

class WallPaperDetails extends StatelessWidget {
  final String? imgUrl;
  WallPaperDetails({super.key, this.imgUrl});

  Future<String?> _downloadWallPaper(BuildContext context) async {
    final appDocDir = await getApplicationSupportDirectory();
    final saveDir = appDocDir.path;

    final taskId = await FlutterDownloader.enqueue(
      url: imgUrl!,
      savedDir: saveDir,
      showNotification: true,
      openFileFromNotification: true,
    );
    return taskId;
  }

  void _cancelDownload(String taskId) {
    FlutterDownloader.cancel(taskId: taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WallPaper Details"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imgUrl!,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.download)),
                IconButton(
                  onPressed: () {
                    var favoriteProvider =
                        Provider.of<FavoriteProvider>(context, listen: false);
                    favoriteProvider.addToFavorites(imgUrl!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to favorites')),
                    );
                  },
                  icon: Icon(Icons.favorite_border_outlined),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WallPaperDetails extends StatelessWidget {
//   final String? imgUrl;

//   WallPaperDetails({Key? key, this.imgUrl}) : super(key: key);

//   Future<void> _downloadWallpaper(BuildContext context) async {
//     if (Platform.isAndroid) {
//       await _requestStoragePermission();
//     }

//     final appDocDir = await getApplicationDocumentsDirectory();
//     final saveDir = appDocDir.path;

//     final taskId = await FlutterDownloader.enqueue(
//       url: imgUrl!,
//       savedDir: saveDir,
//       showNotification: true,
//       openFileFromNotification: true,
//     );

//     FlutterDownloader.registerCallback((id, status, progress) {
//       if (taskId == id) {
//         if (status == DownloadTaskStatus.complete) {
//           // File downloaded successfully
//           print('Downloaded file path: $saveDir/${imgUrl!.split('/').last}');
//         } else if (status == DownloadTaskStatus.failed) {
//           // File download failed
//           print('File download failed');
//         }
//       }
//     });
//   }

//   Future<void> _requestStoragePermission() async {
//     final status = await Permission.storage.request();
//     if (status.isDenied) {
//       // Storage permission denied
//       print('Storage permission denied');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("WallPaper Details"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(
//             imgUrl!,
//             fit: BoxFit.cover,
//           ),
//           Positioned(
//             bottom: 16.0,
//             right: 16.0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     _downloadWallpaper(context);
//                   },
//                   icon: Icon(Icons.download),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Handle favorites button press
//                   },
//                   icon: Icon(Icons.favorite),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
