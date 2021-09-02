import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/datas/map_data.dart';
import 'package:google_map/models/MapModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Completer<GoogleMapController> mapController = Completer();
  var kGooglePlex = CameraPosition(
    target: LatLng(35.207165, 126.863215),
    zoom: 14.4746,
  );
  var mapList = MapData.list; // 데이터 리스트
  var markerList = <Marker>{}.obs; // 마커 리스트
  var latlng = <LatLng>[]; // 좌표 리스트
  var polyline = <Polyline>{}.obs; // 선
  var toggle = true.obs; // 토글버튼
  @override
  void onInit() {
    super.onInit();

    mapList.asMap().forEach((i, value) {
      // 선
      latlng.add(LatLng(
          mapList[i].place['lat'] ??= 0.0, mapList[i].place['lng'] ??= 0.0));
      // 마커
      markerList.add(Marker(
        infoWindow: InfoWindow(title: mapList[i].origin['title'].toString()),
        draggable: true,
        position: LatLng(
            mapList[i].place['lat'] ??= 0.0, mapList[i].place['lng'] ??= 0.0),
        markerId: MarkerId(i.toString()),
      ));
    });
    lineAdd();
  }

  // 선 그리기
  void lineAdd() {
    polyline.add(Polyline(
        polylineId: PolylineId('one'),
        visible: true,
        width: 2,
        points: latlng,
        color: Colors.blue));
  }

  plusBtn() {
    // 맵데이터 추가
    mapList.add(MapModel(
        origin: {'title': ' 광주대학교'},
        ref: 4,
        place: {'title': '광주대학교', 'lat': 35.10684, 'lng': 126.89533}));
    // 마커추가
    markerList.add(Marker(
        infoWindow: InfoWindow(title: mapList[3].origin['title'].toString()),
        markerId: MarkerId('new'),
        draggable: true,
        position: LatLng(35.10684, 126.89533)));
    latlng.add(LatLng(35.10684, 126.89533)); // 라인리스트에추가
    lineAdd(); // 선 추가
    _goTo(LatLng(35.10684, 126.89533), 12); // 카메라이동
  }

  // 카메라이동
  Future<void> _goTo(LatLng latLng, double zoom) async {
    CameraPosition goTo = CameraPosition(target: latLng, zoom: zoom);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(goTo));
  }

  // close버튼
  closeBtn() {
    polyline.clear();
    // 마커제거
    markerList.remove(Marker(
        infoWindow: InfoWindow(title: mapList[3].origin['title'].toString()),
        markerId: MarkerId('new'),
        draggable: true,
        position: LatLng(35.10684, 126.89533)));
    _goTo(
        LatLng(
            mapList[0].place['lat'] ??= 0.0, mapList[0].place['lng'] ??= 0.0),
        12);
  }
}
