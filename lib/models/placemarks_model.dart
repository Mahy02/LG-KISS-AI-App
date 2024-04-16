class Placemark {
  final String name;
  final String? description;
  final double longitude;
  final double latitude;
  final double? altitude;

  Placemark({
    required this.name,
    this.description,
    required this.longitude,
    required this.latitude,
    this.altitude,
  });


}
