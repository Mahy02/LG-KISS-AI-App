import 'package:discoveranimals/reusable_widgets/conncetion_indicator.dart';
import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../constants.dart';
import '../helpers/lg_connection_shared_pref.dart';
import '../providers/connection_provider.dart';
import '../providers/ssh_provider.dart';

import '../services/lg_functionalities.dart';

class ConnectionView extends StatefulWidget {
  const ConnectionView({super.key});

  @override
  State<ConnectionView> createState() => _ConnectionViewState();
}

class _ConnectionViewState extends State<ConnectionView> {
  /// `form key` for our configuration form
  final _formKey = GlobalKey<FormState>();

  /// `is loading` to Track the loading state
  bool _isLoading = false;

  final TextEditingController _ipController =
      TextEditingController(text: LgConnectionSharedPref.getIP());
  final TextEditingController _portController =
      TextEditingController(text: LgConnectionSharedPref.getPort());
  final TextEditingController _userNameController =
      TextEditingController(text: LgConnectionSharedPref.getUserName());
  final TextEditingController _passwordController =
      TextEditingController(text: LgConnectionSharedPref.getPassword());
  final TextEditingController _screenAmountController = TextEditingController(
      text: LgConnectionSharedPref.getScreenAmount().toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Connectionprovider>(
        builder: (BuildContext context, model, Widget? child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  const SubText(
                    subTextContent: 'LG Configuration Settings',
                    fontSize: headingSize,
                    isCentered: false,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormFieldWidget(
                              fontSize: textSize,
                              label: 'LG User Name',
                              key: const ValueKey("username"),
                              textController: _userNameController,
                              isSuffixRequired: true,
                              isHidden: false,
                              maxLength: 50,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormFieldWidget(
                              fontSize: textSize,
                              label: 'LG Password',
                              key: const ValueKey("lgpass"),
                              textController: _passwordController,
                              isSuffixRequired: true,
                              isHidden: false,
                              maxLength: 50,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormFieldWidget(
                              fontSize: textSize,
                              label: 'LG Master IP Address',
                              key: const ValueKey("ip"),
                              textController: _ipController,
                              isSuffixRequired: true,
                              isHidden: false,
                              maxLength: 50,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormFieldWidget(
                              fontSize: textSize,
                              label: 'LG Port Number',
                              key: const ValueKey("port"),
                              textController: _portController,
                              isSuffixRequired: true,
                              isHidden: false,
                              maxLength: 50,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormFieldWidget(
                              fontSize: textSize,
                              label: 'Number of LG screens',
                              key: const ValueKey("lgscreens"),
                              textController: _screenAmountController,
                              isSuffixRequired: true,
                              isHidden: false,
                              maxLength: 50,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                            ),
                          ),
                        ],
                      )),
                  LgElevatedButton(
                      elevatedButtonContent: 'CONNECT TO LG',
                      buttonColor: AppColors.primary1,
                      onpressed: () async {
                        /// checking first if form is valid
                        if (_formKey.currentState!.validate()) {
                          //saving date in shared pref
                          await LgConnectionSharedPref.setUserName(
                              _userNameController.text);
                          await LgConnectionSharedPref.setIP(
                              _ipController.text);
                          await LgConnectionSharedPref.setPassword(
                              _passwordController.text);
                          await LgConnectionSharedPref.setPort(
                              _portController.text);
                          await LgConnectionSharedPref.setScreenAmount(
                              int.parse(_screenAmountController.text));
                        }

                        final sshData =
                            Provider.of<SSHprovider>(context, listen: false);

                        ///start the loading process by setting `isloading` to true
                        setState(() {
                          _isLoading = true;
                        });

                        /// Call the init function to set up the SSH client with the connection data
                        String? result = await sshData.init(context);

                        Connectionprovider connection =
                            Provider.of<Connectionprovider>(context,
                                listen: false);

                        ///checking on the connection status:
                        if (result == '') {
                          connection.isConnected = true;

                          ///If connected, the logos should appear by calling `setLogos` from the `LGService` calss
                          LgService(sshData).setLogos();
                        } else {
                          connection.isConnected = false;

                          // ignore: use_build_context_synchronously
                          dialogBuilder(context, result!, true, 'OK', null, null);
                        }

                        ///stop the loading process by setting `isloading` to false
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      height: 50,
                      width: 300,
                      fontSize: textSize + 2,
                      textColor: AppColors.background,
                      isPoly: false),
                ],
              ),
              if (_isLoading)

                /// Show the loading indicator if `_isLoading` is true
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const CircularProgressIndicator(
                    color: AppColors.background,
                    backgroundColor: AppColors.lgColor3,
                    semanticsLabel: 'Loading',
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
