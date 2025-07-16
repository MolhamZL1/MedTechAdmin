import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/orders/presentation/views/widgets/generic_popup/product_section.dart';
import 'package:med_tech_admin/features/orders/presentation/views/widgets/generic_popup/status_section.dart';
import 'package:med_tech_admin/features/orders/presentation/views/widgets/generic_popup/summary_section.dart';
import '../../../../domain/entities/InfomOrder.dart';
import '../../../../domain/entities/PopupType.dart';
import '../_buildDateCell.dart';
import 'customer_section.dart';
import 'date_section.dart';


class PopupContent extends StatelessWidget {
  final PopupData popupData;

  const PopupContent({required this.popupData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = popupData.data as Order;

    switch (popupData.type) {
      case PopupType.customer:
        return CustomerSection(order: order);
      case PopupType.product:
        return ProductSection(order: order);
      case PopupType.status:
        return StatusSection(order: order);
      case PopupType.date:
        return DateSection(order: order,);
      case PopupType.orderSummary:
        return SummarySection(order: order);
    }
  }
}
