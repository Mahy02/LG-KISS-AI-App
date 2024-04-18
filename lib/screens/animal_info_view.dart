import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/models/animal_model.dart';
import 'package:discoveranimals/models/kml/KMLModel.dart';
import 'package:discoveranimals/models/kml/look_at_model.dart';
import 'package:discoveranimals/models/kml/orbit_model.dart';
import 'package:discoveranimals/models/kml/placemark_model.dart';
import 'package:discoveranimals/models/kml/point_model.dart';
import 'package:discoveranimals/models/location_model.dart';
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
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  final _userPrompt = TextEditingController();

  _viewPlacemarks(List<PlacemarkModel> placemarks) async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);
    String content = '';
    content += placemarks[0].styleTag;
    for (PlacemarkModel placemark in placemarks) {
      content += placemark.placemarkOnlyTag;
    }
    final kmlPlacemark = KMLModel(
      name: 'Animal-pins',
      content: content,
    );

    try {
      await LgService(sshData)
          .sendKmlPlacemarks(kmlPlacemark.body, 'AnimalPins');
    } catch (e) {
      print(e);
    }
  }

  _buildLocationBallon(
      String animalName, String cityName, String countryName) async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: ' $animalName-query-facts',
      name: ' $animalName-query-facts',
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Discover more about $animalName' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <p>$animalName can be found in $cityName , $countryName</p>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: '$animalName-query-balloon',
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
      id: '$animalName-fun-facts',
      name: '$animalName-fun-facts',
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Discover more about $animalName' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
     <div style="text-align:center;">
      <b><font size="+2"> 'FUN FACTS' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/>
      <p>${funFacts.split('\n\n').join('<br/><br/>')}</p>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: '$animalName-fun-facts-balloon',
      content: placemark.balloonOnlyTag,
    );
    if (sshData.client != null) {
      LookAtModel lookAtObj = LookAtModel(
        longitude: -45.4518936,
        latitude: 0.0000101,
        range: '31231212.86',
        tilt: '0',
        altitude: 50000.1097385,
        heading: '0',
        altitudeMode: 'relativeToSeaFloor',
      );

      try {
        await LgService(sshData).flyTo(lookAtObj);

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
  }

  _buildInitialsBalloon(String animalName) async {
    final sshData = Provider.of<SSHprovider>(context, listen: false);

    final placemark = PlacemarkModel(
      id: '$animalName-initial',
      name: '$animalName-initial',
      balloonContent: '''
    <div style="text-align:center;">
      <b><font size="+3"> 'Discover more about $animalName' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/><br/>
      <div style="text-align:center;">
      <img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/animalsBalloon.png?raw=true" style="display: block; margin: auto; width: 150px; height: 100px;"/><br/><br/>
     </div>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: '$animalName-initial-balloon',
      content: placemark.balloonOnlyTag,
    );

    if (sshData.client != null) {
      LookAtModel lookAtObj = LookAtModel(
        longitude: -45.4518936,
        latitude: 0.0000101,
        range: '31231212.86',
        tilt: '0',
        altitude: 50000.1097385,
        heading: '0',
        altitudeMode: 'relativeToSeaFloor',
      );

      try {
        await LgService(sshData).flyTo(lookAtObj);

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
  }

  _buildAnswersBallon(String animalName, String response, String query) async {
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
      <b><font size="+2"> '$query' <font color="#5D5D5D"></font></font></b>
      </div>
      <br/>
      <p>$response</p>
      <br/>
    ''',
    );
    final kmlBalloon = KMLModel(
      name: '$animalName-balloon',
      content: placemark.balloonOnlyTag,
    );

    if (sshData.client != null) {
      LookAtModel lookAtObj = LookAtModel(
        longitude: -45.4518936,
        latitude: 0.0000101,
        range: '31231212.86',
        tilt: '0',
        altitude: 50000.1097385,
        heading: '0',
        altitudeMode: 'relativeToSeaFloor',
      );

      try {
        await LgService(sshData).flyTo(lookAtObj);

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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FutureBuilder<AnimalInfo>(
                        future: _modelResponse,
                        builder: (context, snapshot) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive())
                                : _buildButtonWidget(snapshot),
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

  Widget _buildButtonWidget(AsyncSnapshot<AnimalInfo?> snapshot) {
    if (snapshot.hasError) {
      return Text(
        'Something went wrong Please try again later!',
        style: TextStyle(fontSize: 20),
      );
    }

    if (snapshot.data == null) {
      return const Text('The response will be showed here');
    }

    final animalInfo = snapshot.data!;
    return LgElevatedButton(
        elevatedButtonContent: 'View Locaions',
        buttonColor: AppColors.primary1,
        onpressed: () async {
          try {
            final sshData = Provider.of<SSHprovider>(context, listen: false);

            if (sshData.client != null) {
              List<PlacemarkModel> placemarks = [];

              for (int i = 0; i < animalInfo.locations.length; i++) {
                LocationModel location = animalInfo.locations[i];
                LookAtModel lookAtObj = LookAtModel(
                  longitude: location.longitude,
                  latitude: location.latitude,
                  range: '10000',
                  tilt: '0',
                  altitude: 50000.1097385,
                  heading: '0',
                  altitudeMode: 'relativeToSeaFloor',
                );
                String icon =
                    'https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/animalPin.png?raw=true';
                PlacemarkModel placemark = PlacemarkModel(
                    id: i.toString(),
                    name: location.city,
                    icon: icon,
                    scale: 200,
                    lookAt: lookAtObj,
                    point: PointModel(
                        lat: location.latitude,
                        lng: location.longitude,
                        altitude: 1000),
                    description:
                        '${animalInfo.animalName} Pin at ${location.city} , ${location.country}');
                placemarks.add(placemark);
              }
              _viewPlacemarks(placemarks);
            }
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
        },
        height: 50,
        width: 250,
        fontSize: textSize + 2,
        textColor: AppColors.background,
        isPoly: false);
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
              _buildLocationBallon(
                  animalInfo.animalName, location.city, location.country);

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
                  null, () {});
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
    try {
      final sshData = Provider.of<SSHprovider>(context, listen: false);

      if (sshData.client != null) {

        _buildFunFactsBallon(animalInfo.animalName, animalInfo.funFacts);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return GestureDetector(
      onTap: () async {
        try {
          final sshData = Provider.of<SSHprovider>(context, listen: false);

          if (sshData.client != null) {
            _buildFunFactsBallon(animalInfo.animalName, animalInfo.funFacts);
          }
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
      },
      child: SizedBox(
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

    try {
      final sshData = Provider.of<SSHprovider>(context, listen: false);

      if (sshData.client != null) {
        _buildAnswersBallon(widget.animal, snapshot.data!, _userPrompt.text);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      //height: MediaQuery.sizeOf(context).height * 0.3,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.primary2,
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
