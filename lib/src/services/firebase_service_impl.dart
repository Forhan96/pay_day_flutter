import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_day/src/models/attendance.dart';
import 'package:pay_day/src/services/firebase_service.dart';

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> punchIn({required String address, required String ip, required String note}) async {
    _firestore.collection('logs').doc().set({
      "timeIn": DateTime.now(),
      "addressIn": address,
      "ipIn": ip,
      "noteIn": note,
      "active": true,
    });
  }

  @override
  Future<void> punchOut({required String docId, required String address, required String ip, required String note, required int totalMinutes}) async {
    _firestore.collection('logs').doc(docId).update({
      "timeOut": DateTime.now(),
      "addressOut": address,
      "ipOut": ip,
      "noteOut": note,
      "active": false,
      "totalMinutes": totalMinutes,
    });
  }

  @override
  Future<Attendance?> getActiveAttendance() async {
    QuerySnapshot doc = await _firestore.collection('logs').where('active', isEqualTo: true).get();
    if (doc.docs.isEmpty) {
      return null;
    }
    Attendance attendance = Attendance.fromJson(doc.docs[0].data() as Map<String, dynamic>, doc.docs[0].id);
    return attendance;
  }

  @override
  Future<Attendance> getAttendanceDetails(String docId) async {
    DocumentSnapshot doc = await _firestore.collection('logs').doc(docId).get();
    Attendance attendance = Attendance.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    return attendance;
  }

  @override
  Future<List<Attendance>> getTodayLogs() async {
    List<Attendance> todayLogs = [];
    QuerySnapshot querySnapshot =
        await _firestore.collection('logs').where('timeIn', isGreaterThanOrEqualTo: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).get();
    querySnapshot.docs.forEach((element) {
      todayLogs.add(Attendance.fromJson(element.data() as Map<String, dynamic>, element.id));
    });

    return todayLogs;
  }
}
