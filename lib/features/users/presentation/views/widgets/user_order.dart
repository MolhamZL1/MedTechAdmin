import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import '../../../../orders/domain/entities/order_entity.dart';

class UserOrdersDialog {
  static void showOrdersDialog({
    required BuildContext context,
    required List<OrderEntity> orders,
    required String username,
  }) {
    if (orders.isEmpty) {
      _showNoOrdersDialog(context: context, username: username);
    } else {
      _showOrdersListDialog(context: context, orders: orders, username: username);
    }
  }

  static void _showNoOrdersDialog({
    required BuildContext context,
    required String username,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'No Orders Found',
      desc: 'No orders found for user: $username',
      btnOkOnPress: () {},
      width: 400, // تم تعديل العرض ليكون مناسباً
      headerAnimationLoop: false,
      customHeader: Container(
        height: 120,
        width: 120,
        decoration: const BoxDecoration(
          color: AppColors.dialogHeaderColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 60,
            color: AppColors.dialogIconColor,
          ),
        ),
      ),
    ).show();
  }

  static void _showOrdersListDialog({
    required BuildContext context,
    required List<OrderEntity> orders,
    required String username,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.cardColorDark
                  : AppColors.cardColorlight,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Orders for $username',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${orders.length} order(s) found',
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(order, index, context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildOrderCard(OrderEntity order, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardColorDark
            : AppColors.cardColorlight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightGrey
              : AppColors.textColor,
          width: 1,
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.all(20),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getStatusColor(order.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '#${order.id}',
              style: TextStyle(
                color: _getStatusColor(order.status),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(order.createdAt),
                    style: const TextStyle(color: AppColors.darkGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status,
                style: const TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Icon(Icons.attach_money, size: 16, color: AppColors.statusDelivered),
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: AppColors.statusDelivered,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.shopping_cart, size: 16, color: AppColors.darkGrey),
              const SizedBox(width: 4),
              Text(
                '${order.items.length} item(s)',
                style: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
              ),
            ],
          ),
        ),
        children: [_buildOrderDetails(order, context)],
      ),
    );
  }

  static Widget _buildOrderDetails(OrderEntity order, BuildContext context) {
    // --- ✅ التعديل الأول: التحقق من العنوان بطريقة آمنة ---
    final hasAddress = order.shippingAddress != null && order.shippingAddress!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasAddress) ...[
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.statusConfirmed, size: 20),
              const SizedBox(width: 8),
              Text('Shipping Address:', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              order.shippingAddress!, // هنا آمن لأننا تحققنا منه في hasAddress
              style: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            const Icon(Icons.inventory_2, color: AppColors.statusPending, size: 20),
            const SizedBox(width: 8),
            Text('Order Items:', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 12),
        if (order.items.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'No items in this order',
                style: TextStyle(color: AppColors.darkGrey, fontStyle: FontStyle.italic),
              ),
            ),
          )
        else
          ...order.items.map((item) => _buildOrderItem(item, context)).toList(),
      ],
    );
  }

  static Widget _buildOrderItem(dynamic item, BuildContext context) {
    final isRent = item.transactionType == 'RENT';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.cardColorDark
                : Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardColorDark
            : AppColors.cardColorlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.mediumGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: AppColors.darkGrey, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.nameEn ?? 'Unknown Product',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // --- ✅ التعديل الثاني: التحقق من الاسم العربي بطريقة آمنة ---
                if (item.product?.nameAr != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.product.nameAr, // لا حاجة لـ '!' بعد الآن
                    style: const TextStyle(color: AppColors.darkGrey, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isRent
                            ? AppColors.statusShipped.withOpacity(0.1)
                            : AppColors.statusDelivered.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.transactionType,
                        style: TextStyle(
                          color: isRent ? AppColors.statusShipped : AppColors.statusDelivered,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Qty: ${item.quantity}',
                      style: const TextStyle(color: AppColors.darkGrey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${item.priceAtTimeOfTransaction.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusDelivered),
              ),
              // --- ✅ التعديل الثالث: التحقق من تواريخ الإيجار بطريقة آمنة ---
              if (isRent && item.rentalStartDate != null && item.rentalEndDate != null) ...[
                const SizedBox(height: 4),
                const Text('Rental Period',
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 10)),
                Text(
                  '${_formatDate(item.rentalStartDate!)} - ${_formatDate(item.rentalEndDate!)}', // هنا '!' آمنة
                  style: const TextStyle(color: AppColors.darkGrey, fontSize: 10),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return AppColors.statusPending;
      case 'CONFIRMED':
        return AppColors.statusConfirmed;
      case 'SHIPPED':
        return AppColors.statusShipped;
      case 'DELIVERED':
        return AppColors.statusDelivered;
      case 'CANCELLED':
        return AppColors.statusCancelled;
      default:
        return AppColors.statusDefault;
    }
  }

  static String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
