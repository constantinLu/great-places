const GOOGLE_API_KEY = {'PLACE_HOLDER'};

class LocationHelper {
  static String generateLocationPreviewImage(double? latitude, double? longitude) {
    var asd =
        'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude'
        '&zoom=13&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Alabel:A%7A$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
    return asd;
  }
}
