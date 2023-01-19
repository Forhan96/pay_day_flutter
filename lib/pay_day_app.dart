import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_day/src/routes/router_helper.dart';
import 'package:pay_day/src/routes/routes.dart';
import 'package:pay_day/src/themes/light_theme.dart';

class PayDayApp extends StatefulWidget {
  const PayDayApp({Key? key}) : super(key: key);

  @override
  State<PayDayApp> createState() => _PayDayAppState();
}

class _PayDayAppState extends State<PayDayApp> {
  @override
  void initState() {
    super.initState();
    RouterHelper().setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pay Day',
        theme: buildLightTheme(context),
        darkTheme: buildLightTheme(context),
        themeMode: ThemeMode.light,
        onGenerateRoute: RouterHelper.router.generator,
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}
