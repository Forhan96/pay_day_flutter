import 'package:flutter/material.dart';
import 'package:pay_day/pay_day_app.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:pay_day/src/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); //initializing Dependency Injection
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AttendanceProvider>()),
      ],
      child: const PayDayApp(),
    ),
  );
}
