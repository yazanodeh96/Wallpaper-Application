import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteWallpapers = [];
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<String> get favoriteWallpapers => _favoriteWallpapers;

  Future<void> addToFavorites(String imgUrl) async {
    // _favoriteWallpapers.add(imgUrl);
    await _databaseHelper.insert(imgUrl);
    _favoriteWallpapers = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  Future<void> removeFromFavorites(String imgUrl) async {
    // _favoriteWallpapers.remove(imgUrl);
    await _databaseHelper.delete(imgUrl);
    _favoriteWallpapers = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    _favoriteWallpapers = await _databaseHelper.getFavorites();
    notifyListeners();
  }
}



// import 'package:flutter/foundation.dart';

// class FavoriteProvider extends ChangeNotifier {
//   List<String> _favoriteWallpapers = [];

//   List<String> get favoriteWallpapers => _favoriteWallpapers;

//   void addToFavorites(String imageUrl) {
//     _favoriteWallpapers.add(imageUrl);
//     notifyListeners();
//   }

//   void removeFromFavorites(String imageUrl) {
//     _favoriteWallpapers.remove(imageUrl);
//     notifyListeners();
//   }
// }
