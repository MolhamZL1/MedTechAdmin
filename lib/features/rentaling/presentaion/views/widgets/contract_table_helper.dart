import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/contract-entity.dart';
import '../../../domain/table_column.dart';
import '../../../domain/table_data.dart';
import '../../../utils/constants.dart';
import '../../cubits/contract_cubit.dart';
import '../../widgets/action_button.dart';
import '../../widgets/google_drive_pdf_viewer.dart';
import '../../widgets/status_badge.dart';

class ContractTableHelper {
  static TableData fromContractList(List<ContractEntity> contracts, BuildContext context) {
    final columns = [
      TableColumn(
        key: 'contract',
        title: 'Contract Details',
        type: ColumnType.custom,
        flex: 3, // تم التعديل: استخدام flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          // الواجهة الأصلية كما هي
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // إضافة لتوسيط المحتوى عمودياً
            children: [
              Row(
                children: [
                  const Icon(Icons.description, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      contract.contractNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.blue),
                      overflow: TextOverflow.ellipsis, // إضافة لمنع التجاوز
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Order Item: ${contract.orderItemId}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                overflow: TextOverflow.ellipsis, // إضافة لمنع التجاوز
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'customer',
        title: 'Customer',
        type: ColumnType.custom,
        flex: 3, // تم التعديل: width -> flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          // الواجهة الأصلية كما هي
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 16,
                child: Text(
                  contract.user.username.isNotEmpty ? contract.user.username.substring(0, 1).toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // إضافة لتوسيط المحتوى عمودياً
                  children: [
                    Text(
                      contract.user.username,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      contract.user.email,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'product',
        title: 'Product',
        type: ColumnType.custom,
        flex: 2, // تم التعديل: width -> flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          // الواجهة الأصلية كما هي
          return Center( // إضافة Center لضمان التوسيط
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inventory, color: Colors.orange, size: 16),
                  const SizedBox(width: 6),
                  Flexible( // استخدام Flexible بدلاً من Expanded
                    child: Text(
                      contract.product.nameEn,
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      TableColumn(
        key: 'dates',
        title: 'Rental Period',
        type: ColumnType.custom,
        flex: 2, // تم التعديل: width -> flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          // الواجهة الأصلية كما هي
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // إضافة لتوسيط المحتوى عمودياً
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Flexible(child: Text('Start: ${_formatDate(contract.startDate)}', style: TextStyle(fontSize: 12, color: Colors.grey[700]), overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.event, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Flexible(child: Text('End: ${_formatDate(contract.endDate)}', style: TextStyle(fontSize: 12, color: Colors.grey[700]), overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Duration: ${contract.endDate.difference(contract.startDate).inDays} days',
                style: TextStyle(fontSize: 11, color: Colors.blue[600], fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.custom,
        flex: 1, // تم التعديل: width -> flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          // الواجهة الأصلية كما هي
          return Center(child: StatusBadge(status: _getStatusType(contract.status)));
        },
      ),
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        flex: 2, // تم التعديل: width -> flex
        customBuilder: (value) {
          final contract = value as ContractEntity;
          final status = contract.status.toUpperCase();
          // استخدام Wrap لجعل الأزرار تتكيف مع حجم الشاشة
          return Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: [
              ActionButton(
                icon: Icons.picture_as_pdf,
                color: Colors.red,
                onPressed: () => _openPdfViewer(context, contract),
                text: '',
                tooltip: 'View Contract PDF',
              ),
              ActionButton(
                icon: Icons.info,
                color: Colors.blue,
                onPressed: () => _showContractDetails(context, contract),
                text: '',
                tooltip: 'Contract Details',
              ),
              ActionButton(
                icon: Icons.edit_note,
                color: Colors.purple,
                onPressed: () => _showUpdateStatusDialog(context, contract),
                text: '',
                tooltip: 'Update Status',
              ),
              if (status == 'ACTIVE' || status == 'OVERDUE')
                ActionButton(
                  icon: Icons.keyboard_return,
                  color: Colors.orange,
                  onPressed: () => _showReturnItemDialog(context, contract),
                  text: '',
                  tooltip: 'Return Rented Item',
                ),
            ],
          );
        },
      ),
    ];

    final rows = contracts
        .map((contract) => {
      'contract': contract,
      'customer': contract,
      'product': contract,
      'dates': contract,
      'status': contract,
      'actions': contract,
    })
        .toList();

    return TableData(
      showBorder: true,
      showHeader: true,
      columns: columns,
      rows: rows,
    );
  }

  // --- باقي الدوال المساعدة تبقى كما هي بدون أي تغيير ---

  static void _showUpdateStatusDialog(BuildContext context, ContractEntity contract) {
    final cubit = context.read<ContractCubit>();
    String? selectedStatus = contract.status;
    final availableStatuses = ['ACTIVE', 'COMPLETED', 'CANCELLED', 'OVERDUE', 'UPCOMING'];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Status for #${contract.contractNumber}'),
              content: DropdownButtonFormField<String>(
                value: selectedStatus,
                items: availableStatuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'New Status',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedStatus != null) {
                      cubit.updateStatus(
                        orderItemId: contract.id,
                        newStatus: selectedStatus!,
                      );
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static StatusType _getStatusType(String status) {
    switch (status.toUpperCase()) {
      case 'UPCOMING': return StatusType.uncoming;
      case 'COMPLETED': return StatusType.completed;
      case 'CANCELLED': return StatusType.cancelled;
      case 'OVERDUE': return StatusType.overdue;
      case "ACTIVE": return StatusType.active;
      default: return StatusType.pending;
    }
  }

  static void _openPdfViewer(BuildContext context, ContractEntity contract) {
    showGoogleDrivePdfViewer(context, contract);
  }

  static void _downloadPdf(ContractEntity contract) async {
    final url = 'http://localhost:8383${contract.contractDocumentUrl}';
    _launchUrl(url  );
  }

  static void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static void _showContractDetails(BuildContext context, ContractEntity contract) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contract Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Contract Number:', contract.contractNumber),
                _buildDetailRow('Customer:', contract.user.username),
                _buildDetailRow('Email:', contract.user.email),
                _buildDetailRow('Product:', contract.product.nameEn),
                _buildDetailRow('Status:', contract.status),
                _buildDetailRow('Start Date:', _formatDate(contract.startDate)),
                _buildDetailRow('End Date:', _formatDate(contract.endDate)),
                _buildDetailRow('Agreed At:', _formatDate(contract.agreedToTermsAt)),
                if (contract.notes != null) _buildDetailRow('Notes:', contract.notes!),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
  static void _showReturnItemDialog(BuildContext context, ContractEntity contract) {
    final cubit = context.read<ContractCubit>();
    String? selectedCondition;
    final notesController = TextEditingController();
    final conditions = ["NEW", "GOOD", "FAIR", "DAMAGED"];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Return Item for Order #${contract.orderItemId}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedCondition,
                      hint: const Text('Select Condition on Return'),
                      items: conditions.map((condition) {
                        return DropdownMenuItem(
                          value: condition,
                          child: Text(condition),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCondition = value;
                        });
                      },
                      validator: (value) => value == null ? 'Please select a condition' : null,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (Optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCondition != null) {
                      cubit.returnRentedItem(
                        orderItemId: contract.id,
                        condition: selectedCondition!,
                        notes: notesController.text.trim(),
                      );
                      Navigator.of(dialogContext).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a condition.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Confirm Return'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
