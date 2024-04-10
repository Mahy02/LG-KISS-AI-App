import 'dart:async';

import 'package:discoveranimals/providers/connection_provider.dart';
import 'package:discoveranimals/providers/ssh_provider.dart';
import 'package:discoveranimals/screens/home_screen.dart';
import 'package:discoveranimals/services/lg_functionalities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'helpers/lg_connection_shared_pref.dart';
import 'models/ssh_model.dart';

void main() async {
  /// Initialize the app
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize shared preferences for LG connection
  await LgConnectionSharedPref.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Connectionprovider()),
        ChangeNotifierProvider(create: (_) => SSHprovider())
      ],
      child: const LgKISSApp(),
    ),
  );

  Timer.periodic(const Duration(seconds: 30), (timer) async {
    final sshData =
        Provider.of<SSHprovider>(navigatorKey.currentContext!, listen: false);

    Connectionprovider connection = Provider.of<Connectionprovider>(
        navigatorKey.currentContext!,
        listen: false);

    String? result = await sshData.reconnectClient(
        SSHModel(
          username: LgConnectionSharedPref.getUserName() ?? '',
          host: LgConnectionSharedPref.getIP() ?? '',
          passwordOrKey: LgConnectionSharedPref.getPassword() ?? '',
          port: int.parse(LgConnectionSharedPref.getPort() ?? '22'),
        ),
        navigatorKey.currentContext!);
    if (result == 'fail' || result != '') {
      connection.isConnected = false;
    } else {
      connection.isConnected = true;
    }
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LgKISSApp extends StatelessWidget {
  const LgKISSApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sshData = Provider.of<SSHprovider>(context, listen: false);
    LgService(sshData).setLogos();

    return MaterialApp(
      title: 'Discover Animals',
      theme: ThemeData(
          fontFamily: fontType,
         ),
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
  
}

