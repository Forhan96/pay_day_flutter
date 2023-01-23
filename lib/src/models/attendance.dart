import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String? docId;
  bool? active;
  String? addressIn;
  String? addressOut;
  String? ipIn;
  String? ipOut;
  String? noteIn;
  String? noteOut;
  Timestamp? timeIn;
  Timestamp? timeOut;
  int? totalMinutes;

  Attendance({
    this.docId,
    this.active,
    this.addressIn,
    this.addressOut,
    this.ipIn,
    this.ipOut,
    this.noteIn,
    this.noteOut,
    this.timeIn,
    this.timeOut,
    this.totalMinutes,
  });

  Attendance.fromJson(Map<String, dynamic> doc, String logId) {
    docId = logId;
    active = doc['active'] as bool;
    addressIn = doc['addressIn'] as String?;
    addressOut = doc['addressOut'] as String?;
    ipIn = doc['ipIn'] as String?;
    ipOut = doc['ipOut'] as String?;
    noteIn = doc['noteIn'] as String?;
    noteOut = doc['noteOut'] as String?;
    timeIn = doc['timeIn'] as Timestamp?;
    timeOut = doc['timeOut'] as Timestamp?;
    totalMinutes = doc['totalMinutes'] as int?;
  }
}
