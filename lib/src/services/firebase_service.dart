import 'package:pay_day/src/models/attendance.dart';

abstract class FirebaseService {
  Future<void> punchIn({required String address, required String ip, required String note});
  Future<void> punchOut({required String docId, required String address, required String ip, required String note, required int totalMinutes});
  Future<Attendance?> getActiveAttendance();
  Future<Attendance> getAttendanceDetails(String docId);
  Future<List<Attendance>> getTodayLogs();
}
