import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pay_day/src/models/attendance.dart';
import 'package:pay_day/src/services/api_service.dart';
import 'package:pay_day/src/services/firebase_service.dart';
import 'package:pay_day/src/utils/debugger.dart';

import '../models/post.dart';

class AttendanceProvider extends ChangeNotifier {
  final FirebaseService firebaseService;
  final ApiService apiService;

  AttendanceProvider({
    required this.firebaseService,
    required this.apiService,
  });

  int _totalMinutes = 0;
  int _minutes = 0;
  int _hours = 0;
  int _remainingTotalMinutes = 0;
  int _remainingMinutes = 0;
  int _remainingHours = 0;
  DateTime? _dateTime;
  String? _inTime;
  String? _outTime;

  String? _ip;
  Position? _currentPosition;
  String? _currentAddress;

  GoogleMapController? _mapController;

  Attendance? _attendance;
  List<Attendance> _todayLogs = [];
  List<Post> _posts = [];

  int get totalMinutes => _totalMinutes;
  int get minutes => _minutes;
  int get remainingHours => _remainingHours;

  int get remainingTotalMinutes => _remainingTotalMinutes;
  int get remainingMinutes => _remainingMinutes;
  int get hours => _hours;
  DateTime? get dateTime => _dateTime;
  String? get inTime => _inTime;
  String? get outTime => _outTime;

  String? get ip => _ip;
  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;

  GoogleMapController? get mapController => _mapController;

  Attendance? get attendance => _attendance;
  List<Attendance> get todayLogs => _todayLogs;
  List<Post> get posts => _posts;

  set mapController(GoogleMapController? controller) {
    _mapController = controller;
    notifyListeners();
  }

  Future<void> updateTime() async {
    if (_attendance != null && _attendance?.timeIn != null) {
      _dateTime = DateTime.fromMillisecondsSinceEpoch(_attendance!.timeIn!.millisecondsSinceEpoch);
      notifyListeners();
    } else {
      _dateTime = null;
      _inTime = null;
      notifyListeners();
    }
    if (_dateTime != null) {
      _inTime = DateFormat.jm().format(_dateTime!);
      notifyListeners();
    }
    // if (_dateTime != null) {
    //   // _outTime = DateFormat.jm().format(_dateTime!);
    //   notifyListeners();
    // }

    _totalMinutes = DateTime.now().difference(_dateTime ?? DateTime.now()).inMinutes;

    _minutes = _totalMinutes % 60;
    _hours = (_totalMinutes - _minutes) ~/ 60;

    _remainingTotalMinutes = 540 - _totalMinutes;
    _remainingMinutes = _remainingTotalMinutes % 60;
    _remainingHours = (_remainingTotalMinutes - _remainingMinutes) ~/ 60;

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

  Future<void> punchIn(String note) async {
    firebaseService.punchIn(address: _currentAddress ?? 'N/A', ip: _ip ?? 'N/A', note: note);
  }

  Future<void> punchOut(String note) async {
    firebaseService.punchOut(docId: _attendance?.docId ?? "", address: _currentAddress ?? 'N/A', ip: _ip ?? 'N/A', note: note, totalMinutes: _totalMinutes);
  }

  Future<void> getActiveAttendance() async {
    _attendance = await firebaseService.getActiveAttendance();
    notifyListeners();
  }

  Future<void> getAttendanceDetails() async {
    _attendance = await firebaseService.getAttendanceDetails(_attendance?.docId ?? '');
    notifyListeners();
  }

  Future<void> getTodayLogs() async {
    _todayLogs = await firebaseService.getTodayLogs();
    notifyListeners();
  }

  Future<void> getPosts() async {
    http.Response response = await apiService.getPosts();
    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: "Something went wrong");
      return;
    }
    var res = await jsonDecode(response.body);
    res.forEach((element) {
      _posts.add(Post.fromJson(element));
      notifyListeners();
    });
    notifyListeners();
  }
}
