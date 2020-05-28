import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<GreatPlaces>(
          child: Center(
            child: Text('You have not added any places yet!'),
          ),
          builder: (ctx, greatPlacesData, child) => greatPlacesData.items.length <= 0
              ? child
              : ListView.separated(
                  separatorBuilder: (ctx, index) => Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  itemCount: greatPlacesData.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlacesData.items[i].image),
                    ),
                    title: Text(greatPlacesData.items[i].title.toString()),
                  ),
                ),
        ),
      ),
    );
  }
}
