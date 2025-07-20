import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/orders/domain/order_data.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../../rentaling/data/sample_data.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import '../../../Data/sample_user_data.dart';
import 'HeaderUserView.dart';
class UserViewBody extends StatefulWidget {
  const UserViewBody({super.key});

  @override
  State<UserViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<UserViewBody> {
  late TableData tableData;

  @override
  void initState() {
    super.initState();
    // سيتم تحديث tableData في didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tableData = SampleUserData.getUserTableData();
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
            HeaderUsersView(),
            SizedBox(height: 24),
            InformCardList(entities: Userslistinfo),
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
