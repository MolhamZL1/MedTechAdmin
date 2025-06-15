import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/AdaptiveLayout.dart';
import 'package:med_tech_admin/features/dashboard/presentation/views/DesktopDashboardView.dart';
import 'package:med_tech_admin/features/dashboard/presentation/views/MobileProductsView.dart';
import 'package:med_tech_admin/features/dashboard/presentation/views/TabletProductsView.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Widget build(BuildContext context) {
    return AdaptiveLayout(
      desktopLayout: (context) => DesktopDashboardView(),
      mobileLayout: (context) => MobileDashboardView(),
      tabletLayout: (context) => TabletDashboardView(),
    );
  }
}
