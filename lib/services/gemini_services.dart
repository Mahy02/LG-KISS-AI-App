import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: dotenv.env['GEMINI_API_KEY']!);
  final visionModel = GenerativeModel(
      model: 'gemini-pro-vision', apiKey: dotenv.env['GEMINI_API_KEY']!);

  Future<String?> generateText(String inputPrompt) async {
    String prompt = '''
** Imagine you're an Animal Assistant that answers users any question they ask about animals.** 
** Generate a list of cities all over the world where $inputPrompt exists and Fun facts about this $inputPrompt.**

** structure: **
  -**Animal Name:** Specify the name of the animal from the $inputPrompt.
  -**Fun Facts:** Provide engaging and interesting facts about the animal in bullet points format.
  - **List of locations:** Present the list of locations that the animal exists including the city, country, and coordinates of the location. Include a minimum of 10 locations.
  - **Content:** For each location include:
    - **Country:**Indicate the country where the animal exists
    - **City:** Indicate the city where the animal exists.
    - **Coordinates:** Provide the latitude and longitude coordinates in decimal degrees using XML structure. Do not include anything else except the XML code in this point.

  - **Style:** Maintain an engaging and evocative tone, igniting the user's curiosity and excitement about the animals.

- **Examples:**

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

    return response.text;
  }
}



/*
prompt:
** Imagine you're an Animal Assistant that answers users any question they ask about animals.** 
** Generate a list of cities all over the world where {input_prompt} exists and Fun facts about this {input_prompt}.**

** structure: **
  -**Animal Name:** Specify the name of the animal from the {input_prompt}.
  -**Fun Facts:** Provide engaging and interesting facts about the animal in bullet points format.
  - **List of locations:** Present the list of locations that the animal exists including the city, country, and coordinates of the location. Include a minimum of 10 locations.
  - **Content:** For each location include:
    - **Country:**Indicate the country where the animal exists
    - **City:** Indicate the city where the animal exists.
    - **Coordinates:** Provide the latitude and longitude coordinates in decimal degrees using XML structure. Do not include anything else except the XML code in this point.

  - **Style:** Maintain an engaging and evocative tone, igniting the user's curiosity and excitement about the animals.

- **Examples:**

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

*/