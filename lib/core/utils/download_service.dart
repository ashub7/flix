import 'dart:io';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../extension/logger_provider.dart';

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  //final downloadManager = DownloadManager();
  late String _localPath;

  factory DownloadService() {
    return _instance;
  }

  DownloadService._internal(){
    _prepareSaveDir();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  /*enqueueDownload(String url) async {
    if (downloadManager.getDownload(url) != null) return;
    final dir = await getExtStorageOrDownloadsDirPath();
    DownloadTask? task = await downloadManager.addDownload(
        url, "$dir/${downloadManager.getFileNameFromUrl(url)}");
    task?.status.addListener(() {
      logger.d("download Status ${task.status.value}");
    });
    task?.progress.addListener(() {
      logger.d("progress Status ${task.progress.value}");
    });
  }*/

  enqueueDownload2(String url) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      savedDir: _localPath,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;

    return externalStorageDirPath;
  }


  @pragma('vm:entry-point')
  static void downloadCallback(
      String id,
      int status,
      int progress,
      ) {
    logger.d("progress for $id $status and $progress");
    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }
}
