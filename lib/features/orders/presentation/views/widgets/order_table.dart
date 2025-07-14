import 'package:flutter/material.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';
import '../../../domain/entities/listInformOrder.dart';
import '../../../domain/entities/order_constant.dart';
import 'GenericPopup.dart';
import 'OrdersTable.dart';



class OrdersTableClean extends StatefulWidget {
  @override
  OrdersTableCleanState createState() => OrdersTableCleanState();
}

class OrdersTableCleanState extends State<OrdersTableClean> {
  final List<Order> orders = getMockOrders();
  PopupData? activePopup;

  void showPopup(PopupType type, Order order) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    setState(() {
      activePopup = PopupData(
        type: type,
        data: order,
        position: Offset(
          position.dx + MediaQuery.of(context).size.width * 0.01,
          position.dy + MediaQuery.of(context).size.height * 0.001,
        ),
      );
    });
  }

  void closePopup() {
    setState(() {
      activePopup = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(Constants.tablePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OrdersTable(
                    orders: orders,
                    onShowPopup: showPopup,
                  ),
                ),
              ],
            ),
          ),
          if (activePopup != null)
            GenericPopup(
              popupData: activePopup!,
              onClose: closePopup,
            ),
        ],
      ),
    );
  }
}