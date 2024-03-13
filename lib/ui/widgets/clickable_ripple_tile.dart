import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ClickableRippleTile extends StatelessWidget {
  final double height;
  final Widget child;
  final Function() onTap;

  const ClickableRippleTile({
    super.key,
    required this.height,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor),
      child: SizedBox(
        height: height,
        child: Ink(
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(8)).r,
            child: child,
          ),
        ),
      ),
    );
  }
}
