import 'package:flutter/material.dart';
import 'package:pay_day/src/providers/home_provider.dart';
import 'package:pay_day/src/screens/attendance_screen.dart';
import 'package:pay_day/src/screens/home_screen/bottom_nav.dart';
import 'package:pay_day/src/screens/leave_screen.dart';
import 'package:pay_day/src/screens/more_screen.dart';
import 'package:pay_day/src/screens/payslip_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List screens = [
      const AttendanceScreen(),
      const LeaveScreen(),
      const PayslipScreen(),
      const MoreScreen(),
    ];
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
        body: screens[homeProvider.currentNavIndex],
        bottomNavigationBar: const BottomNav(),
      );
    });
  }
}
