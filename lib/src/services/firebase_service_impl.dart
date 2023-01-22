import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_day/src/services/firebase_service.dart';

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> punchIn() async {
    _firestore.collection('logs').doc();
  }

  @override
  Future<void> punchOut() async {}
}
