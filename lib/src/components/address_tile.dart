import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    Key? key,
    required this.icon,
    required this.name,
    required this.value,
  }) : super(key: key);
  final IconData icon;
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 320.w,
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ],
    );
  }
}
