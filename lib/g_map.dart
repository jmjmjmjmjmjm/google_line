import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/controllers/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatelessWidget {
  MapController c = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<MapController>(
        builder: (_) => GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          markers: c.markerList.value,
          polylines: c.polyline.value,
          initialCameraPosition: c.kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            c.mapController.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.toggle.value = !c.toggle.value;
          c.toggle.value ? c.closeBtn() : c.plusBtn();
        },
        child: Obx(() => c.toggle.value ? Icon(Icons.add) : Icon(Icons.close)),
      ),
    );
  }
}
