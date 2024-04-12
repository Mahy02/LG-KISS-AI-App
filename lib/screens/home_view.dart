import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/reusable_widgets/animal_container.dart';
import 'package:discoveranimals/reusable_widgets/sub_text.dart';
import 'package:discoveranimals/reusable_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formKey = GlobalKey<FormState>();
  final _userPrompt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 0),
            child: SubText(
                subTextContent: 'AI Recommendations:', fontSize: headingSize),
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
                subTextContent: 'Enter your Prompt or Upload image:',
                fontSize: headingSize),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
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
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.drive_folder_upload,
                        size: 60,
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
          ),
        ],
      ),
    );
  }
}
