import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wptask/model/wallpaper_model.dart';

class WallPaperProvider extends ChangeNotifier {
  List<Wallpaper> _wallpapers = [];

  List<Wallpaper> get wallpapers => _wallpapers;

  Future<void> fetchWallPapers() async {
    final url = 'https://api.pexels.com/v1/curated?per_page=50';
    final headers = {
      'Authorization':
          'i8xOX360bEUz8UaC8wdkEb6B6tBIY49qlRQ7BS7DdjTv5z2Kf9eIy1m6'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final wallpapersData = jsonData['photos'] as List<dynamic>;
        _wallpapers = wallpapersData
            .map((data) => Wallpaper(data['src']['tiny']))
            .toList();
        notifyListeners();
      }
    } catch (error) {
      print('Somthing went Wrong');
    }
  }
}
