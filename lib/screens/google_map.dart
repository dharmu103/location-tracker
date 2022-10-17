import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracker/controller/map_controller.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GetBuilder<MapController>(builder: (_) {
        return Obx(() {
          return GoogleMap(
            //this method call for get googlemapcontroller instance for all future working events
            onMapCreated: (c) {
              controller.setGoogleMapController(c);
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    controller.currentLat.value, controller.currentLng.value),
                zoom: 14),
            markers: controller.markers!.toSet(),
            // onCameraMove: (position) {},
            onTap: (argument) {
              controller.moveToCurrentLocation(argument);
            },
          );
        });
      }),
    );
  }
}
