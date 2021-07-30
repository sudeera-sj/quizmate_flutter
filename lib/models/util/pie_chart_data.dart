import 'package:flutter/material.dart';

/// Represents an entry in a pie chart.
class PieChartData {
  final String xValue;
  final int yValue;
  final Color colorValue;

  const PieChartData(this.xValue, this.yValue, this.colorValue);
}
