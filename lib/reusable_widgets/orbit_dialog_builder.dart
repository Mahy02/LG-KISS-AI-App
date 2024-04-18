import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/providers/ssh_provider.dart';
import 'package:discoveranimals/services/lg_functionalities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrbitDialog extends StatefulWidget {
  final String location;
  const OrbitDialog({super.key, required this.location});

  @override
  State<OrbitDialog> createState() => _OrbitDialogState();
}

class _OrbitDialogState extends State<OrbitDialog> {
  bool _isOrbiting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Orbit around ${widget.location}',
        style: TextStyle(
            fontFamily: fontType,
            fontSize: textSize,
            fontWeight: FontWeight.bold),
      ),
      content: _isOrbiting
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isOrbiting = false;
                        });
                        final sshData =
                            Provider.of<SSHprovider>(context, listen: false);
                        if (sshData.client != null) {
                          try {
                            await LgService(sshData).stopTour();
                          } catch (e) {
                            // ignore: avoid_print
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Stop',
                        style: TextStyle(
                            fontFamily: fontType,
                            fontSize: textSize + 2,
                            color: AppColors.lgColor2),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              'Start orbit?',
              style: TextStyle(fontFamily: fontType, fontSize: textSize),
            ),
      actions: [
        if (!_isOrbiting)
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isOrbiting = true;
              });

              final sshData = Provider.of<SSHprovider>(context, listen: false);
              if (sshData.client != null) {
                try {
                  await LgService(sshData).startTour('Orbit');
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              }
            },
            child: Text(
              'Yes',
              style: TextStyle(
                  fontFamily: fontType,
                  fontSize: textSize + 2,
                  color: AppColors.lgColor4),
            ),
          ),
        if (!_isOrbiting)
          ElevatedButton(
            onPressed: () async {
              final sshData = Provider.of<SSHprovider>(context, listen: false);
              if (sshData.client != null) {
                try {
                  await LgService(sshData).clearKml();
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              }
              Navigator.of(context).pop();
            },
            child: Text('No',
                style: TextStyle(
                    fontFamily: fontType,
                    fontSize: textSize + 2,
                    color: AppColors.lgColor2)),
          ),
      ],
    );
  }
}

