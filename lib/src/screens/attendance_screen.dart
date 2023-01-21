import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pay_day/src/components/punch_bottomsheet.dart';
import 'package:pay_day/src/components/time_item.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      AttendanceProvider attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
      attendanceProvider.updateTime();
      timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => attendanceProvider.updateTime());
      attendanceProvider.updateTime();
      attendanceProvider.getIp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<AttendanceProvider>(builder: (context, attendanceProvider, child) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Steave",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      DateFormat.MMMMEEEEd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.h),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    'Regular',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 64.h,
            ),
            SleekCircularSlider(
              min: 0,
              max: 560,
              initialValue: attendanceProvider.totalMinutes.toDouble(),
              appearance: CircularSliderAppearance(
                size: 200,
                startAngle: 185,
                angleRange: 170,
                customWidths: CustomSliderWidths(
                  trackWidth: 13,
                  progressBarWidth: 12,
                ),
                customColors: CustomSliderColors(
                  trackColor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
                  progressBarColor: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              innerWidget: (double value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${attendanceProvider.hours} ',
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: 'h  ',
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        TextSpan(
                          text: '${attendanceProvider.minutes} ',
                          style: Theme.of(context).textTheme.headline2?.copyWith(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                          text: 'm',
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ]),
                    ),
                    Text(
                      "Worked",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ],
                );
              },
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeItem(
                    name: 'In',
                    nameStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    value: attendanceProvider.inTime ?? '-',
                    valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                    showDivider: false,
                  ),
                  TimeItem(
                    name: 'Out',
                    nameStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    value: '11:00',
                    valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                    dividerColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  TimeItem(
                    name: 'Balance',
                    nameStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    value: '-2h 39m',
                    valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                    dividerColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            OutlinedButton(
              onPressed: () async {
                await attendanceProvider.getUserCurrentLocation();
                if (attendanceProvider.currentPosition != null) {
                  attendanceProvider.getAddressFromLatLng(attendanceProvider.currentPosition as Position);
                }
                attendanceProvider.animateMap();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return const PunchBottomSheet();
                    });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                minimumSize: const Size.fromHeight(48),
                side: BorderSide(color: Theme.of(context).colorScheme.onSecondary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // <-- Radius
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "Punch Out",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 6.h,
                  width: 20.w,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: const BorderRadius.all(Radius.circular(20))),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: const BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Attendance Logs",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: SvgPicture.asset(
        "assets/svg/PayDay_logo.svg",
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
