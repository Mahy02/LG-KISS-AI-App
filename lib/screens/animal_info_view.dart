import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/models/animal_model.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:discoveranimals/services/gemini_services.dart';
import 'package:flutter/material.dart';

class AnimalInfoView extends StatefulWidget {
  final String animal;
  const AnimalInfoView({super.key, required this.animal});

  @override
  State<AnimalInfoView> createState() => _AnimalInfoViewState();
}

class _AnimalInfoViewState extends State<AnimalInfoView> {
  late Future<AnimalInfo> _modelResponse;
  late Future<String?> _model2Response;
  // late Stream<String?> _streamResponse;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _modelResponse = GeminiService().generateAnimalInfo(widget.animal);
  }

  final _userPrompt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 40, top: 40),
            child: SubText(
              subTextContent: 'Get to know more about ${widget.animal} !',
              fontSize: headingSize,
              isCentered: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SubText(
                      subTextContent: 'Fun facts about ${widget.animal} !',
                      fontSize: textSize + 4,
                      isCentered: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: FutureBuilder<AnimalInfo>(
                        future: _modelResponse,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive())
                                : _buildResponseWidget(snapshot),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    SubText(
                      subTextContent: '${widget.animal} Locations',
                      fontSize: textSize + 4,
                      isCentered: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: FutureBuilder<AnimalInfo>(
                        future: _modelResponse,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive())
                                : _buildLocationsWidget(snapshot),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 40, top: 40),
            child: SubText(
              subTextContent: 'Ask anything about ${widget.animal} !',
              fontSize: headingSize,
              isCentered: true,
            ),
          ),
          TextFormFieldWidget(
            width: MediaQuery.sizeOf(context).width * 0.8,
            key: const ValueKey("animal_query"),
            textController: _userPrompt,
            hint: 'What does the animal eat? ...',
            maxLength: 100,
            isHidden: false,
            isSuffixRequired: false,
            fontSize: textSize,
          ),
          LgElevatedButton(
              elevatedButtonContent: 'GENERATE',
              buttonColor: AppColors.primary1,
              onpressed: () {
                setState(() {
                  isPressed = true;
                });
                // _streamResponse = GeminiService().generateAnswerAboutAnimals(
                //     _userPrompt.text, widget.animal);

                _model2Response = GeminiService().generateAnswerAboutAnimals(
                    _userPrompt.text, widget.animal);
              },
              height: 50,
              width: 250,
              fontSize: textSize + 4,
              textColor: AppColors.background,
              isPoly: false),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          if (isPressed)
            // StreamBuilder<String?>(
            //   stream: _streamResponse,
            //   builder: (context, snapshot) {
            //     return AnimatedSwitcher(
            //       duration: const Duration(milliseconds: 300),
            //       child: snapshot.connectionState == ConnectionState.waiting
            //           ? const Center(
            //               child: CircularProgressIndicator.adaptive())
            //           : _buildResponseQueryWidget(snapshot),
            //     );
            //   },
            // ),
            FutureBuilder<String?>(
              future: _model2Response,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _buildResponseQueryWidget(snapshot),
                );
              },
            ),
          if (isPressed)
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
        ],
      ),
    );
  }

  Widget _buildLocationsWidget(AsyncSnapshot<AnimalInfo?> snapshot) {
    if (snapshot.hasError) {
      return const Text(
        'Something went wrong Please try again later!',
        style: TextStyle(fontSize: 20),
      );
    }

    if (snapshot.data == null) {
      return const Text('The response will be showed here');
    }

    final animalInfo = snapshot.data!;
    final locations = animalInfo.locations;
    return CarouselSlider(
      items: locations.map((location) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: fontType,
                  fontSize: textSize,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: 'City:\n ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${location.city}\n\n'),
                  const TextSpan(
                    text: 'Country:\n ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: location.country),
                ],
              ),
            ));
      }).toList(),
      options: CarouselOptions(
          height: MediaQuery.sizeOf(context).height * 0.3,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          autoPlay: false,
          enableInfiniteScroll: false,
          viewportFraction: 0.3,
          scrollDirection: Axis.horizontal),
    );
  }

  Widget _buildResponseWidget(AsyncSnapshot<AnimalInfo?> snapshot) {
    if (snapshot.hasError) {
      return const Text(
        'Something went wrong Please try again later!',
        style: TextStyle(fontSize: 20),
      );
    }

    if (snapshot.data == null) {
      return const Text('The response will be showed here');
    }

    final animalInfo = snapshot.data!;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary1),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: SingleChildScrollView(
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(animalInfo.funFacts,
                  textStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: textSize,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponseQueryWidget(AsyncSnapshot<String?> snapshot) {
    if (snapshot.hasError) {
      return const Text(
        'Something went wrong Please try again later!',
        style: TextStyle(fontSize: 20),
      );
    }

    if (snapshot.data == null) {
      return const Text('The response will be showed here');
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      //height: MediaQuery.sizeOf(context).height * 0.3,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.primary3,
          border: Border.all(color: AppColors.primary1),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: SingleChildScrollView(
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(snapshot.data!,
                  textStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: textSize,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
