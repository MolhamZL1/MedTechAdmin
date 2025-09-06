import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/entities/InfoCardEntity.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomInformCard extends StatefulWidget {
  const CustomInformCard({super.key, required this.infoCardEntity});
  final InfoCardEntity infoCardEntity;

  @override
  State<CustomInformCard> createState() => _CustomInformCardState();
}

class _CustomInformCardState extends State<CustomInformCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 15.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_animation.value),
            child: Container(
              //decoration: containerDecoration(context),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.cardColorDark
                    : AppColors.cardColorlight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.cardColorDark
                        : Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(widget.infoCardEntity.text),
                ),
                subtitle: Text(
                  widget.infoCardEntity.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: widget.infoCardEntity.color,
                  ),
                ),
                trailing: widget.infoCardEntity.icon,
              ),
            ),
          );
        },
      ),
    );
  }
}
