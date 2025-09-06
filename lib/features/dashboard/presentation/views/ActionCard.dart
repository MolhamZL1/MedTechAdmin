import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ActionCard extends StatefulWidget {
  final IconData leadingIcon;     // الأيقونة اللي جوة المربع الملون
  final IconData trailingIcon;    // الأيقونة اللي على اليمين
  final String title;             // العنوان
  final String subtitle;          // الوصف
  final Color color;              // اللون الأساسي (للأيقونات و الـ hover)

  const ActionCard({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.subtitle,
    this.color = Colors.blue,     // لون افتراضي (تقدري تغيريه وقت الاستدعاء)
  });

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: _isHovered
            ? widget.color.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: _isHovered ? widget.color : Colors.grey.shade400,
          dashPattern: const [5, 4],
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedScale(
                    scale: _isHovered ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(widget.leadingIcon, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    widget.trailingIcon,
                    color: widget.color,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
