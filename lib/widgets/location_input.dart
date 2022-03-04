import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double long) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, long);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData;
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      print("ERROR GETTING LOCATION");
      return;
    }
  }

  Future<void> _selectOnMap() async {
    //returning the latLong data from map_screen
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: _previewImageUrl == null
            ? const Text('No Location Chosen', textAlign: TextAlign.center)
            : Image.network(
                _previewImageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text('Current location'),
            style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            onPressed: _getCurrentUserLocation //JUST POINT AT THE METHOD,
            ),
        TextButton.icon(
            onPressed: _selectOnMap,
            icon: const Icon(Icons.map_rounded),
            label: const Text('Select on Map'),
            style: TextButton.styleFrom(primary: Theme.of(context).primaryColor))
      ])
    ]);
  }
}
