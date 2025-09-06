import 'package:flutter/material.dart';

class HeaderOrdersView extends StatelessWidget {
  final VoidCallback? onRefresh;

  const HeaderOrdersView({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Orders",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage customers orders and sales",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      // إضافة الزر في خاصية trailing
      trailing: onRefresh != null
          ? IconButton(
        icon: const Icon(Icons.refresh),
        color: Theme.of(context).primaryColor,
        tooltip: 'Refresh Orders',
        onPressed: onRefresh,
      )
          : null, // لا تعرض شيئًا إذا لم يتم تمرير الدالة
    );
  }
}
