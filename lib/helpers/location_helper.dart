import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDXf8neccrBke2QnjrDoIdu04KRUogr9eU';

class LocationHelper {
  static String generateLocationPreviewImage(double? latitude, double? longitude) {
    var asd = 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude'
        '&zoom=13&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Alabel:A%7A$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
    return asd;
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY');
    final response = await http.get(uri);
    return json.decode(response.body)['results'][0]['formatted_address']; //a map of results
  }
}
