import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/SideBarItem.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/SideBarLogoSection.dart';

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
  bool isOpen = true;
  void onToggle() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  List<Map> items = [
    {'icon': Icons.dashboard_outlined, 'title': 'Dashboard'},
    {'icon': Icons.shopping_bag_outlined, 'title': 'Products'},
    {'icon': Icons.receipt_long_outlined, 'title': 'Orders      '},
    {'icon': Icons.event_repeat_outlined, 'title': 'Rentals'},
    {'icon': Icons.build_circle_outlined, 'title': 'Maintenance'},
    {'icon': Icons.people_alt_outlined, 'title': 'Users'},
    {'icon': Icons.attach_money_outlined, 'title': 'Financial'},
    {'icon': Icons.settings_outlined, 'title': 'Settings'},
  ];

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

    if (!isOpen) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder:
          (context, child) => Material(
            elevation: 4,
            child: Container(
              width: _widthAnimation.value,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_widthAnimation.value > 160) SideBarLogoSection(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            splashColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            onTap: onToggle,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Icon(isOpen ? Icons.close : Icons.menu),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
  }
}
