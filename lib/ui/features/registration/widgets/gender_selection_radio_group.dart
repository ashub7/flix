import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelectionRadioGroup extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onSelected;
  const GenderSelectionRadioGroup({super.key, this.selectedIndex = 0, required this.onSelected});

  @override
  State<GenderSelectionRadioGroup> createState() => _GenderSelectionRadioGroupState();
}

class _GenderSelectionRadioGroupState extends State<GenderSelectionRadioGroup> {
  int selected = 0;
  @override
  void initState() {
    selected = widget.selectedIndex;
    super.initState();
  }

  _onRadioStateChanged(int index){
    widget.onSelected(index);
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(context.loc.gender),
        10.horizontalSpace,
        Row(
          children: [
            Radio<int>(value: 0, groupValue: selected, onChanged: (value) {
              _onRadioStateChanged(0);
            },),
            Text(context.loc.male, style: context.bodyMedium,),
          ],
        ),
        Row(
          children: [
            Radio<int>(value: 1, groupValue: selected, onChanged: (value) {
              _onRadioStateChanged(1);
            },),
            Text(context.loc.female, style: context.bodyMedium,),
          ],
        )
      ],
    );
  }
}
