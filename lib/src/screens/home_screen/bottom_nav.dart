import 'package:flutter/material.dart';
import 'package:pay_day/src/providers/home_provider.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Payslip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'More',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: homeProvider.currentNavIndex,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        showUnselectedLabels: true,
        elevation: 15.0,
        onTap: (int index) {
          homeProvider.currentNavIndex = index;
        },
      );
    });
  }
}
