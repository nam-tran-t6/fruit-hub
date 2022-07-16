import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppGoogleMapWidget extends StatefulWidget {
  void startShipper() {
    _state.testShipper();
  }

  final _state = _AppGoogleMapWidgetState();

  @override
  _AppGoogleMapWidgetState createState() => _state;
}

class _AppGoogleMapWidgetState extends State<AppGoogleMapWidget> {
  late GoogleMapController _mapController;

  final LatLng _center = LatLng(10.848261232950524, 106.77430084133368);

  final Set<Marker> _markers = HashSet();

  static const ZOOM_VALUE = 15.0;
  static const DEVICE_RATIO = 2.5;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: ZOOM_VALUE,
      ),
    );
  }

  void initData() async {
    var from = LatLng(10.848261232950524, 106.77430084133368);
    var to = LatLng(10.850981176565451, 106.79818538205024);
    BitmapDescriptor fromIcon, toIcon;

    fromIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: DEVICE_RATIO), AppImagePath.ship_from_icon);

    toIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: DEVICE_RATIO), AppImagePath.ship_to_icon);

    setState(() {
      _markers
          .add(Marker(markerId: MarkerId(Strings.shop), position: from, icon: fromIcon));
      _markers
          .add(Marker(markerId: MarkerId(Strings.receiver), position: to, icon: toIcon));
    });
  }

  void testShipper() async {
    BitmapDescriptor shipperIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5), AppImagePath.shipper_icon);
    var listPosition = [
      LatLng(10.78265506510334, 106.69583439813515),
      LatLng(10.76924255005207, 106.6360080831178),
      LatLng(10.81876869850379, 106.65893178496728),
      LatLng(10.866434586252364, 106.80333822119981),
      LatLng(10.851111391443933, 106.79812013709115),
    ];
    var shipper = Marker(
        markerId: MarkerId(Strings.shipper),
        position: listPosition[0],
        icon: shipperIcon);
    for (int i = 0; i < listPosition.length; i++) {
      await Future.delayed(Duration(seconds: 5));
      var position = listPosition[i];
      setState(() {
        _markers.remove(shipper);
        shipper = Marker(
            markerId: MarkerId(Strings.shipper), position: position, icon: shipperIcon);

        _markers.add(shipper);
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: position, zoom: ZOOM_VALUE)));
      });
    }
  }
}
