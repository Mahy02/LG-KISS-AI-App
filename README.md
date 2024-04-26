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
7. [Developers Guide](#developersguide)

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
You can refer to the [documentation](https://developers.google.com/kml/documentation), if you want to dive deeper to KMLs and make the user enjoy a unique experience using your app!!  
<br>
This is an example of a simple basic KML file to show you an idea of how it looks like:
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
## Prerequisites & Usage for running the APK <a name="runningapk"></a>

- Need to have an Android Phone or Tablet with a minimum Android version "Android 11"
- Download the [APK](https://drive.google.com/file/d/1J4CYVpBHo1nnBjHeJKSawkBKCrs922Pm/view?usp=drive_link) and start using the app! 
- First you have to connect with the LG if you want to see visualizations on the LG rig through the connection manager page by entering your username, password, ip address, port number and number of screens.
- Then you have to add your Gemini API key from the settings page.


Now you can Enjoy the app :) 

<br>

## Developers Guide <a name="developersguide"></a>

<br>
I used flutter to develop my app, and I used Gemini API as my generative AI model as it is free to use now and due to its multi-modality.
<br>
Packages I have used that helped me develop my app:
<br>
-   flutter_dotenv
<br>
While developing the application, you can use the dotenv flutter package to save your own API key in a .env file and refer to it later through dotenv.env[‘GEMINI_API_KEY’].
<br>
In your directory you can add your .env file and write your API key: 

```
GEMINI_API_KEY='YOUR_GEMINI_API_KEY'
```
<br>
Do not forget to add the .env file to your .gitignore files, so you are protected. 

```
.env
```
<br>

In the pubspec.yaml file you need to do the following:

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

- google_generative_ai





