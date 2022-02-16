import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  static const PLACES_LIST_SCREEN = '/places';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AddPlacesScreen.ADD_PLACES_ROUTE);
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<GreatPlaces>(
            child: const Center(
              child: Text('Got no places yet'),
            ),
            builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                ? ch!
                : ListView.builder(
                    itemCount: greatPlaces.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(greatPlaces.items[i].image),
                      ),
                      title: Text(greatPlaces.items[i].title),
                      onTap: () {
                        //go to details page
                      },
                    ),
                  ),
          ),
        ));
  }
}
