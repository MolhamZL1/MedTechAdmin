import 'table_column.dart';

class TableData {
  final List<TableColumn> columns;
  final List<Map<String, dynamic>> rows;
  final String? title;
  final bool showHeader;
  final bool showBorder;
  final double? maxHeight;

  const TableData({
    required this.columns,
    required this.rows,
    this.title,
    this.showHeader = true,
    this.showBorder = true,
    this.maxHeight,
  });

  TableData copyWith({
    List<TableColumn>? columns,
    List<Map<String, dynamic>>? rows,
    String? title,
    bool? showHeader,
    bool? showBorder,
    double? maxHeight,
  }) {
    return TableData(
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
      title: title ?? this.title,
      showHeader: showHeader ?? this.showHeader,
      showBorder: showBorder ?? this.showBorder,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  // إضافة صف جديد
  TableData addRow(Map<String, dynamic> row) {
    return copyWith(
      rows: [...rows, row],
    );
  }

  // إضافة عمود جديد
  TableData addColumn(TableColumn column) {
    return copyWith(
      columns: [...columns, column],
    );
  }

  // تحديث صف
  TableData updateRow(int index, Map<String, dynamic> newRow) {
    if (index < 0 || index >= rows.length) return this;
    
    final updatedRows = List<Map<String, dynamic>>.from(rows);
    updatedRows[index] = newRow;
    
    return copyWith(rows: updatedRows);
  }

  // حذف صف
  TableData removeRow(int index) {
    if (index < 0 || index >= rows.length) return this;
    
    final updatedRows = List<Map<String, dynamic>>.from(rows);
    updatedRows.removeAt(index);
    
    return copyWith(rows: updatedRows);
  }
}

