import 'package:flutter/material.dart';

import '../constants.dart';

/// A widget that displays an indicator to show the connection status.
class ConnectionIndicator extends StatelessWidget {
  final bool isConnected;

  /// Constructor for the ConnectionIndicator class.
  /// The `isConnected` parameter specifies whether the device is connected to the network.
  const ConnectionIndicator({super.key, required this.isConnected});

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
              backgroundColor:
                  isConnected ? AppColors.lgColor4 : AppColors.lgColor2,
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
