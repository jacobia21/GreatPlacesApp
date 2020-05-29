import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'image': path.basename(newPlace.image.path),
      'title': newPlace.title,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData('user_places');
    final directory = await sysPath.getApplicationDocumentsDirectory();

    _items = data
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: null,
              image: File(path.join(directory.path, item['image'])),
            ))
        .toList();
  }
}
