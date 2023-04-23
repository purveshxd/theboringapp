import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyleContainerCustom extends ConsumerWidget {
  final String text;
  const StyleContainerCustom(this.text, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Monospace',
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}
