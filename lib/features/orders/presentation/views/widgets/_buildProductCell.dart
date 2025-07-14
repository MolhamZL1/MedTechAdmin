import 'package:flutter/cupertino.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../domain/entities/InfomOrder.dart';
import '../../../domain/entities/PopupType.dart';

class ProductCell extends StatelessWidget {
  final Order order;
  final Function(PopupType, Order) onShowPopup;

  ProductCell({required this.order, required this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onShowPopup(PopupType.product, order),
      child: Text(order.productName,
          style: TextStyle
            (color: Color(0xFF374151),
              decoration: TextDecoration.underline,
              decorationColor: AppColors.success),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),
    );
  }
}