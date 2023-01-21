import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({
    Key? key,
    required this.name,
    required this.value,
    this.nameStyle,
    this.valueStyle,
    this.showDivider = true,
    this.dividerColor,
  }) : super(key: key);

  final String name;
  final String value;

  final TextStyle? nameStyle;
  final TextStyle? valueStyle;

  final bool showDivider;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDivider)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: VerticalDivider(
              color: dividerColor,
            ),
          ),
        if (showDivider)
          SizedBox(
            width: 12.h,
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: nameStyle ?? Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: valueStyle ??
                  Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ],
        ),
      ],
    );
  }
}
