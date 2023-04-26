import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyleContainerCustom extends StatelessWidget {
  final String text;
  final widget;
  const StyleContainerCustom(this.text, {super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: text == ""
            ? Center(
                child: widget,
              )
            : SelectableText(
                text,
                style: const TextStyle(
                  fontFamily: 'Monospace',
                  fontSize: 14,
                  color: Colors.black87,
                ), 
              ));
  }
}
