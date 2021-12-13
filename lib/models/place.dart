import 'dart:io';

import 'package:flutter/cupertino.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation.name(this.latitude, this.longitude, this.address);
}
