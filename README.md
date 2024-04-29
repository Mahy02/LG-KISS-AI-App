# Discover Animals Project

# Welcome to Discover Animals App!

This application was developed under the KISS app 2nd edition contest with Flutter & AI for LIQUID GALAXY, powered by GDG Lleida. The idea was to make a very simple app that uses any of the google generative AI models to allow the users to query the model about anything they want, and the response can then be visualized on the liquid galaxy rig through KML files.

<br>

My app was about discovering animals world wide and allowing the users to ask the model anything they want to know about any animal. The model I used was the Gemini model accessed through the API. Since the Gemini model allows multi-modal functionalities, I implemented 3 variations where the user can enter the animal he wants, either through AI recommendations, or through entering a prompt or through uploading an image. 


1. [What is Liquid Galaxy?](#LiquidGalaxy)
2. [What is a KML?](#KML)
3. [What is a Gemini Model?](#GeminiModel)
4. [Tha app's main features](#mainFeatures)
5. [App Screenshots](#screenshots)
6. [Prerequisites & Usage for running the APK](#runningapk)
7. [Prerequisites & Usage For running the code from the source](#runningsourcecode)
8. [Developers Guide](#developersguide)

## What is Liquid Galaxy? <a name="LiquidGalaxy"></a>

<br>

The Liquid Galaxy is an open source project founded by Google and created by Google employee Jason Holt in 2008. Liquid Galaxy started out as a panoramic multi-display Google Earth viewer, but has evolved to become a general data visualization tool for operations, marketing and research. It gives a unique experience to allow users to fly around Google Earth, view photos, screen layouts, balloons, placemarks and develop interactive tours.

<br>

Liquid Galaxy consists of 3 or more computers for multiple displays, and each computer manages a display. It depends on a master/slave architecture where the master is responsible for receiving all information and replicating it to the other nodes using SSH message passing, allowing the screens to behave in a synchronized manner. You can find more about Liquid Galaxy from [here](https://liquidgalaxy.eu/)  

<br>


## What is a KML? <a name="KML"></a>

<br>

Keyhole Markup Language (KML) is a file format used to display geographic data in an Earth browser such as Google Earth. You can create KML files to pinpoint locations, add image overlays, expose rich data in new ways.

<br>

It is a very important aspect in our project as we use it to send data to the Liquid Galaxy to view our Project logos as image overlay, or add placemarks for certain POI “point of interest”, show a balloon on the LG where it can include 3D models, text descriptions, images, polygons and many more. You could also use it for certain functionalities such as touring and orbiting and customizing them as you want. Each location has an associated longitude and latitude, and view-specific data such as heading, altitude and tilt can be provided to define the “Look At” or “Camera view” for geospatial data

<br>

You can refer to the [documentation](https://developers.google.com/kml/documentation) , if you want to dive deeper to KMLs and make the user enjoy a unique experience using your app!!  

<br>

This is an example of a simple basic KML file to show you an idea of how it looks like:

<br>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Placemark>
    <name>Simple placemark</name>
    <description>Attached to the ground. Intelligently places itself 
       at the height of the underlying terrain.</description>
    <Point>
      <coordinates>-122.0822035425683,37.42228990140251,0</coordinates>
    </Point>
  </Placemark>
</kml>
```

<br>

This is how you create a simple placemark, and if you are wondering what placemark it is, its right over Google’s Building 41 where they developed Google earth !!
<br>
Of course, this is just a simple example, you can definitely do magnificent things with playing with KML files!

<br>

## What is a Gemini Model? <a name="GeminiModel"></a>
<br>
Generative models are a class of AI models designed to generate responses according to the dataset they are trained on. With the rise of AI, there are many generative models available now, including the Gemini model from Google. 
<br>
Gemini model is known for its multimodal capabilities, which means it can handle input in various forms such as text, images or combinations of both. It has the ability to generate text, images, audio and more!

<br>

## Tha app's main features <a name="mainFeatures"></a>

- Connection to the Liquid Galaxy
- Performing all LG tasks
- Entering the Gemini API key 
- Entering a prompt
- Choosing one of the animals from the AI recommendations
- Uploading an image of the desired animal
- Asking Gemini model anything about the chosen animal
- Viewing the responses on the liquid galaxy in the balloons
- Fly-to a certain location of the list of locations where the animal exist on the LG rig
- Viewing pins of all locations where the animal exist on the LG rig
- Orbiting around a certain location on the LG rig.

## App Screenshots <a name="screenshots"></a>

<br>

### Home Page where the user can enter a prompt, upload an image or choose one of the AI suggestions:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146287.png" alt="ss" width="500" style="margin-right: 20px;">
<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146472.png" alt="ss" width="500" style="margin-right: 20px;">
<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146771.png" alt="ss" width="500" style="margin-right: 20px;">

### Model Response on the app, and on the LG rig:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146569.png" alt="ss" width="500" style="margin-right: 20px;">
<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot%202024-04-26%20184941.png" alt="ss" width="800" style="margin-right: 20px;">

### Animals Placemarks sent through kml file:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot%202024-04-26%20185108.png" alt="ss" width="500" style="margin-right: 20px;">

### Fly to a location on the LG and orbit around it:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot%202024-04-26%20185023.png" alt="ss" width="800" style="margin-right: 20px;">
<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146594.png" alt="ss" width="500" style="margin-right: 20px;">

### Asking the model anything about the animal and the response can be shown on both the app and the LG Rig:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146709.png" alt="ss" width="500" style="margin-right: 20px;">
<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot%202024-04-26%20185201.png" alt="ss" width="500" style="margin-right: 20px;">

### Connection Manager Screen to connect to the LG:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146339.png" alt="ss" width="500" style="margin-right: 20px;">

### LG Tasks screen for rebooting, relaunching, shutting down, and clearing the kml:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146361.png" alt="ss" width="500" style="margin-right: 20px;">

### Settings page where you can add the model API key, save it, edit it or delete it:

<img src="https://github.com/Mahy02/LG-KISS-AI-App/blob/main/assets/images/screenshots/Screenshot_1714146380.png" alt="ss" width="500" style="margin-right: 20px;">



## Prerequisites & Usage for running the APK <a name="runningapk"></a>

- Need to have an Android Phone or Tablet with a minimum Android version "Android 11"
- Download the [APK](https://drive.google.com/file/d/1J4CYVpBHo1nnBjHeJKSawkBKCrs922Pm/view?usp=drive_link) and start using the app! 
- First you have to connect with the LG if you want to see visualizations on the LG rig through the connection manager page by entering your username, password, ip address, port number and number of screens.
- Then you have to add your Gemini API key from the settings page.


Now you can Enjoy the app :) 

<br>

## Prerequisites & Usage For running the code from the source <a name="runningsourcecode"></a>

<br>

### Prerequisites:

<br>

- Visual Studio Code or Android Studio or another IDE that supports flutter development
- Flutter SDK
- Android SDK
- Android device or emulator
- Git

<br>

Documentation on how to set up flutter SDK and its environment can be found [here](https://flutter.dev/docs/get-started/install)

<br>

> _Step 1: Clone the Repository_

The full code is located in this GitHub repository. To clone the project via terminal use the command:

```bash
git clone https://github.com/Mahy02/LG-KISS-AI-App.git 
```

<br>

>  _Step 2: Run the code_

Open a terminal and navigate to the project root directory. First you need to install all the packages by running the following command:

```bash
flutter pub get
```
<br>

After successfully installing the packages, make sure you have a device connected, either a real android phone or an emulator. You can run flutter doctor to check out the connected devices and if all environment is correct

```bash
flutter doctor
```
<br>

Since dart is moving up versions to offer null safety, some packages that are being used still haven’t migrated to the new null safety policies, so we need to run the project with the following command

```bash
flutter run --no-sound-null-safety
```
<br>

>  _Step 3: env file_

In the project root directory, you will find a .env.example file, rename this to .env and replace 'YOUR_GEMINI_API_KEY' with your own API key for development purposes.

<br>

If you followed all the steps till now you have your app up and running.

<br>

Enjoy the app  :)  !!


## Developers Guide <a name="developersguide"></a>

<br>

I used flutter to develop my app, and I used Gemini API as my generative AI model as it is free to use now and due to its multi-modality.

<br>

Packages I have used that helped me develop my app:

<br>

### <span style="text-decoration: underline;">flutter_dotenv</span>
  
<br>

While developing the application, you can use the dotenv flutter package to save your own API key in a .env file and refer to it later through dotenv.env[‘GEMINI_API_KEY’].

<br>

In your directory you can add your .env file and write your API key: 

<br>

```dart
GEMINI_API_KEY='YOUR_GEMINI_API_KEY'
```

<br>

Do not forget to add the .env file to your .gitignore files, so you are protected. 

```
.env
```

<br>

In the pubspec.yaml file you need to do the following:

<br>

Add the dependency:  flutter_dotenv: ^5.1.0

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_dotenv: ^5.1.0
```

<br>

Add the .env file under your assets:       - .env

```yaml
  assets:
      - .env
```

<br>

In the main function you need to write this line:

```dart
void main() async {
  await dotenv.load(fileName: ".env");
```

<br>

Now you can refer to the API key: 

```dart
apiKey: dotenv.env['GEMINI_API_KEY']
```

<br>


### <span style="text-decoration: underline;">google_generative_ai</span>

<br>

This package is a built-in flutter package that helps in using the gemini model through the API. It makes it much easier for developers.

<br>

Some functions that are helpful for implementing the gemini service:

<br>


1. Initializing the model and the API key

Note that there are 2 ways for entering the API key. When developing, you always use the env file to retrieve your API key. However during the release of the app, you let the users enter their own API key and save it in the app if they confirm on saving the API key.

<br>

While developing:

<br>

```dart
class GeminiService {
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: dotenv.env['GEMINI_API_KEY']!);
  final visionModel = GenerativeModel(
      model: 'gemini-pro-vision', apiKey: dotenv.env['GEMINI_API_KEY']!);
```

<br>

At release:

<br>

```dart
class GeminiService {
final model = GenerativeModel(
      model: 'gemini-pro', apiKey: ApiKeySharedPref.getAPIKey()!);
  final visionModel = GenerativeModel(
      model: 'gemini-pro-vision', apiKey: ApiKeySharedPref.getAPIKey()!);
```

<br>

2. Generating the response by entering your prompt:

<br>

```dart
  Future<String?> generateResponse(
      String inputPrompt) async {
    String prompt = inputPrompt;
    final content = Content.text(prompt);
    final response = await model.generateContent([content]);
    return response.text;
  }
```

<br>

However, you can always utilize prompt engineering until you find the best output from your model. You can also define the structure that you want the model to follow.  In my case, I wanted to generate the output in a certain format, so I can then parse the output and extract the relevant information I want.

<br>

Prompt Example:

<br>


```
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
```

<br>

3. You can also generate stream instead of a single response so the user doesn't have to wait for long response times.

<br>

```dart
 Stream<String?> generateStreamResponse(
      String inputPrompt) {
    String prompt = inputPrompt;
    final content = Content.text(prompt);
    return model.generateContentStream([content]).map((event) => event.text);
  }
```

<br>

4. Image description

<br>

```dart
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
```

<br>

As shown on the prompt above, I have specified how I want the model to respond so I can extract the animal_name later. For using this function, you first need to have mime package in your pubspec yaml file.

<br>

For the UI, you can easily use _FutureBuilders_ or _StreamBuilders_.

<br>

### <span style="text-decoration: underline;">dartssh2</span>

<br>

This package is needed for the LG connection to connect the client with the username, password, ip address and port number.

<br>

Connecting the Client:

<br>

```dart
/// Sets a client with the given [ssh] info.
  Future<String?> setClient(SSHModel ssh) async {
    String result = "";
    try {
      final socket = await SSHSocket.connect(ssh.host, ssh.port,
          timeout: const Duration(seconds: 36000000));
      String? password;
      bool isAuthenticated = false;

      _client = SSHClient(
        socket,
        onPasswordRequest: () {
          password = ssh.passwordOrKey;
          return password;
        },
        username: ssh.username,
        onAuthenticated: () {
          isAuthenticated = true;
        },
        keepAliveInterval: const Duration(seconds: 36000000),
      );

      /// Add a delay before checking isAuthenticated
      await Future.delayed(const Duration(seconds: 10));

      if (isAuthenticated) {
      } else {
        // If the client is not authenticated, indicate a failed connection
        throw Exception('SSH authentication failed');
      }
   
    } catch (e) {
      result = "Failed to connect to the SSH server: $e";
    }

    return result;
  }
```

<br>

Some of the LG commands used after setting the client:

<br>

- Relaunch Command

<br>

You can implement a “for loop” for the amount of screen number you have (i.e: 3) then execute:

```
"'/home/$user/bin/lg-relaunch' > /home/$user/log.txt"
```

<br>

Then execute :

<br>

```dart
"""RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $pw | sudo -S service \\\${SERVICE} start
else
  echo $pw | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $pw ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""
```

<br>

Where you can change $user with the username of the LG machine, and $pw is the password of the LG machine, while $i represents the lg machine which is specified in the for loop.

<br>

- The Reboot Command

<br>

You can implement a “for loop” for the amount of screen number you have (i.e: 3) then execute:

<br>

```dart
'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S reboot"'
```

<br>

Where you can change $pw with the password of the LG machine, while $i represents the lg machine you specified in the for loop

<br>

Example of the function with the for loop:

<br>

```dart
  Future<void> reboot() async {
    final pw = _sshData.passwordOrKey;
    final result = await getScreenAmount();
    if (result != null) {
      screenAmount = int.parse(result);
    }
    for (var i = screenAmount; i > 1; i--) {
      try {
        await _sshData
            .execute('sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S reboot"');
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
    try {
      await _sshData
          .execute('sshpass -p $pw ssh -t lg1 "echo $pw | sudo -S reboot"');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
```

<br>

Note that _sshData represents the client.

<br>


- The shutDown command:

<br>

You can implement a “for loop” for the amount of screen number you have (i.e: 3) then execute:

<br>

```dart
'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S poweroff"'
```
<br>

Where you can change $pw with the password of the LG machine, while $i represents the lg machine you specified in the for loop

<br>

Putting the given content into the /tmp/query.txt file

<br>

```dart
'echo "$content" > /tmp/query.txt'
```

<br>

Where you can change $content with the content you want to execute in /tmp/query.txt

<br>

Sending KML to slave machine:

<br>

```
"echo '$content' > /var/www/html/kml/slave_$screen.kml"
```

<br>

Where you can change $content with the content you want to execute in on slave machine, and $screen with the slave screen number

<br>

- Clearing the kml function in flutter:

<br>

```dart
 Future<void> clearKml({bool keepLogos = true}) async {
    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
    for (var i = 2; i <= screenAmount; i++) {
      String blankKml = KMLModel.generateBlank('slave_$i');
      query += " && echo '$blankKml' > /var/www/html/kml/slave_$i.kml";
    }
    if (keepLogos) {
      final kml = KMLModel(
        name: APP-logos',
        content: '<name>Logos</name>',
        screenOverlay: ScreenOverlayModel.logos().tag,
      );

      query +=
          " && echo '${kml.body}' > /var/www/html/kml/slave_$logoScreen.kml";
    }
    try {
      await _sshData.execute(query);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
```

<br>

- Flutter Function for sending Tour to LG:

<br>

```dart
///Visualizing the uploaded KML on LG command: 
echo "http://lg1:81/$projectname.kml" > /var/www/html/kmls.txt'
```

<br>

```dart
 Future<void> sendTour(String tourKml, String tourName) async {
    final fileName = '$tourName.kml';
    try {
      final kmlFile = await _fileService.createFile(fileName, tourKml);
      await _sshData.uploadKml(kmlFile, fileName);
      print('kml uploaded');
      await _sshData
          .execute('echo "\n$_url/$fileName" >> /var/www/html/kmls.txt');
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
```
<br>

- Fly to function:

<br>

```dart
 /// Command to fly to a certain location:
 'echo "flytoview=${flyto.generateLinearString()}" > /tmp/query.txt'
```

<br>

```dart
Future<void> flyTo(LookAtModel lookAt) async {
    try {
      await query('flytoview=${lookAt.linearTag}');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
```

<br>


- start and Stop tour commands:

<br>

```dart
  /// Command:
 'echo "playtour=Orbit" > /tmp/query.txt'
```

<br>

```dart
  Future<void> startTour(String tourName) async {
    try {
      print('here play tour');
      await query('playtour=$tourName');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
```

<br>

```dart
  /// Uses the [query] method to stop all tours in Google Earth.
  Future<void> stopTour() async {
    try {
      await query('exittour=true');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
```

### <span style="text-decoration: underline;">shared_preferences</span>

<br>

This is used for saving any kind of data locally in the app, so the user doesn't have to re-enter it every time he opens the app. 

<br>

This is used for the LG connection details, as well as the API keys.

<br>

### <span style="text-decoration: underline;">Provider</span>

<br>

This is used  for the state management of the app.

<br>

### <span style="text-decoration: underline;">Other packages:</span>

<br>

- path_provider
- google_fonts
- carousel_slider
- animated_text_kit
- mime
- image_picker
- geocoding










