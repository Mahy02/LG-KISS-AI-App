import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/connection_provider.dart';
import 'conncetion_indicator.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Connectionprovider connection =
        Provider.of<Connectionprovider>(context, listen: false);
    return Positioned(
        top: 30,
        left: 50,
        right: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Discover Animals World Wide!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: fontType,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background)),
            ConnectionIndicator(
              isConnected: connection.isConnected,
            ),
          ],
        ));
  }
}
