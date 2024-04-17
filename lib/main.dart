import 'dart:async';

import 'package:discoveranimals/helpers/api_key_shared_pref.dart';
import 'package:discoveranimals/helpers/colors_shared_pref.dart';
import 'package:discoveranimals/providers/animal_provider.dart';
import 'package:discoveranimals/providers/connection_provider.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:discoveranimals/providers/ssh_provider.dart';
import 'package:discoveranimals/reusable_widgets/main_layout.dart';
import 'package:discoveranimals/services/lg_functionalities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'helpers/lg_connection_shared_pref.dart';
import 'models/ssh_model.dart';

void main() async {
  /// Initialize the app
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize shared preferences for LG connection
  await LgConnectionSharedPref.init();
  await ApiKeySharedPref.init();
  await ColorsSharedPref.init();

  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Connectionprovider()),
        ChangeNotifierProvider(create: (_) => SSHprovider()),
        ChangeNotifierProvider(create: (_) => CurrentViewProvider()),
        ChangeNotifierProvider(create: (_) => AnimalProvider()),
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
      home: const MainLayout(),
      navigatorKey: navigatorKey,
    );
  }
}
