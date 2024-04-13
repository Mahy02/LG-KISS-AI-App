import 'package:carousel_slider/carousel_slider.dart';
import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/providers/animal_provider.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:discoveranimals/reusable_widgets/animal_container.dart';
import 'package:discoveranimals/reusable_widgets/lg_elevated_button.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final _formKey = GlobalKey<FormState>();
  final _userPrompt = TextEditingController();

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
                subTextContent: 'AI Recommendations:', fontSize: headingSize, isCentered: false,),
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
                subTextContent: 'Enter your Prompt:', fontSize: headingSize, isCentered: false,),
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
                      print(_userPrompt.text);
                      final animal = _userPrompt.text;
                      currViewProvider.currentView = 'animal';
                      animalProvider.animalChoice = animal;
                      //viewProvider = AnimalInfoView(animal: animal);
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
                subTextContent: 'Or Upload an Image', fontSize: headingSize, isCentered: false,),
          ),
          Center(
            child: Column(
              children: [
                const Icon(
                  Icons.drive_folder_upload,
                  size: 60,
                ),
                Text(
                  'Upload Image',
                  style:
                      TextStyle(fontFamily: fontType, fontSize: textSize - 2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
