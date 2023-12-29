import 'package:flutter/material.dart';
import 'package:theboringapp/constants/constants.dart';

class StyleContainerCustom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isSaved;
  final Widget? widget;
  const StyleContainerCustom(this.text,
      {super.key, this.widget, this.onPressed, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: containerColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: text == ""
            ? Center(
                child: widget,
              )
            : ListTile(
                trailing: isSaved
                    ? IconButton.filledTonal(
                        onPressed: onPressed,
                        icon: const Icon(Icons.check_rounded),
                      )
                    : null,
                title: SelectableText(
                  text,
                  style: TextStyle(
                    fontFamily: 'Monospace',
                    fontSize: 14,
                    color: activityTextColor,
                  ),
                ),
              ));
  }
}
