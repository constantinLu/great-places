import 'dart:io';

class Place {
  final String id;
  final String title;
  PlaceLocation? location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      this.location,
      required this.image});
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation.name(this.latitude, this.longitude, this.address);
}
