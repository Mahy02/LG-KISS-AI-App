import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/models/animal_model.dart';
import 'package:discoveranimals/models/kml/KMLModel.dart';
import 'package:discoveranimals/models/kml/look_at_model.dart';
import 'package:discoveranimals/models/kml/orbit_model.dart';
import 'package:discoveranimals/models/kml/placemark_model.dart';
import 'package:discoveranimals/providers/ssh_provider.dart';
import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/orbit_dialog_builder.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:discoveranimals/services/gemini_services.dart';
import 'package:discoveranimals/services/lg_functionalities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _initializeState();
  }

  void _initializeState() async {
    try {
      final sshData = Provider.of<SSHprovider>(context, listen: false);

      if (sshData.client != null) {
        _buildInitialsBalloon(widget.animal);
      } else {
        dialogBuilder(context, 'NOT connected to LG !! \n Please Connect to LG',
            true, 'OK', null);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  final _userPrompt = TextEditingController();

  _buildLocationBallon() async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: '1',
      name: 'Discover more about',
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Cairo, Egypt' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <div style="text-align:center;">
      <img src="https://github.com/Mahy02/HAPIS-Refurbishment--Humanitarian-Aid-Panoramic-Interactive-System-/blob/week4/hapis/assets/images/cityBallon.png?raw=true" style="display: block; margin: auto; width: 150px; height: 100px;"/><br/><br/>
     </div>
      <b>MAHINOUR ELSARKY</b>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: 'City-balloon',
      content: placemark.balloonOnlyTag,
    );

    try {
      /// sending kml to slave where we send to `balloon screen` and send the `kml balloon ` body
      await LgService(sshData).sendKMLToSlave(
        LgService(sshData).balloonScreen,
        kmlBalloon.body,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _buildFunFactsBallon(String animalName, String funFacts) async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: '1',
      name: animalName,
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Discover more about $animalName' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <div style="text-align:center;">
      <img src="https://github.com/Mahy02/HAPIS-Refurbishment--Humanitarian-Aid-Panoramic-Interactive-System-/blob/week4/hapis/assets/images/cityBallon.png?raw=true" style="display: block; margin: auto; width: 150px; height: 100px;"/><br/><br/>
     </div>
     <div style="text-align:center;">
      <b><font size="+1"> 'FUN FACTS' <font color="#5D5D5D"></font></font></b>
      </div>
      <b>$funFacts</b>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: 'City-balloon',
      content: placemark.balloonOnlyTag,
    );

    try {
      /// sending kml to slave where we send to `balloon screen` and send the `kml balloon ` body
      await LgService(sshData).sendKMLToSlave(
        LgService(sshData).balloonScreen,
        kmlBalloon.body,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _buildInitialsBalloon(String animalName) async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: '1',
      name: animalName,
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Discover more about $animalName' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <div style="text-align:center;">
      <img src="https://lafeber.com/pet-birds/bird-people-share-what-do-you-wish-you-knew-before-getting-a-parrot/" style="display: block; margin: auto; width: 150px; height: 100px;"/><br/><br/>
     </div>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: 'City-balloon',
      content: placemark.balloonOnlyTag,
    );

    try {
      /// sending kml to slave where we send to `balloon screen` and send the `kml balloon ` body
      await LgService(sshData).sendKMLToSlave(
        LgService(sshData).balloonScreen,
        kmlBalloon.body,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  _buildAnswersBallon() async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: '1',
      name: 'Cairo, Egypt',
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Cairo, Egypt' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <div style="text-align:center;">
      <img src="https://github.com/Mahy02/HAPIS-Refurbishment--Humanitarian-Aid-Panoramic-Interactive-System-/blob/week4/hapis/assets/images/cityBallon.png?raw=true" style="display: block; margin: auto; width: 150px; height: 100px;"/><br/><br/>
     </div>
      <div style="text-align:center;">
      <b><font size="+3"> 'FUN FACTS' <font color="#5D5D5D"></font></font></b>

    ''',
    );
    final kmlBalloon = KMLModel(
      name: 'City-balloon',
      content: placemark.balloonOnlyTag,
    );

    try {
      /// sending kml to slave where we send to `balloon screen` and send the `kml balloon ` body
      await LgService(sshData).sendKMLToSlave(
        LgService(sshData).balloonScreen,
        kmlBalloon.body,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

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
      return Text(
        'Something went wrong Please try again later! ${snapshot.error}',
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
        return GestureDetector(
          onTap: () async {
            //To Do: show dialogue orbit

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return OrbitDialog(location: location.city);
              },
            );

            final sshData = Provider.of<SSHprovider>(context, listen: false);
            final double longitude = location.longitude;
            final double latitude = location.latitude;

            ///checking the connection status first
            if (sshData.client != null) {
              //await LgService(sshData).clearKml();

              LookAtModel lookAtObj = LookAtModel(
                longitude: longitude,
                latitude: latitude,
                range: '10000',
                tilt: '0',
                altitude: 50000.1097385,
                heading: '0',
                altitudeMode: 'relativeToSeaFloor',
              );
              LookAtModel lookAtObjOrbit = LookAtModel(
                longitude: longitude,
                latitude: latitude,
                range: '8000',
                tilt: '45',
                altitude: 10000,
                heading: '0',
                altitudeMode: 'relativeToSeaFloor',
              );
              final orbit =
                  OrbitModel.buildOrbit(OrbitModel.tag(lookAtObjOrbit));
              try {
                await LgService(sshData).flyTo(lookAtObj);
                await Future.delayed(const Duration(seconds: 5));

                await LgService(sshData).sendTour(orbit, 'Orbit');
              } catch (e) {
                // ignore: avoid_print
                print(e);
              }
            } else {
              dialogBuilder(
                  context,
                  'NOT connected to LG !! \n Please Connect to LG',
                  true,
                  'OK',
                  null);
            }
          },
          child: Container(
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
              )),
        );
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
