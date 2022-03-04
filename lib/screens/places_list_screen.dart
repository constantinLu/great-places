import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/places_detail_screen.dart';
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
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
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
                            subtitle: Text(greatPlaces.items[i].location!.address!),
                            onTap: () {
                              //go to details page
                              Navigator.of(context).pushNamed(PlaceDetailScreen.PLACES_DETAIL, arguments: greatPlaces.items[i].id); //forword the ID to detail screen
                            },
                          ),
                        ),
                ),
        ));
  }
}
