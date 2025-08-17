import 'package:flutter/material.dart';
import '../../domain/table_data.dart';
import '../../utils/constants.dart';
import 'table_header.dart';
import 'table_row.dart';

class DynamicTable extends StatefulWidget {
  final TableData tableData;
  final Function(int)? onRowTap;
  final Function(String)? onSort;
  final bool enableSorting;

  const DynamicTable({
    Key? key,
    required this.tableData,
    this.onRowTap,
    this.onSort,
    this.enableSorting = false,
  }) : super(key: key);

  @override
  State<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
  String? _sortedColumn;
  bool _sortAscending = true;
  late List<Map<String, dynamic>> _sortedRows;

  @override
  void initState() {
    super.initState();
    _sortedRows = List.from(widget.tableData.rows);
  }

  @override
  void didUpdateWidget(DynamicTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tableData.rows != widget.tableData.rows) {
      _sortedRows = List.from(widget.tableData.rows);
      if (_sortedColumn != null) {
        _sortData(_sortedColumn!);
      }
    }
  }

  void _handleSort(String columnKey) {
    if (!widget.enableSorting) return;

    setState(() {
      if (_sortedColumn == columnKey) {
        _sortAscending = !_sortAscending;
      } else {
        _sortedColumn = columnKey;
        _sortAscending = true;
      }
      _sortData(columnKey);
    });

    widget.onSort?.call(columnKey);
  }

  void _sortData(String columnKey) {
    _sortedRows.sort((a, b) {
      final aValue = a[columnKey];
      final bValue = b[columnKey];

      int comparison = 0;
      if (aValue == null && bValue == null) {
        comparison = 0;
      } else if (aValue == null) {
        comparison = -1;
      } else if (bValue == null) {
        comparison = 1;
      } else {
        comparison = aValue.toString().compareTo(bValue.toString());
      }

      return _sortAscending ? comparison : -comparison;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border:
            widget.tableData.showBorder
                ? Border.all(color: AppConstants.borderColor)
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.tableData.title != null) _buildTitle(),
          if (widget.tableData.showHeader) _buildHeader(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Text(
        widget.tableData.title!,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          //   color: AppConstants.primaryText,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return TableHeader(
      columns: widget.tableData.columns,
      onSort: widget.enableSorting ? _handleSort : null,
      sortedColumn: _sortedColumn,
      sortAscending: _sortAscending,
    );
  }

  Widget _buildBody() {
    final maxHeight = widget.tableData.maxHeight;

    Widget body = ListView.builder(
      shrinkWrap: maxHeight == null,
      itemCount: _sortedRows.length,
      itemBuilder: (context, index) {
        return DynamicTableRow(
          columns: widget.tableData.columns,
          rowData: _sortedRows[index],
          index: index,
          onTap: () => widget.onRowTap?.call(index),
        );
      },
    );

    if (maxHeight != null) {
      body = SizedBox(height: maxHeight, child: body);
    }

    return body;
  }
}
