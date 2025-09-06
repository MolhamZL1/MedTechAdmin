import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../utils/constants.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final bool isOutlined;

  const ActionButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.isOutlined = true, required String tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;
    
    return SizedBox(
      height: 32.0,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon != null 
                  ? Icon(icon, size: 16.0, color: buttonColor)
                  : const SizedBox.shrink(),
              label: Text(
                text,
                style: TextStyle(
                  color: buttonColor,
                  fontSize: AppConstants.smallFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: buttonColor.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon != null 
                  ? Icon(icon, size: 16.0, color: Colors.white)
                  : const SizedBox.shrink(),
              label: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppConstants.smallFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
    );
  }
}

class ActionButtonGroup extends StatelessWidget {
  final List<ActionButton> buttons;
  final MainAxisAlignment alignment;

  const ActionButtonGroup({
    Key? key,
    required this.buttons,
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: buttons
          .map((button) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: button,
              ))
          .toList(),
    );
  }
}

