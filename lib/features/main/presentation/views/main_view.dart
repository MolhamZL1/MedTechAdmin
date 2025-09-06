import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/features/main/presentation/cubits/cubit/sidebar_cubit_cubit.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/main_view_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidebarCubit(),
      child: const Scaffold(body: MainViewBody()),
    );
  }
}
