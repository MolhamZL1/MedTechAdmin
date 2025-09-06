import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/orders/presentation/views/orders_view.dart';
import 'package:med_tech_admin/features/settings/presentation/views/settings_view.dart';

import '../../Financial/presentaion/views/Financial_view.dart';
import '../../Maintenance/presntation/views/maintenance_view.dart';
import '../../ai chat/presentation/views/ai_chat_view.dart';
import '../../dashboard/presentation/views/dashboard_view.dart';
import '../../products/presentation/views/products_view.dart';
import '../../rentaling/rental_view.dart';
import '../../users/presentation/views/users_view.dart';

List adminPages = [
  DashboardView(),
  ProductsView(),
  OrdersView(),
  RentalView(),
  MaintenanceView(),
  UsersView(),
  FinancialView(),
  SettingsView(),
  Container(width: 200, height: 400, child: AiChatView()),
];
List accountantPages = [
  DashboardView(),
  ProductsView(),
  FinancialView(),
  SettingsView(),
  Container(width: 200, height: 400, child: AiChatView()),
];
List maintenancePages = [
  DashboardView(),
  RentalView(),
  MaintenanceView(),
  FinancialView(),
  SettingsView(),
  Container(width: 200, height: 400, child: AiChatView()),
];
List getPages(String role) {
  if (role == 'ADMIN') {
    return adminPages;
  } else if (role == 'ACCOUNTANT') {
    return accountantPages;
  } else if (role == 'MAINTENANCE') {
    return maintenancePages;
  } else {
    return [];
  }
}

////////////////////////////////////////////
List getitems(String role) {
  if (role == 'ADMIN') {
    return adminitems;
  } else if (role == 'ACCOUNTANT') {
    return accountantPages;
  } else if (role == 'MAINTENANCE') {
    return maintenancePages;
  } else {
    return [];
  }
}

List<Map> accountantitems = [
  {'icon': Icons.dashboard_outlined, 'title': 'Dashboard'},
  {'icon': Icons.shopping_bag_outlined, 'title': 'Products'},
  {'icon': Icons.attach_money_outlined, 'title': 'Financial'},
  {'icon': Icons.settings_outlined, 'title': 'Settings'},
  {'icon': Icons.chat_bubble_outline, 'title': 'Chat'},
];
List<Map> maintenanceitems = [
  {'icon': Icons.dashboard_outlined, 'title': 'Dashboard'},
  {'icon': Icons.event_repeat_outlined, 'title': 'Rentals'},
  {'icon': Icons.build_circle_outlined, 'title': 'Maintenance'},
  {'icon': Icons.attach_money_outlined, 'title': 'Financial'},
  {'icon': Icons.settings_outlined, 'title': 'Settings'},
  {'icon': Icons.chat_bubble_outline, 'title': 'Chat'},
];
List<Map> adminitems = [
  {'icon': Icons.dashboard_outlined, 'title': 'Dashboard'},
  {'icon': Icons.shopping_bag_outlined, 'title': 'Products'},
  {'icon': Icons.receipt_long_outlined, 'title': 'Orders      '},
  {'icon': Icons.event_repeat_outlined, 'title': 'Rentals'},
  {'icon': Icons.build_circle_outlined, 'title': 'Maintenance'},
  {'icon': Icons.people_alt_outlined, 'title': 'Users'},
  {'icon': Icons.attach_money_outlined, 'title': 'Financial'},
  {'icon': Icons.settings_outlined, 'title': 'Settings'},
  {'icon': Icons.chat_bubble_outline, 'title': 'Chat'},
];
