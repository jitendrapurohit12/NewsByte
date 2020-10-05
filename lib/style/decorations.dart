import 'package:flutter/material.dart';

BoxDecoration kImageOverlayDecoration({double radius = 8.0}) => BoxDecoration(
      borderRadius: getRadius(radius: radius),
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.black,
          Colors.transparent,
        ],
      ),
    );

BorderRadius getRadius({double radius = 8.0}) => BorderRadius.circular(radius);

RoundedRectangleBorder imageCardShape = RoundedRectangleBorder(
  borderRadius: getRadius(),
);
