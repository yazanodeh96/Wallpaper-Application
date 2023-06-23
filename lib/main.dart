import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:wptask/Provider/favorits_provider.dart';
import 'package:wptask/Provider/wallpaper_provider.dart';

import 'View/homeScreen.dart';
import 'View/wpDetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            var wallpaperProvider = WallPaperProvider();
            wallpaperProvider.fetchWallPapers();
            return wallpaperProvider;
          },
        ),
        ChangeNotifierProvider(create: (context) {
          var favoriteProvider = FavoriteProvider();
          favoriteProvider.loadFavorites();
          return favoriteProvider;
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WallPaper App',
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => homeScreen(),
        //   '/details': (context) => WallPaperDetails()
        // },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: homeScreen(),
      ),
    );
  }
}
