import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; // a copy of the items
  }

  void addPlace(String pickedTitle, File pickedImage, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(location.latitude, location.longitude);
    final updatedLocation =
        PlaceLocation(latitude: location.latitude, longitude: location.longitude, address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      location: updatedLocation,
      title: pickedTitle,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_long': newPlace.location!.longitude,
      'address': newPlace.location!.address!
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_long'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
