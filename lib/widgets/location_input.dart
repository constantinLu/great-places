import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        child: _previewImageUrl == null
            ? const Text('No Location Chosen', textAlign: TextAlign.center)
            : Image.network(
                _previewImageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(children: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on),
            label: const Text('Current Location'),
            style: TextButton.styleFrom(primary: Theme.of(context).primaryColor)),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map_rounded),
            label: const Text('Location'),
            style: TextButton.styleFrom(primary: Theme.of(context).primaryColor))
      ])
    ]);
  }
}
