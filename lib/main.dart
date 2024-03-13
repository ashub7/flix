
import 'package:event_bus/event_bus.dart';
import 'package:flix/core/di/injector.dart';
import 'package:flix/ui/features/app/application.dart';
import 'package:flutter/material.dart';

final eventBus = EventBus();

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const Application());
}




