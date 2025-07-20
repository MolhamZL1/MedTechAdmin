import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/users/Data/user_data.dart';

import '../../../core/utils/app_colors.dart';
import '../../rentaling/domain/table_column.dart';
import '../../rentaling/domain/table_data.dart';
import '../../rentaling/presentaion/widgets/action_button.dart';
import '../../rentaling/presentaion/widgets/status_badge.dart';
import '../../rentaling/utils/constants.dart';


class SampleUserData {
  static List<UserData> getUsers() {
    return [
      UserData(
        id: '1',
        name: 'Dr. Sarah Johnson',
        email: 'sarah.johnson@cityhospital.com',
        phone: '+1 (555) 123-4567',
        role: UserRole.customer,
        hospital: 'City General Hospital',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 15),
          ordersCount: 12,
          totalAmount: 125000,
        ),
        status: StatusType.active,
      ),
      UserData(
        id: '2',
        name: 'Ahmad Khalil',
        email: 'ahmad.khalil@medicare.com',
        phone: '+1 (555) 234-5678',
        role: UserRole.technician,
        hospital: 'MediCare Support',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 15),
        ),
        status: StatusType.active,
      ),
      UserData(
        id: '3',
        name: 'Dr. Ahmed Hassan',
        email: 'ahmed.hassan@medcenter.com',
        phone: '+1 (555) 345-6789',
        role: UserRole.customer,
        hospital: 'Medical Center Plus',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 14),
          ordersCount: 8,
          totalAmount: 89000,
        ),
        status: StatusType.active,
      ),
      UserData(
        id: '4',
        name: 'Fatima Al-Zahra',
        email: 'fatima.alzahra@medicare.com',
        phone: '+1 (555) 456-7890',
        role: UserRole.accountant,
        hospital: 'MediCare Finance',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 15),
        ),
        status: StatusType.active,
      ),
      UserData(
        id: '5',
        name: 'Dr. Maria Rodriguez',
        email: 'maria.rodriguez@emergency.com',
        phone: '+1 (555) 567-8901',
        role: UserRole.customer,
        hospital: 'Emergency Care Unit',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 10),
          ordersCount: 5,
          totalAmount: 45000,
        ),
        status: StatusType.suspended,
      ),
      UserData(
        id: '6',
        name: 'Omar Mansour',
        email: 'omar.mansour@medicare.com',
        phone: '+1 (555) 678-9012',
        role: UserRole.manager,
        hospital: 'MediCare Operations',
        activity: UserActivity(
          lastActivityDate: DateTime(2024, 1, 15),
        ),
        status: StatusType.active,
      ),
    ];
  }

  static TableData getUserTableData() {
    final users = getUsers();

    final columns = [
      TableColumn(
        key: 'user',
        title: 'User',
        type: ColumnType.custom,
        width: 300,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return SingleChildScrollView(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppConstants.accentText,
                  child: Text(
                    user.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryText,
                      ),
                    ),
                    Text(
                      'ID: ${user.id}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: AppConstants.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      TableColumn(
        key: 'contact',
        title: 'Contact',
        type: ColumnType.custom,
        width: 200,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.email,
                style: const TextStyle(
                  color: AppConstants.primaryText,
                ),
              ),
              Text(
                user.phone,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: AppConstants.secondaryText,
                ),
              ),
            ],
          );
        },
      ),
      TableColumn(
        key: 'role',
        title: 'Role',
        type: ColumnType.custom,
        width: 180,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                user.role.icon,
                color: user.role.color,
                size: 18,
              ),
              const SizedBox(width: 1),
              Text(
                user.role.label,
                style: const TextStyle(
                  color: AppConstants.primaryText,
                ),
              ),
            ],
          );
        },
      ),
      const TableColumn(
        key: 'hospital',
        title: 'Hospital',
        type: ColumnType.text,
        width: 180,
      ),
      TableColumn(
        key: 'activity',
        title: 'Activity',
        type: ColumnType.custom,
        width: 180,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.activity.formattedLastActivityDate,
                  style: const TextStyle(
                    color: AppConstants.primaryText,
                  ),
                ),
                if (user.activity.ordersCount != null || user.activity.totalAmount != null)
                  Text(
                    user.activity.formattedOrdersAndAmount,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: AppConstants.secondaryText,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.status,
        alignment: TextAlign.center,
        width: 170,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return StatusBadge(status: user.status);
        },
      ),
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        alignment: TextAlign.center,
        width: 280,
        customBuilder: (value) {
          final UserData user = value as UserData;
          return ActionButtonGroup(
            buttons: [
              ActionButton(
                text: '',
                icon: Icons.visibility_outlined,
                isOutlined: false,
                onPressed: () {
                  print('View user: ${user.name}');
                  // هنا يمكنك عرض تفاصيل المستخدم في ديالوج مشابه لـ RentalDetailsDialog
                },
              ),
              ActionButton(
                text: '',
                icon: Icons.edit,
                color: AppColors.warning,
                isOutlined: false,

                onPressed: () {
                  print('Edit user: ${user.name}');
                },
              ),
              ActionButton(
                text: '',
                icon: Icons.delete,
                color: AppColors.error,
                isOutlined: false,
                onPressed: () {
                  print('Delete user: ${user.name}');
                },
              ),
            ],
          );
        },
      ),
    ];

    final rows = users.map((user) {
      return {
        'user': user,
        'contact': user,
        'role': user,
        'hospital': user.hospital,
        'activity': user,
        'status': user,
        'actions': user,
      };
    }).toList();

    return TableData(
      columns: columns,
      rows: rows,
      title: 'User Management',
      showHeader: true,
      showBorder: true,
    );
  }
}

