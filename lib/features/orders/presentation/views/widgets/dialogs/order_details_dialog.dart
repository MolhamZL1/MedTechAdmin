// انسخ هذا الكود بالكامل والصقه في ملف dialogs/order_details_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../../rentaling/utils/constants.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../cubits/cubit.dart';
import 'customer_info_section.dart';
import 'order_timeline_section.dart';

class OrderDetailsDialog extends StatelessWidget {
  final OrderEntity order;
  static final List<String> orderStatuses = [
    "PENDING",
    "PAID",
    "CONFIRMED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
    "RETURNED",
  ];

  // --- ✅ التعديل الوحيد هنا: جعل الدالة آمنة ضد القيم الفارغة ---
  StatusType _mapStatusToType(String? status) { // تم تغيير String إلى String?
    switch (status?.toUpperCase()) { // تم إضافة ?. للوصول الآمن
      case 'PENDING':
        return StatusType.pending;
      case 'PAID':
        return StatusType.paid;
      case 'CONFIRMED':
        return StatusType.confirmed;
      case 'SHIPPED':
        return StatusType.shipped;
      case 'DELIVERED':
        return StatusType.delivered;
      case 'CANCELLED':
        return StatusType.cancelled;
      case 'RETURNED':
        return StatusType.returned;
      default:
        return StatusType.unknown; // حالة افتراضية
    }
  }

  const OrderDetailsDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  static Future<void> show(BuildContext context, OrderEntity order) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Order Details',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return OrderDetailsDialog(order: order);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'ORD-${order.id.toString().padLeft(3, '0')}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppConstants.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: AppConstants.secondaryText,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusSection(),
        const SizedBox(height: 24.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomerInfoSection(order: order),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: _buildOrderSummarySection(),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        RentalTimelineSection(order: order),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Row(
      children: [
        StatusBadge(
          status: _mapStatusToType(order.status),
        ),
        const SizedBox(width: 12.0),
        Text(
          'Order Date: ${_formatDate(order.createdAt)}',
          style: const TextStyle(
            fontSize: 14.0,
            color: AppConstants.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 20.0,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          color: Color.lerp(Color(0xFF6B7280), Colors.white, 0.9),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ...order.items.map((item) => _buildOrderItemRow(item)).toList(),
              const SizedBox(height: 12.0),
              const SizedBox(height: 12.0),
              _buildSummaryRow('Total:', '\$${order.totalAmount}', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemRow(OrderItemEntity item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.production_quantity_limits_sharp),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.nameEn,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  'Quantity: ${item.quantity}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: AppConstants.secondaryText,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: AppColors.textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.0 : 14.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }


  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
