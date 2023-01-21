import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pay_day/src/utils/debugger.dart';

class AttendanceProvider extends ChangeNotifier {
  int _totalMinutes = 0;
  int _minutes = 0;
  int _hours = 0;
  DateTime? _dateTime;
  String? _inTime;
  String? _outTime;

  String? _ip;
  Position? _currentPosition;
  String? _currentAddress;

  GoogleMapController? _mapController;

  int get totalMinutes => _totalMinutes;
  int get minutes => _minutes;
  int get hours => _hours;
  DateTime? get dateTime => _dateTime;
  String? get inTime => _inTime;
  String? get outTime => _outTime;

  String? get ip => _ip;
  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;

  GoogleMapController? get mapController => _mapController;

  set mapController(GoogleMapController? controller) {
    _mapController = controller;
    notifyListeners();
  }

  Future<void> updateTime() async {
    _dateTime = DateTime(2023, 1, 21, 23, 1);
    if (_dateTime != null) {
      _inTime = DateFormat.jm().format(_dateTime!);
      notifyListeners();
    }
    if (_dateTime != null) {
      _outTime = DateFormat.jm().format(_dateTime!);
      notifyListeners();
    }

    _totalMinutes = DateTime.now().difference(_dateTime ?? DateTime.now()).inMinutes;
    _minutes = _totalMinutes % 60;
    _hours = (_totalMinutes - _minutes) ~/ 60;
    notifyListeners();
  }

  Future<void> getIp() async {
    _ip = await Ipify.ipv4();
    notifyListeners();
  }

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      Debugger.debug(title: "ERROR", data: error.toString());
    });
    _currentPosition = await Geolocator.getCurrentPosition();
    notifyListeners();
  }

  Future<void> animateMap() async {
    LatLng currentLatLng = LatLng(currentPosition?.latitude ?? 0.0, currentPosition?.longitude ?? 0.0);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLatLng, zoom: 17)));
    notifyListeners();
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
