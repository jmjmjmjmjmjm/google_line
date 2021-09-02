import 'package:google_map/models/MapModel.dart';

class MapData {
  static List<MapModel> list = [
    MapModel(
        ref: 1,
        origin: {'title': '사무실'},
        place: {'title': '사무실', 'lat': 37.207165, 'lng': 126.863215}),
    MapModel(
        ref: 2,
        origin: {'title': '광주역'},
        place: {'title': '광주역', 'lat': 35.16539, 'lng': 126.90922}),
    MapModel(
        ref: 3,
        origin: {'title': '광주시청'},
        place: {'title': '광주시청', 'lat': 35.16052, 'lng': 126.85148})
  ];
}
