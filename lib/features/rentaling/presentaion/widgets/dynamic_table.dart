import 'package:flutter/material.dart';
// تأكد من أن هذا المسار صحيح لملف AdaptiveLayout الخاص بك
import 'package:med_tech_admin/core/widgets/AdaptiveLayout.dart';
import '../../domain/table_data.dart';
import '../../utils/constants.dart';
import 'table_header.dart';
import 'table_row.dart';

// الواجهة الرئيسية التي ستقوم بالتبديل بين التصميمين
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

// هذه الفئة تحتوي على كل المنطق المشترك (البيانات، الفرز، إلخ)
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

  void handleSort(String columnKey) {
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
    // استخدام AdaptiveLayout الخاص بك للتبديل بين الواجهات
    return AdaptiveLayout(
      desktopLayout: (context) => _DesktopTableLayout(state: this),
      mobileLayout: (context) => _MobileAndTabletTableLayout(state: this),
      tabletLayout: (context) => _MobileAndTabletTableLayout(state: this),
    );
  }
}

// =======================================================================
// 1. واجهة التصميم الأصلي (للشاشات الكبيرة) - تم تصحيحها
// =======================================================================
class _DesktopTableLayout extends StatelessWidget {
  final _DynamicTableState state;
  const _DesktopTableLayout({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _tableDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // مهم جداً
          children: [
            if (state.widget.tableData.title != null) _buildTitle(),
            // *** بداية التعديل ***
            // تم تغليف المحتوى بـ Flexible و SingleChildScrollView
            // هذا يضمن أن الواجهة تعمل دائماً بغض النظر عن مكان وضعها
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.widget.tableData.showHeader) _buildHeader(),
                    _buildBody(),
                  ],
                ),
              ),
            ),
            // *** نهاية التعديل ***
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    // تم استبدال ListView.builder بـ Column لضمان عدم وجود تضارب في التمرير
    return Column(
      children: state._sortedRows.map((rowData) {
        final index = state._sortedRows.indexOf(rowData);
        return DynamicTableRow(
          columns: state.widget.tableData.columns,
          rowData: rowData,
          index: index,
          onTap: () => state.widget.onRowTap?.call(index),
        );
      }).toList(),
    );
  }

  // --- دوال مساعدة مشتركة ---
  BoxDecoration _tableDecoration() {
    return BoxDecoration(
      color: AppConstants.cardBackground,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      border: state.widget.tableData.showBorder
          ? Border.all(color: AppConstants.borderColor)
          : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Text(
        state.widget.tableData.title!,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeader() {
    return TableHeader(
      columns: state.widget.tableData.columns,
      onSort: state.widget.enableSorting ? state.handleSort : null,
      sortedColumn: state._sortedColumn,
      sortAscending: state._sortAscending,
    );
  }
}

// =======================================================================
// 2. واجهة التصميم المتجاوب (للشاشات الصغيرة والمتوسطة) - لا تغيير هنا
// =======================================================================
class _MobileAndTabletTableLayout extends StatelessWidget {
  final _DynamicTableState state;
  const _MobileAndTabletTableLayout({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _tableDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.widget.tableData.title != null) _buildTitle(),
            Flexible(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state.widget.tableData.showHeader) _buildHeader(),
                        _buildBody(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: state._sortedRows.map((rowData) {
        final index = state._sortedRows.indexOf(rowData);
        return DynamicTableRow(
          columns: state.widget.tableData.columns,
          rowData: rowData,
          index: index,
          onTap: () => state.widget.onRowTap?.call(index),
        );
      }).toList(),
    );
  }

  // --- دوال مساعدة مشتركة ---
  BoxDecoration _tableDecoration() {
    return BoxDecoration(
      color: AppConstants.cardBackground,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      border: state.widget.tableData.showBorder
          ? Border.all(color: AppConstants.borderColor)
          : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Text(
        state.widget.tableData.title!,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeader() {
    return TableHeader(
      columns: state.widget.tableData.columns,
      onSort: state.widget.enableSorting ? state.handleSort : null,
      sortedColumn: state._sortedColumn,
      sortAscending: state._sortAscending,
    );
  }
}
