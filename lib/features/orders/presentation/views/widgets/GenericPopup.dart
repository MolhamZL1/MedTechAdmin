import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';

import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';


class GenericPopup extends StatelessWidget {
  final PopupData popupData;
  final VoidCallback onClose;

  const GenericPopup({
    Key? key,
    required this.popupData,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _calculateLeft(context),
      top: _calculateTop(context),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 400,
            maxHeight: 300,
          ),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16),
              Flexible(child: _buildContent()),
              SizedBox(height: 16),
              _buildCloseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    IconData icon;
    String title;
    Color color;

    switch (popupData.type) {
      case PopupType.customer:
        icon = Icons.person;
        title = 'Customer Information';
        color = AppColors.primary;
        break;
      case PopupType.product:
        icon = Icons.inventory;
        title = 'Product Details';
        color = AppColors.success;
        break;
      case PopupType.status:
        icon = Icons.info;
        title = 'Order Status';
        color = AppColors.warning;
        break;
      case PopupType.date:
        icon = Icons.calendar_today;
        title = 'Date Information';
        color = AppColors.error;
        break;
      case PopupType.orderSummary:
        icon = Icons.receipt;
        title = 'Order Summary';
        color = AppColors.primary;
        break;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: onClose,
          icon: Icon(Icons.close, size: 18),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    final order = popupData.data as Order;

    switch (popupData.type) {
      case PopupType.customer:
        return _buildCustomerContent(order);
      case PopupType.product:
        return _buildProductContent(order);
      case PopupType.status:
        return _buildStatusContent(order);
      case PopupType.date:
        return _buildDateContent(order);
      case PopupType.orderSummary:
        return _buildOrderSummaryContent(order);
    }
  }

  Widget _buildCustomerContent(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.person, 'Name', order.customerName),
        _buildInfoRow(Icons.business, 'Organization', order.customerCity),
        _buildInfoRow(Icons.email, 'Email', order.customerEmail),
        _buildInfoRow(Icons.phone, 'Phone', order.customerPhone),
        _buildInfoRow(Icons.location_on, 'Address', order.customerAddress),
      ],
    );
  }

  Widget _buildProductContent(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.inventory, 'Product', order.productName),
        _buildInfoRow(Icons.numbers, 'Quantity', order.productQuantity.toString()),
        _buildInfoRow(Icons.attach_money, 'Unit Price', '\$${order.productPrice.toStringAsFixed(2)}'),
        _buildInfoRow(Icons.calculate, 'Total', '\$${order.total.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildStatusContent(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.info, 'Current Status', order.status),
        _buildInfoRow(Icons.calendar_today, 'Order Date', order.orderDate),
        _buildInfoRow(Icons.local_shipping, 'Estimated Delivery', order.estimatedDelivery),
        _buildInfoRow(Icons.payment, 'Payment Method', order.paymentMethod),
      ],
    );
  }

  Widget _buildDateContent(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.event, 'Order Date', order.orderDate),
        _buildInfoRow(Icons.schedule, 'Estimated Delivery', order.estimatedDelivery),
        _buildInfoRow(Icons.access_time, 'Processing Time', _calculateProcessingTime(order)),
      ],
    );
  }

  Widget _buildOrderSummaryContent(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(Icons.receipt, 'Order ID', order.orderId),
        _buildInfoRow(Icons.attach_money, 'Total Amount', '\$${order.total.toStringAsFixed(2)}'),
        _buildInfoRow(Icons.info, 'Status', order.status),
        _buildInfoRow(Icons.payment, 'Payment', order.paymentMethod),
        if (order.notes.isNotEmpty)
          _buildInfoRow(Icons.note, 'Notes', order.notes),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Color(0xFF6B7280)),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onClose,
        child: Text('Close'),
        style: TextButton.styleFrom(
          foregroundColor:AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }

  String _calculateProcessingTime(Order order) {
    // Simple calculation for demo purposes
    try {
      final orderDate = DateTime.parse(order.orderDate);
      final deliveryDate = DateTime.parse(order.estimatedDelivery);
      final difference = deliveryDate.difference(orderDate).inDays;
      return '$difference days';
    } catch (e) {
      return 'N/A';
    }
  }

  double _calculateLeft(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final popupWidth = 400.0;

    double left = popupData.position.dx;

    // Ensure popup doesn't go off screen
    if (left + popupWidth > screenWidth) {
      left = screenWidth - popupWidth - 20;
    }

    if (left < 20) {
      left = 20;
    }

    return left;
  }

  double _calculateTop(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final popupHeight = 300.0;

    double top = popupData.position.dy - popupHeight / 2;

    // Ensure popup doesn't go off screen
    if (top + popupHeight > screenHeight) {
      top = screenHeight - popupHeight - 20;
    }

    if (top < 20) {
      top = 20;
    }

    return top;
  }
}

