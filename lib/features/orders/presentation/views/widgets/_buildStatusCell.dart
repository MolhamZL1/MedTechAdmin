import 'package:flutter/cupertino.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';
import '_buildStatusChip.dart';

class StatusCell extends StatelessWidget {
final Order order;
final Function(PopupType, Order) onShowPopup;

StatusCell({required this.order, required this.onShowPopup});

@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: () => onShowPopup(PopupType.status, order),
child: StatusChip(status: order.status),
);

}}