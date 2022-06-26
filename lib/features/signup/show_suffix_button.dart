import 'package:flutter/material.dart';

import '../../common/gen/colors.gen.dart';

class SuffixButtonShow extends StatelessWidget {
  const SuffixButtonShow({Key? key, required this.onCliked}) : super(key: key);
  final Function() onCliked;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onCliked,
      style: TextButton.styleFrom(
        shape: const StadiumBorder(),
        primary: ColorName.primary,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: const Text('Show'),
    );
  }
}
