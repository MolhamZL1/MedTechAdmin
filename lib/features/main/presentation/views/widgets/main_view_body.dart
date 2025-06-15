import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/CustomIconButton.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/Header.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/sidebar.dart';
import 'package:med_tech_admin/features/products/presentation/views/products_view.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  int selectedIndex = 0;
  List pages = [DashboardView(), ProductsView()];

  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Sidebar(selectedIndex: selectedIndex, onItemSelected: onItemSelected),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: Header()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: pages[selectedIndex],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
