import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/helpers/api_key_shared_pref.dart';
import 'package:discoveranimals/providers/animal_provider.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:discoveranimals/reusable_widgets/animal_container.dart';
import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:discoveranimals/services/gemini_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _userPrompt = TextEditingController();
  File? image;
  late Future<String> _modelResponse = Future.value('Loading ...');
  late String animalName;

  @override
  Widget build(BuildContext context) {
    CurrentViewProvider currViewProvider =
        Provider.of<CurrentViewProvider>(context, listen: false);
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 0),
            child: SubText(
              subTextContent: 'AI Recommendations:',
              fontSize: headingSize,
              isCentered: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 80),
            child: CarouselSlider(
              items: const [
                AnimalContainer(
                    imagePath: 'assets/images/dog.png', animalName: 'Dog'),
                AnimalContainer(
                    imagePath: 'assets/images/cat.png', animalName: 'Cat'),
                AnimalContainer(
                    imagePath: 'assets/images/bear.png', animalName: 'Bear'),
                AnimalContainer(
                    imagePath: 'assets/images/dolphin.png',
                    animalName: 'Dolphin'),
                AnimalContainer(
                    imagePath: 'assets/images/giraffe.png',
                    animalName: 'Giraffe'),
                AnimalContainer(
                    imagePath: 'assets/images/tiger.png', animalName: 'Tiger'),
              ],
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: false,
                enableInfiniteScroll: true,
                viewportFraction: 0.3,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 40),
            child: SubText(
              subTextContent: 'Enter your Prompt:',
              fontSize: headingSize,
              isCentered: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormFieldWidget(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  key: const ValueKey("animal_prompt"),
                  textController: _userPrompt,
                  hint: 'Type in an animal name ...',
                  maxLength: 100,
                  isHidden: false,
                  isSuffixRequired: false,
                  fontSize: textSize,
                ),
                LgElevatedButton(
                    elevatedButtonContent: 'GENERATE',
                    buttonColor: AppColors.primary1,
                    onpressed: () {
                      if (ApiKeySharedPref.getAPIKey() == '' ||
                          ApiKeySharedPref.getAPIKey() == null) {
                        dialogBuilder(
                            context,
                            'Please enter your Gemini API key to be able to continue',
                            false,
                            'OK', () {
                          currViewProvider.currentView = 'settings';
                        }, () {});
                      } else {
                        final animal = _userPrompt.text;
                        currViewProvider.currentView = 'animal';
                        animalProvider.animalChoice = animal;
                      }
                    },
                    height: 50,
                    width: 250,
                    fontSize: textSize + 4,
                    textColor: AppColors.background,
                    isPoly: false)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 40, top: 40),
            child: SubText(
              subTextContent: 'Or Upload an Image',
              fontSize: headingSize,
              isCentered: false,
            ),
          ),
          image != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          image = null;
                          if (ApiKeySharedPref.getAPIKey() == '' ||
                              ApiKeySharedPref.getAPIKey() == null) {
                            dialogBuilder(
                                context,
                                'Please enter your Gemini API key to be able to continue',
                                false,
                                'OK', () {
                              currViewProvider.currentView = 'settings';
                            }, () {});
                          } else {
                            _handleUploadImageButtonTap()
                                .then((imageFile) async {
                              if (imageFile != null) {
                                final Uint8List? imageBytes =
                                    await readFileAsBytes(imageFile);

                                if (imageBytes != null) {
                                  setState(() {
                                    _modelResponse = GeminiService()
                                        .describeImage(imageBytes);
                                  });
                                } else {
                                  setState(() {
                                    _modelResponse = Future.value(
                                        'No animal found in this image, try again!');
                                  });
                                }
                              }
                            });
                          }
                        },
                        child: Image.file(
                          image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          FutureBuilder<String?>(
                            future: _modelResponse,
                            builder: (context, snapshot) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive())
                                    : _buildResponseWidget(snapshot),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LgElevatedButton(
                                  elevatedButtonContent: 'CONTINUE',
                                  buttonColor: AppColors.primary2,
                                  onpressed: () {
                                    currViewProvider.currentView = 'animal';
                                    animalProvider.animalChoice = animalName;
                                  },
                                  height: 50,
                                  width: 250,
                                  fontSize: textSize + 2,
                                  textColor: AppColors.background,
                                  isPoly: false),
                              const SizedBox(
                                width: 50,
                              ),
                              LgElevatedButton(
                                  elevatedButtonContent: 'REGENERATE',
                                  buttonColor: AppColors.primary1,
                                  onpressed: () async {
                                    final Uint8List? imageBytes =
                                        await readFileAsBytes(image!);

                                    if (imageBytes != null) {
                                      setState(() {
                                        _modelResponse = GeminiService()
                                            .describeImage(imageBytes);
                                      });
                                    } else {
                                      setState(() {
                                        _modelResponse = Future.value(
                                            'No animal found in this image, try again!');
                                      });
                                    }
                                  },
                                  height: 50,
                                  width: 250,
                                  fontSize: textSize + 2,
                                  textColor: AppColors.background,
                                  isPoly: false),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (ApiKeySharedPref.getAPIKey() == '' ||
                              ApiKeySharedPref.getAPIKey() == null) {
                            dialogBuilder(
                                context,
                                'Please enter your Gemini API key to be able to continue',
                                false,
                                'OK', () {
                              currViewProvider.currentView = 'settings';
                            }, () {});
                          } else {
                            _handleUploadImageButtonTap()
                                .then((imageFile) async {
                              if (imageFile != null) {
                                final Uint8List? imageBytes =
                                    await readFileAsBytes(imageFile);

                                if (imageBytes != null) {
                                  setState(() {
                                    _modelResponse = GeminiService()
                                        .describeImage(imageBytes);
                                  });
                                } else {
                                  setState(() {
                                    _modelResponse = Future.value(
                                        'No animal found in this image, try again!');
                                  });
                                }
                              }
                            });
                          }
                        },
                        child: const Icon(
                          Icons.drive_folder_upload,
                          size: 60,
                        ),
                      ),
                      Text(
                        'Upload Image',
                        style: TextStyle(
                            fontFamily: fontType, fontSize: textSize - 2),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Future<Uint8List?> readFileAsBytes(File file) async {
    try {
      return await file.readAsBytes();
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  Future<XFile?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile;
  }

  String? extractAnimalName(String response) {
    final prefix = 'The animal in the image is a ';
    final startIndex = response.indexOf(prefix);

    if (startIndex != -1) {
      // Extract the substring after the prefix
      final animalName = response.substring(startIndex + prefix.length);
      return animalName;
    } else {
      // Return null if prefix is not found
      return null;
    }
  }

  Future<File?> _handleUploadImageButtonTap() async {
    final imageFile = await pickImage(ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
      return File(imageFile.path);
    }
    return null;
  }

  Widget _buildResponseWidget(AsyncSnapshot<String?> snapshot) {
    if (snapshot.hasError) {
      return const Text(
        'Something went wrong Please try again later!',
        style: TextStyle(fontSize: 20),
      );
    }

    if (snapshot.data == null) {
      return const Text('The response will be showed here');
    }

    final extractedAnimalName = extractAnimalName(snapshot.data!);
    if (extractedAnimalName != null) {
      // Save the extracted animal name here
      animalName = extractedAnimalName;
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      height: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          animatedTexts: [
            TypewriterAnimatedText(snapshot.data!,
                textStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: textSize,
                    color: Colors.black),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
