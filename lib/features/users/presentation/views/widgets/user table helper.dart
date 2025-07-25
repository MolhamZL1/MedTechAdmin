import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import 'package:med_tech_admin/main.dart'; // مهم فقط لو بتستخدم navigatorKey في أماكن تانية

import '../../../../../../core/utils/app_colors.dart';
import '../../../../rentaling/domain/table_column.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/action_button.dart';
import '../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../rentaling/utils/constants.dart';
import '../../../Data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/user_cubit.dart';

class UserTableHelper {
  static TableData fromUserList(List<UsersEntity> users, UserCubit cubit) {
    final columns = [
      TableColumn(
        key: 'user',
        title: 'User',
        type: ColumnType.custom,
        width: 300,
        customBuilder: (value) {
          final entity = value as UsersEntity;
          final user = UsersModel.fromEntity(entity);
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: AppConstants.accentText,
                child: Text(user.username.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('ID: ${user.id}', style: const TextStyle(fontSize: 12)),
                ],
              )
            ],
          );
        },
      ),
      TableColumn(
        key: 'contact',
        title: 'Contact',
        type: ColumnType.custom,
        width: 220,
        customBuilder: (value) {
          final entity = value as UsersEntity;
          final user = UsersModel.fromEntity(entity);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              Text(_formatDate(user.createdAt),
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
          final entity = value as UsersEntity;
          final user = UsersModel.fromEntity(entity);
          final icon = _getRoleIcon(user.role);
          final color = _getRoleColor(user.role);
          return Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 4),
              Text(user.role),
            ],
          );
        },
      ),
      TableColumn(
        key: 'status',
        title: 'Status',
        type: ColumnType.custom,
        width: 160,
        customBuilder: (value) {
          final entity = value as UsersEntity;
          final user = UsersModel.fromEntity(entity);
          return StatusBadge(
            status: user.isBanned ? StatusType.active : StatusType.active,
          );
        },
      ),
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        width: 250,
        customBuilder: (value) {
          final entity = value as UsersEntity;
          final user = UsersModel.fromEntity(entity);

          // استخدمنا cubit الممرر بدل navigatorKey.currentContext!
          return ActionButtonGroup(
            buttons: [
              ActionButton(
                icon: Icons.visibility,
                onPressed: () => print('View ${user.username}'),
                text: '',
              ),
              user.isBanned
                  ? ActionButton(
                icon: Icons.lock_open,
                color: Colors.green,
                onPressed: () {
                  cubit.unbanUser(user.id.toString());
                },
                text: '',
              )
                  : ActionButton(
                icon: Icons.block,
                color: Colors.orange,
                onPressed: () {
                  cubit.banUser(user.id.toString());
                },
                text: '',
              ),
              ActionButton(
                icon: Icons.delete,
                color: Colors.red,
                onPressed: () {
                  cubit.deleteUser(user.id.toString());
                },
                text: '',
              ),
            ],
          );
        },
      ),
    ];

    final rows = users
        .map((user) => {
      'user': user,
      'contact': user,
      'role': user,
      'status': user,
      'actions': user,
    })
        .toList();

    return TableData(
      showBorder: true,
      showHeader: true,
      columns: columns,
      rows: rows,
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static IconData _getRoleIcon(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return Icons.admin_panel_settings;
      case 'USER':
        return Icons.person;
      case 'ACCOUNTANT':
        return Icons.request_quote;
      case 'MAINTENANCE':
        return Icons.build;
      default:
        return Icons.help_outline;
    }
  }

  static Color _getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return Colors.deepPurple;
      case 'CUSTOMER':
        return Colors.green;
      case 'ACCOUNTANT':
        return Color(0xFFF59E0B);
      case 'MAINTENANCE':
        return Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }
}
