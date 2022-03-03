import 'dart:io';

import 'package:flutter/material.dart';

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
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address});
}
