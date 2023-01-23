import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_day/src/components/address_tile.dart';
import 'package:pay_day/src/components/time_item.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:pay_day/src/utils/time_helper.dart';
import 'package:provider/provider.dart';

class LogDetailsBottomSheet extends StatelessWidget {
  final int index;
  const LogDetailsBottomSheet({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(builder: (context, attendanceProvider, child) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.88,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Log Details",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  // Icon(Icons.clear),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TimeHelper().getDate(attendanceProvider.todayLogs[index].timeIn),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                            ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          'Regular',
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Auto",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        // color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeItem(
                          name: 'In',
                          value: TimeHelper().getTime(attendanceProvider.todayLogs[index].timeIn),
                          valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                          showDivider: false,
                        ),
                        TimeItem(
                          name: 'Out',
                          value: TimeHelper().getTime(attendanceProvider.todayLogs[index].timeOut),
                          valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TimeItem(
                          name: 'Total',
                          value: TimeHelper().getDuration(attendanceProvider.todayLogs[index].totalMinutes!),
                          valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Punch In",
                    style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    attendanceProvider.posts[index].body ?? "N/A",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  AddressTile(icon: Icons.my_location_outlined, name: "My Location", value: attendanceProvider.todayLogs[index].addressIn ?? "N/A"),
                  SizedBox(
                    height: 12.h,
                  ),
                  AddressTile(icon: Icons.location_on_outlined, name: "IP Address", value: attendanceProvider.todayLogs[index].ipIn ?? "N/A"),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Punch Out",
                    style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    attendanceProvider.posts[index].body ?? "N/A",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  AddressTile(icon: Icons.my_location_outlined, name: "My Location", value: attendanceProvider.todayLogs[index].addressOut ?? "N/A"),
                  SizedBox(
                    height: 12.h,
                  ),
                  AddressTile(icon: Icons.location_on_outlined, name: "IP Address", value: attendanceProvider.todayLogs[index].ipOut ?? "N/A"),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
