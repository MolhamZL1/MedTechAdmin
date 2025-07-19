import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class StatusBadge extends StatelessWidget {
  final StatusType status;
  final String? customText;
  final double? fontSize;
final Icon ? icons;
  const StatusBadge({
    Key? key,
    required this.status,
    this.customText,
    this.fontSize,
    this.icons
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(9.0),
        border: Border.all(
          color: status.color.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
                     color: status.color,
            size:7,
            (icons??status.icon) as IconData?
          ),
          const SizedBox(width: 5.0),
          Text(
            customText ?? status.label,
            style: TextStyle(
              color: status.color,
              fontSize: (fontSize ?? AppConstants.smallFontSize) * 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadgeBuilder {
  static Widget buildFromString(String statusText) {
    StatusType status;

    switch (statusText.toLowerCase()) {
      case 'active':
        status = StatusType.active;
        break;
      case 'expires soon':
        status = StatusType.expiresSoon;
        break;
      case 'overdue':
        status = StatusType.overdue;
        break;
      case 'completed':
        status = StatusType.completed;
        break;
      default:
        status = StatusType.active;
    }

    return StatusBadge(status: status, customText: statusText);
  }
}
