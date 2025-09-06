import '../domain/rental_data.dart';
import '../domain/table_column.dart';
import '../domain/table_data.dart';

import '../presentaion/widgets/action_button.dart';
import '../presentaion/widgets/dialogs/rental_details_dialog.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class SampleData {
  static List<RentalData> getRentalData() {
    return [
      RentalData(
        id: 'RNT-2024-001',
        customer: const Customer(
          name: 'Dr. Michael Brown',
          organization: 'Regional Medical Center',
          email: 'michael.brown@regional.com',
          phone: '+1 (555) 111-2222',
          address: '100 Regional Way, Boston, MA 02101',
        ),
        equipment: 'X-Ray Machine Digital',
        period: RentalPeriod(
          startDate: DateTime(2024, 1, 10),
          endDate: DateTime(2024, 2, 10),
        ),
        dailyRate: 500,
        total: 15500,
        status: StatusType.active,
        deposit: 5000,
        notes: 'Equipment for temporary ICU expansion',
      ),
      RentalData(
        id: 'RNT-2024-002',
        customer: const Customer(
          name: 'Dr. Emily Davis',
          organization: 'Cardiac Specialty Hospital',
          email: 'emily.davis@cardiac.com',
          phone: '+1 (555) 222-3333',
          address: '200 Heart Street, Boston, MA 02102',
        ),
        equipment: 'Ultrasound Scanner',
        period: RentalPeriod(
          startDate: DateTime(2024, 1, 8),
          endDate: DateTime(2024, 1, 22),
        ),
        dailyRate: 400,
        total: 5600,
        status: StatusType.expiresSoon,
        deposit: 2000,
        notes: 'Cardiac imaging for emergency procedures',
      ),
      RentalData(
        id: 'RNT-2024-003',
        customer: const Customer(
          name: 'Dr. Robert Wilson',
          organization: 'Emergency Care Center',
          email: 'robert.wilson@emergency.com',
          phone: '+1 (555) 333-4444',
          address: '300 Emergency Ave, Boston, MA 02103',
        ),
        equipment: 'Ventilator ICU',
        period: RentalPeriod(
          startDate: DateTime(2024, 1, 5),
          endDate: DateTime(2024, 1, 19),
        ),
        dailyRate: 300,
        total: 4200,
        status: StatusType.overdue,
        lateFee: 150,
        deposit: 1500,
        notes: 'Critical care ventilator for ICU patients',
      ),
      RentalData(
        id: 'RNT-2024-004',
        customer: const Customer(
          name: 'Dr. Jennifer Lee',
          organization: 'Children\'s Hospital',
          email: 'jennifer.lee@childrens.com',
          phone: '+1 (555) 444-5555',
          address: '400 Kids Lane, Boston, MA 02104',
        ),
        equipment: 'Patient Monitor',
        period: RentalPeriod(
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 15),
        ),
        dailyRate: 100,
        total: 1400,
        status: StatusType.completed,
        deposit: 500,
        notes: 'Pediatric monitoring equipment',
      ),
      RentalData(
        id: 'RNT-2024-005',
        customer: const Customer(
          name: 'Dr. David Garcia',
          organization: 'Orthopedic Clinic',
          email: 'david.garcia@ortho.com',
          phone: '+1 (555) 555-6666',
          address: '500 Bone Street, Boston, MA 02105',
        ),
        equipment: 'Defibrillator',
        period: RentalPeriod(
          startDate: DateTime(2024, 1, 12),
          endDate: DateTime(2024, 2, 12),
        ),
        dailyRate: 200,
        total: 6200,
        status: StatusType.active,
        deposit: 3000,
        notes: 'Emergency defibrillator for surgical procedures',
      ),
    ];
  }

  static TableData getRentalTableData(BuildContext context) {
    final rentalData = getRentalData();

    final columns = [
      const TableColumn(
        key: 'id',
        title: 'Rental ID',
        type: ColumnType.text,
        width: 120,
      ),
      const TableColumn(
        key: 'customer',
        title: 'Customer',
        type: ColumnType.text,
        width: 200,
      ),
      const TableColumn(
        key: 'equipment',
        title: 'Equipment',
        type: ColumnType.text,
        width: 150,
      ),
      const TableColumn(
        key: 'period',
        title: 'Period',
        type: ColumnType.date,
        width: 140,
      ),
      const TableColumn(
        key: 'dailyRate',
        title: 'Daily Rate',
        type: ColumnType.currency,
        alignment: TextAlign.center,
        width: 100,
      ),
      const TableColumn(
        key: 'total',
        title: 'Total',
        type: ColumnType.currency,
        alignment: TextAlign.center,
        width: 120,
      ),
      const TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.status,
        alignment: TextAlign.center,
        width: 120,
      ),
      const TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        alignment: TextAlign.center,
        width: 100,
      ),
    ];

    final rows = rentalData.map((rental) {
      return {
        'id': rental.id,
        'customer': rental.customer.toString(),
        'equipment': rental.equipment,
        'period': '${rental.period.formattedPeriod}\n${rental.period.statusInfo}',
        'dailyRate': rental.formattedDailyRate,
        'total': rental.formattedTotal,
        'status': rental.status.label,
        'actions': ActionButton(
          text: 'View',
          icon: Icons.visibility_outlined,
          onPressed: () {
            RentalDetailsDialog.show(context, rental);
          }, tooltip: '',
        ),
      };
    }).toList();

    return TableData(
      columns: columns,
      rows: rows,
      title: 'Medical Equipment Rentals',
      showHeader: true,
      showBorder: true,
    );
  }
}

