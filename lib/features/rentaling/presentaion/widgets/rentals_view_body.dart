import 'package:flutter/material.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../data/sample_data.dart';
import '../../domain/table_data.dart';
import 'dynamic_table.dart';
import 'HeaderRentalView.dart';


class RentalViewBody extends StatefulWidget {
  const RentalViewBody({super.key});

  @override
  State<RentalViewBody> createState() => _RentalViewBodyState();
}

class _RentalViewBodyState extends State<RentalViewBody> {
  late TableData tableData;
  @override
  void initState() {
    super.initState();
  }
  void didChangeDependencies() {
    super.didChangeDependencies();
    tableData = SampleData.getRentalTableData(context);
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
            HeaderRentalsView(),
            SizedBox(height: 24),
            InformCardList(entities: Rentalslistinfo),
            SizedBox(height: 24),
            DynamicTable(
              tableData: tableData,
              onRowTap: _handleRowTap,
              onSort: _handleSort,
              enableSorting: true,
            ),
          ],
        ),
      ),
    );
  }
}
