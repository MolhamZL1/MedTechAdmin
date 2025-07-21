import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../main/presentation/cubits/cubit/sidebar_cubit_cubit.dart';

class DisplaySettings extends StatelessWidget {
  const DisplaySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, bool>(
      builder: (context, isOpen) {
        String selectedOption = isOpen ? 'Always expanded' : 'Always collapsed';

        return Container(
          padding: EdgeInsets.all(32),
          decoration: containerDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Display Settings",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 24),
              Text(
                "Sidebar Behavior",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              RadioListTile<String>(
                title: Text("Always expanded", style: TextStyle(fontSize: 14)),
                value: 'Always expanded',
                groupValue: selectedOption,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onChanged: (_) {
                  context.read<SidebarCubit>().setSidebarState(true);
                },
              ),
              RadioListTile<String>(
                title: Text("Always collapsed", style: TextStyle(fontSize: 14)),
                value: 'Always collapsed',
                groupValue: selectedOption,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onChanged: (_) {
                  context.read<SidebarCubit>().setSidebarState(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
