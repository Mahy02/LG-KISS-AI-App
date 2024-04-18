import 'dart:typed_data';

import 'package:discoveranimals/helpers/api_key_shared_pref.dart';
import 'package:discoveranimals/models/animal_model.dart';
import 'package:discoveranimals/models/location_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

class GeminiService {
  // final model = GenerativeModel(
  //     model: 'gemini-pro', apiKey: dotenv.env['GEMINI_API_KEY']!);
  // final visionModel = GenerativeModel(
  //     model: 'gemini-pro-vision', apiKey: dotenv.env['GEMINI_API_KEY']!);

  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: ApiKeySharedPref.getAPIKey()!);
  final visionModel = GenerativeModel(
      model: 'gemini-pro-vision', apiKey: ApiKeySharedPref.getAPIKey()!);

  Future<AnimalInfo> generateAnimalInfo(String inputPrompt) async {
    String prompt = '''
** Imagine you're an Animal Assistant that give fun facts about animals and reply with the same exact format.** 
** Generate a list of cities all over the world where $inputPrompt exists and Fun facts about this $inputPrompt.**

** structure: **
  -**Animal Name:** Specify the name of the animal from the $inputPrompt.
  -**Fun Facts:** Provide engaging and interesting facts about the animal in bullet points format.
  - **List of locations:** Present the list of locations that the animal exists including the city, country, and coordinates of the location. Include a minimum of 10 locations.
  - **Content:** For each location include:
    - **Country:**Indicate the country where the animal exists
    - **City:** Indicate the city where the animal exists.
    - **Coordinates:** Provide the latitude and longitude coordinates in decimal number using XML structure. Do not include anything else except the XML code in this point.

  - **Style:** Maintain an engaging and evocative tone, igniting the user's curiosity and excitement about the animals. Stick to the structure shown in the Examples below.

- **Example:**

Animal Name: Dog

Fun Facts:
- Dogs are the first animals to be domesticated by humans, with some estimates suggesting a partnership that began over 15,000 years ago!
- There are over 200 recognized dog breeds, each with unique characteristics and talents.
- A dog's sense of smell is incredible, millions of times more powerful than a human's! They can even sniff out diseases like cancer.
- Some dog breeds can live up to 20 years old!
- Tails wagging doesn't always mean happiness - a slow wag with a tense body might indicate anxiety.

List of Locations:
Location 1:
Country: Austria
City: Vienna
Coordinates:
            <coordinates>
                <latitude>48.208174</latitude>
                <longitude>16.372088</longitude>
            </coordinates>

Location 2:
Country: Brazil
City: Rio de Janeiro
Coordinates:
            <coordinates>
                <latitude>-22.908579</latitude>
                <longitude>-43.196427</longitude>
            </coordinates>

Location 3:
Country: Canada
City: Toronto
Coordinates:
            <coordinates>
                <latitude>43.653426</latitude>
                <longitude>-79.383184</longitude>
            </coordinates>

Location 4:
Country: Egypt
City: Cairo
Coordinates:
            <coordinates>
                <latitude>30.044400</latitude>
                <longitude>31.235700</longitude>
            </coordinates>

''';
    final content = Content.text(prompt);
    final response = await model.generateContent([content]);

    AnimalInfo animalInfo = parseAnimalInfo(response.text!, inputPrompt);
    return animalInfo;

    //return response.text!;
  }

  Future<String?> generateAnswerAboutAnimals(
      String inputPrompt, String animal) async {
    String prompt = inputPrompt;
    final content = Content.text(prompt);
    final response = await model.generateContent([content]);

    return response.text;
  }
  // Stream<String?> generateAnswerAboutAnimals(
  //     String inputPrompt, String animal) {
  //   String prompt = inputPrompt;
  //   final content = Content.text(prompt);
  //   return model.generateContentStream([content]).map((event) => event.text);
  // }

  Future<String> describeImage(Uint8List imageInBytes) async {
    final mimeType =
        lookupMimeType('image', headerBytes: imageInBytes) ?? 'image/*';
    final imageContent = DataPart(mimeType, imageInBytes);
    final describeImagePrompt = TextPart(
        'Extract the animal name from this image in this specific format: "The animal in the image is {animal_name}".');
    final prompt = Content.multi([describeImagePrompt, imageContent]);
    final response = await visionModel.generateContent([prompt]);
    return response.text ?? 'Could not find animal in this image, try again!';
  }
}

AnimalInfo parseAnimalInfo(String response, String animal) {
  response = response.toLowerCase();
  print(response);
  List<String> lines = response.split('\n');

  String animalName = animal;
  String funFacts = '';
  List<LocationModel> locations = [];

  bool parsingFunFacts = false;
  bool parsingLocations = false;

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    if (line.contains('fun fact')) {
      parsingFunFacts = true;
      while (i < lines.length - 1 &&
          (lines[i + 1].isEmpty || lines[i + 1].trim().isEmpty)) {
        i++;
      }
    } else if (line.contains('list of locations')) {
      parsingLocations = true;
    } else if (parsingFunFacts) {
      if (line.isNotEmpty) {
        //funFacts += '- ${line.trim()}\n';
        funFacts += '${line.trim()}\n\n';
      } else {
        parsingFunFacts = false;
      }
    } else if (parsingLocations) {
      if (line.contains('location')) {
        String country = lines[i + 1].split(': ')[1];
        String city = lines[i + 2].split(': ')[1];

        String latitudeLine = '', longitudeLine = '';
        for (int j = i + 3; j < lines.length; j++) {
          if (lines[j].contains('<latitude>')) {
            latitudeLine = lines[j];
          }
          if (lines[j].contains('<longitude>')) {
            longitudeLine = lines[j];
          }
          if (latitudeLine.isNotEmpty && longitudeLine.isNotEmpty) {
            break;
          }
        }

        double latitude = double.parse(
            latitudeLine.split('<latitude>')[1].split('</latitude>')[0]);
        double longitude = double.parse(
            longitudeLine.split('<longitude>')[1].split('</longitude>')[0]);

        LocationModel location = LocationModel(
          country: country,
          city: city,
          latitude: latitude,
          longitude: longitude,
        );
        locations.add(location);
      }
    }
  }
  print(funFacts);
  print(locations);

  return AnimalInfo(
    animalName: animalName,
    funFacts: funFacts,
    locations: locations,
  );
}
