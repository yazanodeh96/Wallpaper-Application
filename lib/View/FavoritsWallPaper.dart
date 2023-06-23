import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/favorits_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    var favoriteWallpapers = favoriteProvider.favoriteWallpapers;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: favoriteWallpapers.isEmpty
          ? Center(child: Text("No favorite wallpapers"))
          : ListView.builder(
              itemCount: favoriteWallpapers.length,
              itemBuilder: (context, index) {
                var imageUrl = favoriteWallpapers[index];
                return ListTile(
                  title: Image.network(imageUrl),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      favoriteProvider.removeFromFavorites(imageUrl);
                    },
                  ),
                );
              },
            ),
    );
  }
}
