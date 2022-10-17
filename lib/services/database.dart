import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/controller/map_controller.dart';

class DatabaseServices {
  final ref = FirebaseDatabase.instance.ref('BUS');

  fatchDatabase() async {
    print('object');
    BitmapDescriptor markerIcon =
        await Get.find<MapController>().updateCustomIcon();
    ref.onValue.listen((DatabaseEvent event) {
      Get.find<MapController>().markers?.clear();
      final data = event.snapshot.value;

      String jsonString = jsonEncode(data);
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      jsonData.forEach((key, value) {
        Marker marker = Marker(
            markerId: MarkerId(
              key,
            ),
            position: LatLng(value['Lat'].toDouble(), value['Lng'].toDouble()),
            icon: markerIcon,
            infoWindow: InfoWindow(title: key));
        Get.find<MapController>().markers?.add(marker);
      });
    });
  }
}
