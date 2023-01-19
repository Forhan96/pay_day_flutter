import 'package:get_it/get_it.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:pay_day/src/providers/home_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // //repositories
  // sl.registerLazySingleton<FirebaseService>(
  //       () => FirebaseServiceImpl(),
  // );
  // sl.registerLazySingleton<ApiService>(
  //       () => ApiServiceImpl(),
  // );
  //
  // //providers
  sl.registerFactory(
    () => HomeProvider(),
  );
  sl.registerFactory(
    () => AttendanceProvider(),
  );
  // sl.registerFactory(
  //       () => AuthProvider(
  //     firebaseService: sl(),
  //     apiService: sl(),
  //     sharedPreferences: sl(),
  //   ),
  // );
}
