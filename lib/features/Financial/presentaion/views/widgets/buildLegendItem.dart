import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/sample_data.dart';

Widget buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF718096),
        ),
      ),
    ],
  );
}
List<BarChartGroupData> buildBarGroups() {
  return sampleData.monthlyData.asMap().entries.map((entry) {
    final index = entry.key;
    final data = entry.value;

    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: data['sales'].toDouble(),
          color: const Color(0xFF2196F3),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
        BarChartRodData(
          toY: data['rentals'].toDouble(),
          color: const Color(0xFF4CAF50),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
        BarChartRodData(
          toY: data['maintenance'].toDouble(),
          color: const Color(0xFFFF9800),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
        BarChartRodData(
          toY: data['expenses'].toDouble(),
          color: const Color(0xFFF44336),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
        ),
      ],
      barsSpace: 2,
    );
  }).toList();
}