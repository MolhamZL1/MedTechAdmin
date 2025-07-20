import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/table_column.dart';
import '../../utils/constants.dart';
import 'status_badge.dart';
import 'action_button.dart';

class DynamicTableRow extends StatelessWidget {
  final List<TableColumn> columns;
  final Map<String, dynamic> rowData;
  final int index;
  final VoidCallback? onTap;

  const DynamicTableRow({
    Key? key,
    required this.columns,
    required this.rowData,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppConstants.tableRowHeight,
        decoration: BoxDecoration(
          color: index.isEven 
              ? AppConstants.cardBackground 
              : AppConstants.primaryBackground.withOpacity(0.3),
          border: const Border(
            bottom: BorderSide(
              color: AppConstants.borderColor,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: columns.map((column) => _buildCell(column)).toList(),
        ),
      ),
    );
  }

  Widget _buildCell(TableColumn column) {
    final value = rowData[column.key];
    
    return Expanded(
      flex: column.width?.toInt() ?? 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
        child: _buildCellContent(column, value),
      ),
    );
  }

  Widget _buildCellContent(TableColumn column, dynamic value) {
    if (column.customBuilder != null) {
      return column.customBuilder!(value);
    }

    switch (column.type) {
      case ColumnType.status:
        return _buildStatusCell(value);
      case ColumnType.action:
        return _buildActionCell(value);
      case ColumnType.currency:
        return _buildCurrencyCell(value, column.alignment);
      case ColumnType.date:
        return _buildDateCell(value, column.alignment);
      default:
        return _buildTextCell(value, column.alignment);
    }
  }

  Widget _buildTextCell(dynamic value, TextAlign alignment) {
    return Align(
      alignment: _getAlignment(alignment),
      child: Text(
        value?.toString() ?? '',
        style: const TextStyle(
          fontSize: AppConstants.bodyFontSize,
          color: AppConstants.primaryText,
        ),
        textAlign: alignment,
      ),
    );
  }

  Widget _buildCurrencyCell(dynamic value, TextAlign alignment) {
    return Align(
      alignment: _getAlignment(alignment),
      child: Text(
        value?.toString() ?? '',
        style: const TextStyle(
          fontSize: AppConstants.bodyFontSize,
          color: AppColors.error,
          fontWeight: FontWeight.w600,
        ),
        textAlign: alignment,
      ),
    );
  }

  Widget _buildDateCell(dynamic value, TextAlign alignment) {
    return Align(
      alignment: _getAlignment(alignment),
      child: Text(
        value?.toString() ?? '',
        style: const TextStyle(
          fontSize: AppConstants.smallFontSize,
          color: AppConstants.secondaryText,
        ),
        textAlign: alignment,
      ),
    );
  }

  Widget _buildStatusCell(dynamic value) {
    if (value is String) {
      return StatusBadgeBuilder.buildFromString(value);
    }
    return const SizedBox.shrink();
  }

  Widget _buildActionCell(dynamic value) {
    if (value is List<ActionButton>) {
      return ActionButtonGroup(buttons: value);
    } else if (value is ActionButton) {
      return value;
    }
    return const SizedBox.shrink();
  }

  Alignment _getAlignment(TextAlign alignment) {
    switch (alignment) {
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}

