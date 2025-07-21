import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/get_container_color.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/CustomIconButton.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/SideBarItem.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/SideBarLogoSection.dart';

import '../../../../data/pages.dart';
import '../../../cubits/cubit/sidebar_cubit_cubit.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _widthAnimation = Tween<double>(
      begin: 250.0,
      end: 70.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, bool>(
      builder: (context, isOpen) {
        if (isOpen) {
          _controller.reverse();
        } else {
          _controller.forward();
        }

        return AnimatedBuilder(
          animation: _widthAnimation,
          builder:
              (context, child) => Material(
                elevation: 8,
                child: Container(
                  width: _widthAnimation.value,
                  color: getContainerColor(context),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_widthAnimation.value > 160)
                              SideBarLogoSection(),
                            CustomIconButton(
                              icon: isOpen ? Icons.close : Icons.menu,
                              onTap:
                                  () =>
                                      context
                                          .read<SidebarCubit>()
                                          .toggleSidebar(),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 0, thickness: .3, color: Colors.grey),
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder:
                              (context, index) => SideBarItem(
                                title: items[index]["title"],
                                icon: items[index]["icon"],
                                isSelected: index == widget.selectedIndex,
                                onTap: () => widget.onItemSelected(index),
                                widthAnimation: _widthAnimation,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
