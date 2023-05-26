import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';

class GoogleMapPinController extends GetxController {
  LatLngBounds? _visibleRegion;
  Size? _visibleScreenSize;
  GoogleMapController? _mapController;
  List<GedungListData> _gedungList = [];

  List<GedungListData> get gedungList => _gedungList;

  void updateGoogleMapController(GoogleMapController mapController) async {
    _mapController = mapController;
    await _setPositionOnScreen();
    update();
  }

  void updateScreenVisibleArea(Size size) {
    _visibleScreenSize = size;
    update();
  }

  void updateGedungList(List<GedungListData> list) {
    _gedungList = list;
    update();
  }

  void updateUI() {
    update();
  }

  Future _setPositionOnScreen() async {
    if (_mapController != null && _visibleScreenSize != null) {
      _visibleRegion = await _mapController?.getVisibleRegion();
      if (_visibleRegion != null) {
        var sSize = _visibleScreenSize;
        var sdl = _visibleRegion!.northeast.latitude -
            _visibleRegion!.southwest.latitude;
        var sdlg = _visibleRegion!.southwest.longitude -
            _visibleRegion!.northeast.longitude;
        if (_mapController != null) {
          for (var item in _gedungList) {
            if (item.location != const LatLng(0, 0)) {
              var fdl =
                  _visibleRegion!.northeast.latitude - item.location.latitude;
              var fdlg = _visibleRegion!.southwest.longitude -
                  item.location.longitude;
              item.screenMapPin = Offset(
                  (fdlg * sSize!.width) / sdlg, (fdl * sSize.height) / sdl);
            }
          }
        }
      }
    }
  }
}