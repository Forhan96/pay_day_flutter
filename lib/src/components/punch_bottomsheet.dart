import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_day/src/components/address_tile.dart';
import 'package:pay_day/src/components/time_item.dart';
import 'package:pay_day/src/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class PunchBottomSheet extends StatelessWidget {
  const PunchBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    return Consumer<AttendanceProvider>(builder: (context, attendanceProvider, child) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
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
                  SizedBox(),
                  Text(
                    'Punch In',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear),
                  ),
                  // Icon(Icons.clear),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeItem(
                          name: 'In',
                          value: '-',
                          valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                          showDivider: false,
                        ),
                        TimeItem(
                          name: 'Out',
                          value: '11:00',
                          valueStyle: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TimeItem(
                          name: 'Total',
                          value: '-2h 39m',
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
                    "Note (optional)",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextField(
                    controller: noteController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).unselectedWidgetColor, width: 0.5),
                      ),
                      // filled: true,
                      // fillColor: Theme.of(context).primaryColor,
                      hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).dividerColor.withOpacity(0.3),
                          ),
                      errorStyle: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold, fontSize: 10),
                      hintText: "Add note here",
                      // errorText: widget.errorText,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                      height: 170.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target:
                                    LatLng(attendanceProvider.currentPosition?.latitude ?? 37.42796133580664, attendanceProvider.currentPosition?.longitude ?? -122.085749655962),
                                zoom: 17,
                              ),
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              onMapCreated: (controller) {
                                attendanceProvider.mapController = controller;
                              },
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () async {
                                await attendanceProvider.getUserCurrentLocation();
                                attendanceProvider.animateMap();
                                if (attendanceProvider.currentAddress != null) {
                                  attendanceProvider.getAddressFromLatLng(attendanceProvider.currentPosition as Position);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                child: Icon(
                                  Icons.my_location_outlined,
                                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 24.h,
                  ),
                  AddressTile(icon: Icons.my_location_outlined, name: "My Location", value: attendanceProvider.currentAddress ?? "N/A"),
                  SizedBox(
                    height: 12.h,
                  ),
                  AddressTile(icon: Icons.location_on_outlined, name: "IP Address", value: attendanceProvider.ip ?? "N/A"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Punch In"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
