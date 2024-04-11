import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/reusable_widgets/animal_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../reusable_widgets/main_layout.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: [
            CarouselSlider(
              items: [
                AnimalContainer(
                    imagePath: 'assets/images/dog.png', animalName: 'Dog'),
                AnimalContainer(
                    imagePath: 'assets/images/cat.png', animalName: 'Cat')
              ],
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: false,
                enableInfiniteScroll: true,
                viewportFraction: 0.3,
              ),
            ),
          ]),
        )
      ],
    );
  }
}
