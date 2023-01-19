import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_day/src/utils/debugger.dart';

class AttendanceProvider extends ChangeNotifier {
  int _totalMinutes = 0;
  int _minutes = 0;
  int _hours = 0;
  DateTime? _dateTime;
  String? _inTime;
  String? _outTime;

  int get totalMinutes => _totalMinutes;
  int get minutes => _minutes;
  int get hours => _hours;
  DateTime? get dateTime => _dateTime;
  String? get inTime => _inTime;
  String? get outTime => _outTime;

  Future<void> updateTime() async {
    _dateTime = DateTime(2023, 1, 19, 23, 1);
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
    Debugger.debug(title: "hours", data: "$_hours -- $_minutes");
  }
}
