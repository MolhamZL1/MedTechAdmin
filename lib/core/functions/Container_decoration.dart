import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/functions/get_container_color.dart';

containerDecoration(context) => BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: getContainerColor(context),
  // border: Border.all(width: 1, color: Colors.grey),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black.withOpacity(0.5)
              : Colors.grey.shade200,
    ),
  ],
);
