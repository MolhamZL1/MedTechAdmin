import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/orders/presentation/views/orders_view.dart';
import 'package:med_tech_admin/features/settings/presentation/views/settings_view.dart';

import '../../Maintenance/presntation/views/maintenance_view.dart';
import '../../dashboard/presentation/views/dashboard_view.dart';
import '../../products/presentation/views/products_view.dart';
import '../../rentaling/rental_view.dart';
import '../../users/presentation/views/users_view.dart';

List pages = [DashboardView(), ProductsView(), OrdersView(), RentalView(),MaintenanceView(),UsersView(),SettingsView()];

List<Map> items = [
  {'icon': Icons.dashboard_outlined, 'title': 'Dashboard'},
  {'icon': Icons.shopping_bag_outlined, 'title': 'Products'},
  {'icon': Icons.receipt_long_outlined, 'title': 'Orders      '},
   {'icon': Icons.event_repeat_outlined, 'title': 'Rentals'},
  {'icon': Icons.build_circle_outlined, 'title': 'Maintenance'},
   {'icon': Icons.people_alt_outlined, 'title': 'Users'},
  // {'icon': Icons.attach_money_outlined, 'title': 'Financial'},
  {'icon': Icons.settings_outlined, 'title': 'Settings'},
];
