import 'package:flutter/material.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import 'HeaderOrdersView.dart';
import 'InformCardList.dart';
import 'OrdersTable.dart';
import 'order_table.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

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
            SizedBox(height: 700, child: OrdersTableClean()),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
