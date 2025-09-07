import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
// ... (بقية استيراداتك تبقى كما هي)
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/show_err_dialog.dart';
import '../../../../../core/widgets/show_question_dialog.dart';
import '../../../../../core/widgets/showsuccessDialog.dart';
import '../../../../rentaling/domain/table_column.dart';
import '../../../../rentaling/domain/table_data.dart';
import '../../../../rentaling/presentaion/widgets/action_button.dart';
import '../../../../rentaling/presentaion/widgets/status_badge.dart';
import '../../../../rentaling/utils/constants.dart';
import '../../../Data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/user_cubit.dart' hide showerrorDialog;import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';


class UserTableHelper {
  static TableData fromUserList(
      List<GetUserEntity> users, UserCubit cubit, BuildContext context) {
    final columns = [
      // --- 1. عمود المستخدم (User) ---
      TableColumn(
        key: 'user',
        title: 'User',
        type: ColumnType.custom,
        customBuilder: (value) {
          final entity = value as GetUserEntity;
          final user = GetUserModel.fromEntity(entity);
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: _getUserAvatarColor(user.role),
                child: Text(
                  user.username.isNotEmpty ? user.username.substring(0, 1).toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عمودياً لمنع الـ Overflow
                  children: [
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getRoleDisplayName(user.role),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getRoleColor(user.role),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),

      // --- 2. عمود معلومات الاتصال (Contact) ---
      TableColumn(
        key: 'contact',
        title: 'Contact', // تم تقصير العنوان
        type: ColumnType.custom,
        customBuilder: (value) {
          final entity = value as GetUserEntity;
          final user = GetUserModel.fromEntity(entity);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
            children: [
              Row(
                children: [
                  Icon(Icons.email, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Flexible( // استخدام Flexible لتجنب أي تجاوز محتمل
                    child: Text(
                      'Joined on ${_formatDate(user.createdAt)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),

      // --- 3. عمود الدور (Role) ---
      TableColumn(
        key: 'role',
        title: 'Role', // تم تقصير العنوان
        type: ColumnType.custom,
        customBuilder: (value) {
          final entity = value as GetUserEntity;
          final user = GetUserModel.fromEntity(entity);
          final icon = _getRoleIcon(user.role);
          final color = _getRoleColor(user.role);
          return Center( // استخدام Center لضمان التوسيط الأفقي والعمودي
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // لجعل الحاوية تلتف حول المحتوى
                children: [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: 6),
                  Flexible( // استخدام Flexible للسماح للنص بالتقلص
                    child: Text(
                      _getRoleDisplayName(user.role),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // --- 4. عمود الإجراءات (Actions) ---
      TableColumn(
        key: 'actions',
        title: 'Actions',
        type: ColumnType.action,
        customBuilder: (value) {
          final entity = value as GetUserEntity;
          final user = GetUserModel.fromEntity(entity);
          return Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: [
              ActionButton(
                icon: Icons.visibility,
                onPressed: () => cubit.fetchUserOrders(
                  context,
                  user.id.toString(),
                  user.username,
                ),
                text: '',
                tooltip: 'View Orders',
              ),
              ActionButton(
                icon: user.isBanned ? Icons.lock_open : Icons.block,
                color: user.isBanned ? Colors.green : Colors.orange,
                onPressed: () {
                  showQuestionDialog(
                    context: context,
                    title: user.isBanned ? "Unban User" : "Ban User",
                    description: "Are you sure you want to ${user.isBanned ? 'unban' : 'ban'} this user?",
                    btnOkOnPress: () async {
                      if (user.isBanned) {
                        await cubit.unbanUser(user.id.toString());
                      } else {
                        await cubit.banUser(user.id.toString());
                      }
                      // يمكنك إضافة منطق إظهار رسائل النجاح/الخطأ هنا
                    },
                  );
                },
                text: '',
                tooltip: user.isBanned ? 'Unban User' : 'Ban User',
              ),
              ActionButton(
                icon: Icons.delete,
                color: Colors.red,
                onPressed: () {
                  showQuestionDialog(
                    context: context,
                    title: "Delete User",
                    description: "Are you sure you want to delete this user? This action cannot be undone.",
                    btnOkOnPress: () async {
                      await cubit.deleteUser(user.id.toString());
                      // يمكنك إضافة منطق إظهار رسائل النجاح/الخطأ هنا
                    },
                  );
                },
                text: '',
                tooltip: 'Delete User',
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

  // --- الدوال المساعدة ---

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
        return Icons.account_balance;
      case 'MAINTENANCE':
        return Icons.build_circle;
      default:
        return Icons.help_outline;
    }
  }

  static Color _getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return const Color(0xFF8B5CF6); // Purple
      case 'USER':
        return const Color(0xFF3B82F6); // Blue
      case 'ACCOUNTANT':
        return const Color(0xFFF59E0B); // Amber
      case 'MAINTENANCE':
        return const Color(0xFFEF4444); // Red
      default:
        return Colors.grey;
    }
  }

  static Color _getUserAvatarColor(String role) {
    // يمكن توحيدها مع الدالة السابقة ولكن سأبقيها كما هي
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return const Color(0xFF8B5CF6);
      case 'USER':
        return const Color(0xFF3B82F6);
      case 'ACCOUNTANT':
        return const Color(0xFFF59E0B);
      case 'MAINTENANCE':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  static String _getRoleDisplayName(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return 'Admin';
      case 'USER':
        return 'Regular User';
      case 'ACCOUNTANT':
        return 'Accountant';
      case 'MAINTENANCE':
        return 'Technician';
      default:
        return role;
    }
  }
}
