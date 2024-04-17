import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants.dart';

import '../providers/ssh_provider.dart';

import '../services/lg_functionalities.dart';

class LGTasksView extends StatefulWidget {
  const LGTasksView({super.key});

  @override
  State<LGTasksView> createState() => _LGTasksViewState();
}

class _LGTasksViewState extends State<LGTasksView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SubText(
          subTextContent: 'LG Tasks',
          fontSize: headingSize,
          isCentered: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LgElevatedButton(
                elevatedButtonContent: 'Reboot',
                buttonColor: AppColors.primary2,
                textColor: AppColors.font,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.25,
                imagePath: 'assets/images/reboot2.png',
                imageHeight: MediaQuery.of(context).size.height * 0.1,
                imageWidth: MediaQuery.of(context).size.height * 0.1,
                fontSize: 25,
                isPoly: false,
                onpressed: () {
                  /// retrieving the ssh data from the `ssh provider`
                  final sshData =
                      Provider.of<SSHprovider>(context, listen: false);

                  ///checking the connection status first
                  if (sshData.client != null) {
                    /// calling `reboot` from `LGService`

                    dialogBuilder(context, 'Are you sure you want to Reboot?',
                        false, 'YES', () {
                      LgService(sshData).reboot();
                    }, () {});
                  } else {
                    ///Showing error message

                    dialogBuilder(
                        context,
                        'NOT connected to LG !! \n Please Connect to LG',
                        true,
                        'OK',
                        null,
                        null);
                  }
                }),
            LgElevatedButton(
                elevatedButtonContent: 'Shut Down',
                buttonColor: AppColors.primary2,
                textColor: AppColors.font,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.25,
                imagePath: 'assets/images/shutdown.png',
                imageHeight: MediaQuery.of(context).size.height * 0.1,
                imageWidth: MediaQuery.of(context).size.height * 0.1,
                fontSize: 25,
                isPoly: false,
                onpressed: () async {
                  /// retrieving the ssh data from the `ssh provider`
                  final sshData =
                      Provider.of<SSHprovider>(context, listen: false);

                  ///checking the connection status first
                  if (sshData.client != null) {
                    //warning message first

                    dialogBuilder(
                        context,
                        'Are you sure you want to Shut Down?',
                        false,
                        'YES', () {
                      try {
                        LgService(sshData).shutdown();
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                    }, () {});
                  } else {
                    ///Showing error message

                    dialogBuilder(
                        context,
                        'NOT connected to LG !! \n Please Connect to LG',
                        true,
                        'OK',
                        null,
                        null);
                  }
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LgElevatedButton(
                elevatedButtonContent: 'Relaunch',
                buttonColor: AppColors.primary2,
                textColor: AppColors.font,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.25,
                imagePath: 'assets/images/relaunch.png',
                imageHeight: MediaQuery.of(context).size.height * 0.1,
                imageWidth: MediaQuery.of(context).size.height * 0.1,
                fontSize: 25,
                isPoly: false,
                onpressed: () async {
                  /// retrieving the ssh data from the `ssh provider`
                  final sshData =
                      Provider.of<SSHprovider>(context, listen: false);

                  ///checking the connection status first
                  if (sshData.client != null) {
                    /// calling `reboot` from `LGService`

                    dialogBuilder(context, 'Are you sure you want to Relaunch?',
                        false, 'YES', () {
                      LgService(sshData).relaunch();
                    }, () {});
                  } else {
                    dialogBuilder(
                        context,
                        'NOT connected to LG !! \n Please Connect to LG',
                        true,
                        'OK',
                        null,
                        null);
                  }
                }),
            LgElevatedButton(
                elevatedButtonContent: 'Clear KML',
                buttonColor: AppColors.primary2,
                textColor: AppColors.font,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.25,
                imagePath: 'assets/images/clear.png',
                imageHeight: MediaQuery.of(context).size.height * 0.1,
                imageWidth: MediaQuery.of(context).size.height * 0.1,
                fontSize: 25,
                isPoly: false,
                onpressed: () async {
                  /// retrieving the ssh data from the `ssh provider`
                  final sshData =
                      Provider.of<SSHprovider>(context, listen: false);

                  ///checking the connection status first
                  if (sshData.client != null) {
                    LgService(sshData).clearKml();
                  } else {
                    dialogBuilder(
                        context,
                        'NOT connected to LG !! \n Please Connect to LG',
                        true,
                        'OK',
                        null,
                        null);
                  }
                }),
          ],
        ),
      ],
    );
  }
}
