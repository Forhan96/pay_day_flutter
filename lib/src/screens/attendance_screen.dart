import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<AttendanceProvider>(builder: (context, attendanceProvider, child) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
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
                    SizedBox(),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "In",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                      SizedBox(),
                      Text(
                        attendanceProvider.inTime ?? '-',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalDivider(),
                      SizedBox(
                        width: 20.h,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Out",
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                          SizedBox(),
                          Text(
                            '11:00',
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalDivider(),
                      SizedBox(
                        width: 20.h,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balance",
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                          SizedBox(),
                          Text(
                            '-2h 39m',
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                attendanceProvider.updateTime();
              },
              child: Text("try"),
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
