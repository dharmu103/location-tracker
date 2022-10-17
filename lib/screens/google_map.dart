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
        actions: [
          IconButton(
              onPressed: () {
                controller.buttonsVisibility.value == true
                    ? controller.buttonsVisibility.value = false
                    : controller.buttonsVisibility.value = true;
              },
              icon: const Icon(Icons.arrow_drop_down))
        ],
      ),
      body: Stack(
        children: [
          GetBuilder<MapController>(builder: (_) {
            return Obx(() {
              return GoogleMap(
                //this method call for get googlemapcontroller instance for all future working events
                onMapCreated: (c) {
                  controller.setGoogleMapController(c);
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(controller.currentLat.value,
                        controller.currentLng.value),
                    zoom: 14),
                markers: controller.markers!.toSet(),
                // onCameraMove: (position) {},
                onTap: (argument) {
                  controller.moveToCurrentLocation(argument);
                },
              );
            });
          }),
          Obx(() {
            return Visibility(
              visible: controller.buttonsVisibility.value,
              child: Container(
                height: 50,
                color: Colors.blue[200],
                child: ListView.builder(
                    itemCount: controller.markers?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                controller.moveToCurrentLocation(
                                    controller.markers![index].position);
                              },
                              child: Text(controller
                                  .markers![index].infoWindow.title
                                  .toString())),
                        ),
                      );
                    }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
