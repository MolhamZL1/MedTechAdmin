import 'package:flutter/material.dart';

import '../../../../../core/functions/Container_decoration.dart';

class CustomInformCard extends StatefulWidget {
  const CustomInformCard({
    super.key,
    required this.text,
    required this.count,
    required this.icon,
    required this.color,
  });
  final String text;
  final num count;
  final Widget icon;
  final Color color;

  @override
  State<CustomInformCard> createState() => _CustomInformCardState();
}

class _CustomInformCardState extends State<CustomInformCard>with SingleTickerProviderStateMixin {
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
          builder: (context, child){
            return Transform.translate(
              offset: Offset(0, -_animation.value),
              child: Container(
                decoration: containerDecoration(),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(widget.text),
                  ),
                  subtitle: Text(
                    widget.count.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(color: widget.color),
                  ),
                  trailing: widget.icon,
                ),
              ),
            );
          }
      ),
    );
  }
}
