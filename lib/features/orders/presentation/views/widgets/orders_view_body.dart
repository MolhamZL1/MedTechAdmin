import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/orders/domain/order_data.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../rentaling/data/sample_data.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import 'HeaderOrdersView.dart';
import 'InformCardList.dart';
import 'OrdersTable.dart';
import 'order_table.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  late TableData tableData;

  @override
  void initState() {
    super.initState();
    tableData = SampleDataa.getOrderTableData();
  }

  void _handleRowTap(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped row $index'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleSort(String columnKey) {
    print('Sorting by: $columnKey');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderOrdersView(),
            SizedBox(height: 24),
            InformCardList(entities: orderslistinfo),
            SizedBox(height: 24),
            DynamicTable(
              tableData: tableData,
              onRowTap: _handleRowTap,
              onSort: _handleSort,
              enableSorting: true,
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
