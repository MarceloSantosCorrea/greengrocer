import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTileColor;
  final double? textSize;

  const AppNameWidget({
    Key? key,
    this.greenTileColor,
    this.textSize = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Green',
            style: TextStyle(
              color: greenTileColor ?? CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'grocer',
            style: TextStyle(
              color: CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
