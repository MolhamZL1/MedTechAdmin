import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../domain/rental_data.dart';
import '../../../utils/constants.dart';
import '../status_badge.dart';
import 'customer_info_section.dart';
import 'rental_timeline_section.dart';
import 'equipment_details_section.dart';

class RentalDetailsDialog extends StatelessWidget {
  final RentalData rental;

  const RentalDetailsDialog({
    Key? key,
    required this.rental,
  }) : super(key: key);

  static Future<void> show(BuildContext context, RentalData rental) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Rental Details',
      barrierColor: Colors.black54,

      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return RentalDetailsDialog(rental: rental);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildContent(),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rental Details',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  rental.id,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppConstants.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: AppConstants.secondaryText,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusSection(),
        const SizedBox(height: 24.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomerInfoSection(customer: rental.customer),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: RentalTimelineSection(period: rental.period),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        EquipmentDetailsSection(rental: rental),
        if (rental.notes != null) ...[
          const SizedBox(height: 24.0),
          _buildNotesSection(),
        ],
      ],
    );
  }

  Widget _buildStatusSection() {
    return Row(
      children: [
        StatusBadge(status: rental.status),
        const SizedBox(width: 12.0),
        Text(
          rental.period.statusInfo,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppConstants.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppConstants.borderColor),
          ),
          child: Text(
            rental.notes!,
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppConstants.primaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // OutlinedButton(
          //   onPressed: () {
          //     // Handle print contract
          //   },
          //   child: const Text('Print Contract'),
          // ),
          const SizedBox(width: 12.0),
          ElevatedButton(
            onPressed: () {
              // Handle extend rental
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              'Extend Rental',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

