import 'package:get_it/get_it.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:pay_day/src/providers/home_provider.dart';
import 'package:pay_day/src/services/firebase_service.dart';
import 'package:pay_day/src/services/firebase_service_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repositories
  sl.registerLazySingleton<FirebaseService>(() => FirebaseServiceImpl());
  // sl.registerLazySingleton<ApiService>(
  //       () => ApiServiceImpl(),
  // );

  // //providers
  sl.registerFactory(() => HomeProvider());
  sl.registerFactory(() => AttendanceProvider());
}
