import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return SafeArea(
        child: Center(
          child: Material(
            color: backgroundColor,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: backgroundColor,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        ),
      );
    }
  }
}

Future<T> showFloatingModalBottomSheet<T>(
    {required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    bool? enableDrag,
    bool? isDismissible}) async {
  final result = await showCustomModalBottomSheet(
      isDismissible: isDismissible ?? true,
      enableDrag: enableDrag ?? true,
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => FloatingModal(
            child: child,
          ),
      expand: false);

  return result;
}
