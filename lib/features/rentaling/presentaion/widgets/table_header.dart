import 'package:flutter/material.dart';
import '../../domain/table_column.dart';
import '../../utils/constants.dart';

class TableHeader extends StatelessWidget {
  final List<TableColumn> columns;
  final Function(String)? onSort;
  final String? sortedColumn;
  final bool sortAscending;

  const TableHeader({
    Key? key,
    required this.columns,
    this.onSort,
    this.sortedColumn,
    this.sortAscending = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.tableHeaderHeight,
      decoration: const BoxDecoration(
        color: AppConstants.primaryBackground,
        border: Border(
          bottom: BorderSide(
            color: AppConstants.borderColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: columns.map((column) => _buildHeaderCell(column)).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(TableColumn column) {
    return Expanded(
      flex: column.width?.toInt() ?? 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
        child: Row(
          mainAxisAlignment: _getMainAxisAlignment(column.alignment),
          children: [
            Text(
              column.title,
              style: TextStyle(
                fontSize: AppConstants.headerFontSize,
                fontWeight: FontWeight.w600,
                color: AppConstants.primaryText,
              ),
            ),
            if (column.sortable) ...[
              const SizedBox(width: 4.0),
              GestureDetector(
                onTap: () => onSort?.call(column.key),
                child: Icon(
                  sortedColumn == column.key
                      ? (sortAscending 
                          ? Icons.keyboard_arrow_up 
                          : Icons.keyboard_arrow_down)
                      : Icons.unfold_more,
                  size: 16.0,
                  color: sortedColumn == column.key
                      ? AppConstants.accentText
                      : AppConstants.secondaryText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  MainAxisAlignment _getMainAxisAlignment(TextAlign alignment) {
    switch (alignment) {
      case TextAlign.left:
        return MainAxisAlignment.start;
      case TextAlign.center:
        return MainAxisAlignment.center;
      case TextAlign.right:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }
}

