import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/helpers/api_key_shared_pref.dart';
import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _apiKey = TextEditingController();
  bool _apiKeyEntered = false;
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    ApiKeySharedPref.init().then((_) async {
      final apiKey = ApiKeySharedPref.getAPIKey();
      if (apiKey != null) {
        _apiKey.text = apiKey;
        setState(() {
          _apiKeyEntered = true;
          _isEnabled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SubText(
              subTextContent: 'Settings',
              fontSize: headingSize,
              isCentered: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: SubText(
              subTextContent: 'API Keys',
              fontSize: textSize + 4,
              isCentered: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width * 1,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, right: 20),
                          child: _isEnabled
                              ? TextFormFieldWidget(
                                  fontSize: textSize,
                                  hint: 'Your Gemini API key',
                                  key: const ValueKey("port"),
                                  textController: _apiKey,
                                  isSuffixRequired: true,
                                  isHidden: false,
                                  maxLength: 50,
                                  onChanged: (value) {
                                    setState(() {
                                      _apiKeyEntered = value.isNotEmpty;
                                    });
                                  },
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                )
                              : TextFormFieldWidget(
                                  fontSize: textSize,
                                  hint: 'Your Gemini API key',
                                  key: const ValueKey("port"),
                                  textController: _apiKey,
                                  isSuffixRequired: true,
                                  isHidden: false,
                                  maxLength: 50,
                                  enabled: false,
                                  fillColor: Color.fromARGB(255, 223, 223, 223),
                                  onChanged: (value) {
                                    setState(() {
                                      _apiKeyEntered = value.isNotEmpty;
                                    });
                                  },
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEnabled = true;
                              });
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 50,
                              color: AppColors.font,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              dialogBuilder(
                                  context,
                                  'Are you sure you want to delete this API key from current session? \n Note: Deleting this API keys means it will not be saved in the app. It will be deleted forever.',
                                  false,
                                  'YES', () {
                                setState(() {
                                  _apiKey.clear();
                                  _apiKeyEntered = false;
                                  _isEnabled = true;
                                });
                                ApiKeySharedPref.removeAPIKey();
                              }, () {});
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 50,
                              color: AppColors.lgColor2,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: LgElevatedButton(
                          elevatedButtonContent: 'SAVE',
                          buttonColor: AppColors.primary1,
                          onpressed: () {
                            if (_apiKeyEntered) {
                              dialogBuilder(
                                  context,
                                  'Are you sure you want to save this API key in the app? \n',
                                  false,
                                  'YES', () {
                                ApiKeySharedPref.setAPIKey(_apiKey.text);
                                setState(() {
                                  _isEnabled = false;
                                });
                              }, () {
                                setState(() {
                                  _apiKey.clear();
                                  _apiKeyEntered = false;
                                });
                              });
                            } else {
                              dialogBuilder(
                                  context,
                                  'Field cannot be empty!\nPlease enter your API key.',
                                  true,
                                  'OK',
                                  () {},
                                  () {});
                            }
                            // Update text field to be non-editable...
                          },
                          height: 50,
                          width: 250,
                          fontSize: textSize + 2,
                          textColor: AppColors.background,
                          isPoly: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 20.0, top: 50),
          //   child: SubText(
          //     subTextContent: 'Theme Settings',
          //     fontSize: textSize + 4,
          //     isCentered: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}
