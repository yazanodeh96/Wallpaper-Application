import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:wptask/Provider/wallpaper_provider.dart';
import 'package:wptask/View/searchScreen.dart';
import 'package:wptask/View/wpDetails.dart';

import 'FavoritsWallPaper.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var wallpaperProvider = Provider.of<WallPaperProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("WallPapers"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              },
              icon: Icon(Icons.favorite))
        ],
        centerTitle: true,
      ),
      body: wallpaperProvider.wallpapers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: wallpaperProvider.wallpapers.length,
              itemBuilder: ((context, index) {
                var wallpaper = wallpaperProvider.wallpapers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WallPaperDetails(
                                  imgUrl: wallpaperProvider
                                      .wallpapers[index].imgUrl,
                                )));
                  },
                  child: Image.network(wallpaper.imgUrl),
                );
                // return Image.network(wallpaper.imgUrl);
              }),
            ),
    );
  }
}
