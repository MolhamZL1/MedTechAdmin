import 'package:flutter/material.dart';
import '../../../../../core/entities/InfoCardEntity.dart';
import 'HeaderOrdersView.dart';
import 'InformCardList.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderOrdersView(),
        SizedBox(height: 24),
        InformCardList(entities: orderslistinfo),
        SizedBox(height: 24),

        SizedBox(height: 24),
      ],
    );
  }
}
