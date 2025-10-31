import 'package:flutter/material.dart';

Widget buildSummaryTile(String label, int count, Color color) {
  return Column(
    children: [
      Text(
        "$count",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.black54)),
    ],
  );
}