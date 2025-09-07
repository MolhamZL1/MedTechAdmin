// MaintenanceRequestTableHelper.dart - الكود الكامل والنهائي

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/presentation/cubits/user_cubit.dart';
import '../../../../rentaling/domain/table_column.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/action_button.dart';
import '../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../rentaling/utils/constants.dart';
import '../../../../users/domain/entities/user-entity.dart';
import '../../../domain/entities/maintenance_request_entity.dart';
import '../../cubits/maintenance_request_cubit.dart';

class MaintenanceRequestTableHelper {
  static TableData fromMaintenanceRequestList(
      List<MaintenanceRequestEntity> requests, BuildContext context) {
    final columns = [
      // --- 1. عمود تفاصيل الطلب (Request) ---


      // --- 2. عمود العميل (Customer) ---
      TableColumn(
        key: 'customer',
        title: 'Customer',
        type: ColumnType.custom,
        flex: 2, // استخدام flex
        customBuilder: (value) {
          final request = value as MaintenanceRequestEntity;
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 16,
                child: Text(
                  request.customer.username.isNotEmpty ? request.customer.username.substring(0, 1).toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
                  children: [
                    Text(
                      request.customer.username,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      request.customer.email,
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

      // --- 3. عمود الفني (Technician) ---
      TableColumn(
        key: 'technician',
        title: 'Technician',
        type: ColumnType.custom,
        flex: 2, // استخدام flex
        customBuilder: (value) {
          final request = value as MaintenanceRequestEntity;
          if (request.technician != null) {
            return Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 16,
                  child: Icon(Icons.engineering, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    request.technician!.username,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Not Assigned',
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }
        },
      ),

      // --- 4. عمود المنتج (Product) ---
      TableColumn(
        key: 'product',
        title: 'Product',
        type: ColumnType.custom,
        flex: 2, // استخدام flex
        customBuilder: (value) {
          final request = value as MaintenanceRequestEntity;
          return Center(
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
                  const Icon(Icons.build, color: Colors.orange, size: 16),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      request.product.nameEn,
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

      // --- 5. عمود الحالة (Status) ---
      TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.custom,
        flex: 1, // استخدام flex
        customBuilder: (value) {
          final request = value as MaintenanceRequestEntity;
          return Center(child: StatusBadge(status: _getStatusType(request.status)));
        },
      ),

      // --- 6. عمود الإجراءات (Actions) ---
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        flex: 2, // استخدام flex
        customBuilder: (value) {
          final request = value as MaintenanceRequestEntity;
          return Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: [
              ActionButton(
                icon: Icons.visibility,
                color: Colors.blue,
                onPressed: () => _showRequestDetails(context, request),
                tooltip: 'View Details',
                text: '',
              ),
              if (request.status.toUpperCase() == 'PENDING')
                ActionButton(
                  icon: Icons.person_add_alt_1,
                  color: Colors.green,
                  onPressed: () => _showAssignTechnicianDialog(context, request),
                  tooltip: 'Assign Technician',
                  text: '',
                ),
              if (request.status.toUpperCase() == 'APPROVED')
                ActionButton(
                  icon: Icons.check_circle,
                  color: Colors.teal,
                  onPressed: () => _showCompleteRequestDialog(context, request),
                  tooltip: 'Complete Request',
                  text: '',
                ),
            ],
          );
        },
      ),
    ];

    final rows = requests
        .map((request) => {
      'requestDetails': request,
      'customer': request,
      'technician': request,
      'product': request,
      'status': request,
      'actions': request,
    })
        .toList();

    return TableData(
      columns: columns,
      rows: rows,
    );
  }

  // --- الدوال المساعدة (كاملة وبدون نقص) ---

  static void _showAssignTechnicianDialog(
      BuildContext context, MaintenanceRequestEntity request) {
    final userCubit = context.read<UserCubit>()..fetchUsers();
    final maintenanceCubit = context.read<MaintenanceRequestCubit>();

    final formKey = GlobalKey<FormState>();
    GetUserEntity? selectedTechnician;
    DateTime? selectedDate;
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Assign Request #${request.id}'),
              content: BlocProvider.value(
                value: userCubit,
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userState is UserSuccess) {
                      final technicians = userState.usersEntity
                          .where((user) => user.role.trim() == 'MAINTENANCE')
                          .toList();

                      if (technicians.isEmpty) {
                        return const Center(
                          child: Text(
                            'No users with the role "technician" were found.',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButtonFormField<GetUserEntity>(
                                value: selectedTechnician,
                                hint: const Text('Select Technician'),
                                items: technicians.map((tech) {
                                  return DropdownMenuItem(
                                    value: tech,
                                    child: Text(tech.username),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() => selectedTechnician = value);
                                },
                                validator: (value) => value == null ? 'Please select a technician' : null,
                                decoration: const InputDecoration(labelText: 'Technician', border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: selectedDate == null ? '' : "${selectedDate!.toLocal()}".split('.')[0],
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Service Date & Time',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                                      if (date == null) return;
                                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()));
                                      if (time == null) return;
                                      setState(() {
                                        selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) => selectedDate == null ? 'Please select a date and time' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: costController,
                                decoration: const InputDecoration(labelText: 'Estimated Cost', border: OutlineInputBorder(), prefixText: '\$'),
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please enter a cost';
                                  if (double.tryParse(value) == null) return 'Please enter a valid number';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const Text('Could not load technicians.');
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      maintenanceCubit.assignTechnician(
                        requestId: request.id,
                        technicianId: selectedTechnician!.id,
                        serviceDate: selectedDate!,
                        estimatedCost: double.parse(costController.text),
                      );
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: const Text('Confirm & Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return "${date.day}/${date.month}/${date.year}";
  }

  static StatusType _getStatusType(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return StatusType.completed;
      case 'IN_PROGRESS':
        return StatusType.active;
      case 'APPROVED':
        return StatusType.approved;
      case 'PENDING':
      default:
        return StatusType.pending;
    }
  }

  static void _showRequestDetails(BuildContext context, MaintenanceRequestEntity request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Request Number:', request.requestNumber),
                _buildDetailRow('Customer:', request.customer.username),
                _buildDetailRow('Product:', request.product.nameEn),
                _buildDetailRow('Status:', request.status),
                _buildDetailRow('Issue:', request.issueDescription),
                _buildDetailRow('Preferred Date:', _formatDate(request.preferredServiceDate)),
                if (request.technician != null)
                  _buildDetailRow('Technician:', request.technician!.username),
                _buildDetailRow('Technician Notes:', request.technicianNotes ?? 'No notes'),
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

  static void _showCompleteRequestDialog(
      BuildContext context, MaintenanceRequestEntity request) {
    final formKey = GlobalKey<FormState>();
    final costController = TextEditingController();
    final notesController = TextEditingController();
    final maintenanceCubit = context.read<MaintenanceRequestCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Complete Request #${request.id}'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: costController,
                    decoration: const InputDecoration(
                      labelText: 'Final Cost',
                      border: OutlineInputBorder(),
                      prefixText: '\$',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter the final cost';
                      if (double.tryParse(value) == null) return 'Please enter a valid number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Technician Notes',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Please enter technician notes';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  maintenanceCubit.completeRequest(
                    requestId: request.id,
                    finalCost: double.parse(costController.text),
                    technicianNotes: notesController.text.trim(),
                  );
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Confirm & Complete'),
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
}
