import 'package:discoveranimals/main.dart';
import 'package:discoveranimals/providers/connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

/// A widget that displays an indicator to show the connection status.
class ConnectionIndicator extends StatefulWidget {
  // final bool isConnected;

  /// Constructor for the ConnectionIndicator class.
  /// The `isConnected` parameter specifies whether the device is connected to the network.
  const ConnectionIndicator({
    super.key,
  });
  //required this.isConnected}

  @override
  State<ConnectionIndicator> createState() => _ConnectionIndicatorState();
}

class _ConnectionIndicatorState extends State<ConnectionIndicator> {
  Connectionprovider connection = Provider.of<Connectionprovider>(
      navigatorKey.currentContext!,
      listen: false);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'LG Connection',
              style: TextStyle(fontFamily: fontType, fontSize: textSize),
            ),
            CircleAvatar(
              backgroundColor: connection.isConnected
                  ? AppColors.lgColor4
                  : AppColors.lgColor2,
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
