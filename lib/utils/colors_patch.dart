import 'package:flutter/material.dart';

stringToColour(String hexColour) {
  hexColour = hexColour.toUpperCase().replaceAll("#", "");
  if (hexColour.length == 6) {
    hexColour = "FF" + hexColour;
  }
  return Color(int.parse(hexColour, radix: 16));
}
