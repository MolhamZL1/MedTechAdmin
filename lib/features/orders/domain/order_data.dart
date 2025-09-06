
import 'package:flutter/material.dart';

import '../../rentaling/domain/table_column.dart';
import '../../rentaling/domain/table_data.dart';
import '../../rentaling/presentaion/widgets/action_button.dart';
import '../../rentaling/utils/constants.dart';
import 'data.dart';

class SampleDataa {
  static List<OrderData> getOrderData() {
    return [
      OrderData(
        id: 'RNT-2024-001',
        customer: const Customerr(
          name: 'Dr. Michael Brown',
          organization: 'Regional Medical Center',
        ),
        equipment: 'X-Ray Machine Digital',
        period: OrderPeriod(
          startDate: DateTime(2024, 1, 10),
          endDate: DateTime(2024, 2, 10),
        ),
        dailyRate: 500,
        total: 15500,
        status: StatusType.active,
      ),
      OrderData(
        id: 'RNT-2024-002',
        customer: const Customerr(
          name: 'Dr. Emily Davis',
          organization: 'Cardiac Specialty Hospital',
        ),
        equipment: 'Ultrasound Scanner',
        period: OrderPeriod(
          startDate: DateTime(2024, 1, 8),
          endDate: DateTime(2024, 1, 22),
        ),
        dailyRate: 400,
        total: 5600,
        status: StatusType.expiresSoon,
      ),
      OrderData(
        id: 'RNT-2024-003',
        customer: const Customerr(
          name: 'Dr. Robert Wilson',
          organization: 'Emergency Care Center',
        ),
        equipment: 'Ventilator ICU',
        period: OrderPeriod(
          startDate: DateTime(2024, 1, 5),
          endDate: DateTime(2024, 1, 19),
        ),
        dailyRate: 300,
        total: 4200,
        status: StatusType.overdue,
        lateFee: 150,
      ),
      OrderData(
        id: 'RNT-2024-004',
        customer: const Customerr(
          name: 'Dr. Jennifer Lee',
          organization: 'Children\'s Hospital',
        ),
        equipment: 'Patient Monitor',
        period: OrderPeriod(
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 15),
        ),
        dailyRate: 100,
        total: 1400,
        status: StatusType.completed,
      ),
      OrderData(
        id: 'RNT-2024-005',
        customer: const Customerr(
          name: 'Dr. David Garcia',
          organization: 'Orthopedic Clinic',
        ),
        equipment: 'Defibrillator',
        period: OrderPeriod(
          startDate: DateTime(2024, 1, 12),
          endDate: DateTime(2024, 2, 12),
        ),
        dailyRate: 200,
        total: 6200,
        status: StatusType.active,
      ),
    ];
  }

  static TableData getOrderTableData() {
    final rentalData = getOrderData();

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
        key: 'orders',
        title: 'product',
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

    final rows = rentalData.map((order) {
      return {
        'id': order.id,
        'customer': order.customer.toString(),
        'orders': order.equipment,
        'period': '${order.period.formattedPeriod}\n${order.period.statusInfo}',
        'dailyRate': order.formattedDailyRate,
        'total': order.formattedTotal,
        'status': order.status.label,
        'actions': ActionButton(
          text: 'View',
          icon: Icons.visibility_outlined,
          onPressed: () {
            // Handle view action
            print('View rental: ${order.id}');
          }, tooltip: '',
        ),
      };
    }).toList();

    return TableData(
      columns: columns,
      rows: rows,

      showHeader: true,
      showBorder: false,
    );
  }
}

