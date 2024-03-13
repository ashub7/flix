import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/ui/widgets/clickable_ripple_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ImagePickerModal extends StatelessWidget {
  final bool showRemoveOption;

  const ImagePickerModal({super.key, required this.showRemoveOption});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              12.verticalSpaceFromWidth,
              ClickableRippleTile(
                  height: 50,
                  onTap: () {
                    context.pop(context.loc.capture_now);
                  },
                  child: Row(
                    children: [
                      6.horizontalSpace,
                       Icon(Icons.camera_alt_outlined,
                        color: context.colorScheme.onBackground,),
                      10.horizontalSpace,
                      Text(context.loc.capture_now)
                    ],
                  )),
              6.verticalSpaceFromWidth,
              ClickableRippleTile(
                  height: 50,
                  onTap: () {
                    context.pop(context.loc.pick_gallery);
                  },
                  child: Row(
                    children: [
                      6.horizontalSpace,
                       Icon(Icons.browse_gallery_outlined,
                      color: context.colorScheme.onBackground,),
                      10.horizontalSpace,
                      Text(context.loc.pick_gallery)
                    ],
                  )),
              if (showRemoveOption) ...{
                6.verticalSpaceFromWidth,
                ClickableRippleTile(
                    height: 50,
                    onTap: () {
                      context.pop(context.loc.remove_image);
                    },
                    child: Row(
                      children: [
                        6.horizontalSpace,
                         Icon(Icons.delete_outline,
                          color: context.colorScheme.onBackground,),
                        10.horizontalSpace,
                        Text(context.loc.remove_image)
                      ],
                    ))
              },
              20.verticalSpaceFromWidth,
            ],
          ),
        )
      ],
    );
  }
}
