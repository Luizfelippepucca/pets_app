import 'package:flutter/material.dart';

import '../theme/colortheme.dart';

class ProgressBar extends StatelessWidget {
  final int? value;
  final String label;
  const ProgressBar({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: ThemeColor.fontsTheme.headlineMedium,
          ),
          LinearProgressIndicator(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            semanticsLabel: label,
            value: value != null ? value! / (10) * 2 : 0,
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
