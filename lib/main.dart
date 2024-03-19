
import 'package:flix/core/di/injector.dart';
import 'package:flix/ui/features/app/application.dart';
import 'package:flutter/material.dart';
import  'package:flutter_downloader/flutter_downloader.dart';


main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true
  );
  runApp(const Application());
}




