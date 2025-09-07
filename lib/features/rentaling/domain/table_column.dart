import 'dart:ui';

import 'package:flutter/cupertino.dart';

enum ColumnType {
  text,
  currency,
  status,
  action,
  date,
  custom,
}

class TableColumn {
  final String key;
  final String title;
  final ColumnType type;
  final double? width;
  final bool sortable;
  final TextAlign alignment;
  final int? flex;
  final Widget Function(dynamic value)? customBuilder;

  const TableColumn({
    required this.key,
    required this.title,
    this.type = ColumnType.text,
    this.width,
    this.sortable = false,
    this.alignment = TextAlign.left,
    this.customBuilder,
this.flex,
  });

  TableColumn copyWith({
    String? key,
    String? title,
    ColumnType? type,
    double? width,
    bool? sortable,
    TextAlign? alignment,
    Widget Function(dynamic value)? customBuilder,
  }) {
    return TableColumn(
      key: key ?? this.key,
      title: title ?? this.title,
      type: type ?? this.type,
      width: width ?? this.width,
      sortable: sortable ?? this.sortable,
      alignment: alignment ?? this.alignment,
      customBuilder: customBuilder ?? this.customBuilder,
    );
  }
}

