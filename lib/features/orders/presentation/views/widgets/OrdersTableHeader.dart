import 'package:flutter/material.dart';

class OrdersTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Order ID')),
          Expanded(flex: 3, child: Text('Customer')),
          Expanded(flex: 3, child: Text('Products')),
          Expanded(flex: 2, child: Text('Total')),
          Expanded(flex: 2, child: Text('Status')),
          Expanded(flex: 2, child: Text('Date')),
          Expanded(flex: 2, child: Text('Actions')),
        ],
      ),
    );
  }
}
