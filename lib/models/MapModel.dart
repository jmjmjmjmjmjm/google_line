// To parse this JSON data, do
//
//     final mapModel = mapModelFromJson(jsonString);

import 'dart:convert';

MapModel mapModelFromJson(String str) => MapModel.fromJson(json.decode(str));

String mapModelToJson(MapModel data) => json.encode(data.toJson());

class MapModel {
  MapModel({
    this.ref,
    this.origin,
    this.place,
  });

  int? ref;
  dynamic? origin;
  dynamic? place;

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        ref: json["ref"],
        origin: Origin.fromJson(json["origin"]),
        place: Origin.fromJson(json["place"]),
      );

  Map<String, dynamic> toJson() => {
        "ref": ref,
        "origin": origin?.toJson(),
        "place": place?.toJson(),
      };
}

class Origin {
  Origin();

  factory Origin.fromJson(Map<String, dynamic> json) => Origin();

  Map<String, dynamic> toJson() => {};
}
