import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/users/domain/entities/user-entity.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';

import '../../../../../core/entities/InfoCardEntity.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../../rentaling/presentaion/widgets/dynamic_table.dart';
import 'HeaderMaintenanceView.dart';


class MaintenanceViewBody extends StatelessWidget {
  const MaintenanceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderMaintenanceView(),
            const SizedBox(height: 24),
            InformCardList(entities: Maintenancelistinfo),
            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
