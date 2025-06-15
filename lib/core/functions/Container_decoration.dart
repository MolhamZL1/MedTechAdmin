import 'package:flutter/material.dart';

containerDecoration() => BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: Colors.white,
  border: Border.all(width: 1, color: Colors.grey.shade300),
  boxShadow: [
    BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.grey.shade200),
  ],
);
