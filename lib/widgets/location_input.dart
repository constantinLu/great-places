import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(locData.latitude, locData.longitude);
    setState(() {
      _previewImageUrl =staticMapImageUrl;
    });
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
          label: const Text('Select on map'),
          style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: _getCurrentUserLocation //JUST POINT AT THE METHOD,
        ),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map_rounded),
            label: const Text('Location'),
            style: TextButton.styleFrom(primary: Theme.of(context).primaryColor))
      ])
    ]);
  }
}
