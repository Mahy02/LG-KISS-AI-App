import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _apiKey = TextEditingController();
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
                height: MediaQuery.sizeOf(context).height * 0.2,
                width: MediaQuery.sizeOf(context).width * 1,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: TextFormFieldWidget(
                        fontSize: textSize,
                        hint: 'Your Gemini API key',
                        key: const ValueKey("port"),
                        textController: _apiKey,
                        isSuffixRequired: true,
                        isHidden: false,
                        maxLength: 50,
                        width: MediaQuery.sizeOf(context).width * 0.75,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Icon(
                        Icons.delete,
                        size: 50,
                        color: AppColors.lgColor2,
                      ),
                    )
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
