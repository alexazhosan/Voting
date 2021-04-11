import 'dart:ui';

import 'package:Voting/src/helper/buffer.dart';
import 'package:Voting/src/routing/navigation_service.dart';
import 'package:Voting/src/routing/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    getIt.registerSingleton<NavigationService>(NavigationService());
    Buffer();
    runApp(Center(child: ServiceVending()));
  });
}

class ServiceVending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Buffer.height = MediaQueryData.fromWindow(window).size.height;
    Buffer.width = MediaQueryData.fromWindow(window).size.width;
    return MaterialApp(
        navigatorKey: getIt<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: "register",
        onGenerateRoute: (settings) {
          return checkPageName(settings.name);
        });
  }
}
