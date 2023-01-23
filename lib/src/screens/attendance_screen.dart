import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pay_day/src/components/log_details_bottomsheet.dart';
import 'package:pay_day/src/components/punch_bottomsheet.dart';
import 'package:pay_day/src/components/time_item.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:pay_day/src/utils/time_helper.dart';
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
    Future.delayed(Duration.zero, () async {
      AttendanceProvider attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
      await attendanceProvider.getActiveAttendance();
      attendanceProvider.updateTime();
      attendanceProvider.getIp();
      attendanceProvider.getTodayLogs();
      attendanceProvider.getPosts();
    });
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      if (mounted) {
        AttendanceProvider attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
        timer = Timer.periodic(const Duration(seconds: 60), (Timer t) => attendanceProvider.updateTime());
      }
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
      return ListView(
        physics: const BouncingScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  height: 48.h,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
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
                        mainAxisSize: MainAxisSize.max,
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
                            value: attendanceProvider.outTime ?? '-',
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
                            value: '-${attendanceProvider.remainingHours}h ${attendanceProvider.remainingMinutes}m',
                            valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                            dividerColor: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                OutlinedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const PunchBottomSheet();
                        });
                    await attendanceProvider.getUserCurrentLocation();
                    if (attendanceProvider.currentPosition != null) {
                      attendanceProvider.getAddressFromLatLng(attendanceProvider.currentPosition as Position);
                    }
                    attendanceProvider.animateMap();
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
                        attendanceProvider.attendance != null ? "Punch Out" : "Punch In",
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
                      height: 7.h,
                      width: 22.w,
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: const BorderRadius.all(Radius.circular(20))),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      height: 7.h,
                      width: 7.h,
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
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Today’s logs",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              itemCount: attendanceProvider.todayLogs.length,
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return LogDetailsBottomSheet(
                              index: index,
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${TimeHelper().getTime(attendanceProvider.todayLogs[index].timeIn)} - ${TimeHelper().getTime(attendanceProvider.todayLogs[index].timeOut)}",
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Theme.of(context).unselectedWidgetColor,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(TimeHelper().getDuration(attendanceProvider.todayLogs[index].totalMinutes)),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Icon(
                                  Icons.description_outlined,
                                  color: Theme.of(context).unselectedWidgetColor,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Text("0"),
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.1,
                );
              },
            ),
          ),
        ],
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
