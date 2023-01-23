import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<AttendanceProvider>(builder: (context, attendanceProvider, child) {
      return ListView.separated(
        itemCount: attendanceProvider.posts.length,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendanceProvider.posts[index].title ?? "",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  attendanceProvider.posts[index].body ?? "",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 0.1,
          );
        },
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
