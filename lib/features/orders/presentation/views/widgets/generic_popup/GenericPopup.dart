// generic_popup.dart
import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import '../../../../domain/entities/InfomOrder.dart';
import '../../../../domain/entities/PopupType.dart';
import 'popup_header.dart';
import 'popup_content.dart';

class GenericPopup extends StatelessWidget {
  final PopupData popupData;
  final VoidCallback onClose;

  const GenericPopup({
    Key? key,
    required this.popupData,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _calculateLeft(context),
      top: _calculateTop(context),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 300),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PopupHeader(popupData: popupData, onClose: onClose),
              SizedBox(height: 16),
              Flexible(child: PopupContent(popupData: popupData)),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onClose,
                  child: Text('Close'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateLeft(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double left = popupData.position.dx;
    const popupWidth = 400.0;

    if (left + popupWidth > screenWidth) left = screenWidth - popupWidth - 20;
    if (left < 20) left = 20;

    return left;
  }

  double _calculateTop(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double top = popupData.position.dy - 150;
    const popupHeight = 300.0;

    if (top + popupHeight > screenHeight) top = screenHeight - popupHeight - 20;
    if (top < 20) top = 20;

    return top;
  }
}
