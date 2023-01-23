import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeHelper {
  String getTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return DateFormat.jm().format(dateTime);
  }

  String getDate(Timestamp? timestamp) {
    if (timestamp == null) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String getDuration(int? totalMinutes) {
    if (totalMinutes == null) {
      return "0h 0m";
    }
    int minutes = totalMinutes % 60;
    int hours = (totalMinutes - minutes) ~/ 60;

    return "${hours}h ${minutes}m";
  }
}
