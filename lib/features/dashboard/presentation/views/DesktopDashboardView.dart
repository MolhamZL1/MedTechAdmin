import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/views/widgets/add_product_dialog/add_product_dialog.dart';

import '../../../../core/entities/InfoCardEntity.dart';
import '../../../products/presentation/cubits/cubit/add_media_cubit.dart';
import '../../../products/presentation/views/widgets/InfoCardList.dart';

class DesktopDashboardView extends StatelessWidget {
  const DesktopDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderDashboardView(),
        SizedBox(height: 24),
        InfoCardList(entities: dashboardinfolist),
        SizedBox(height: 24),
        Container(
          decoration: containerDecoration(context),
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create:
                                      (context) => AddProductCubit(
                                        getIt.get<ProductsRepo>(),
                                      ),
                                ),

                                BlocProvider(
                                  create: (context) => AddMediaCubit(),
                                ),
                              ],
                              child: ProductAddDialog(),
                            ),
                      );
                    },
                    child: ActionCard(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatefulWidget {
  const ActionCard({super.key});

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          color: _isHovered ? AppColors.primary : Colors.grey.shade400,
          dashPattern: const [5, 4],
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedScale(
                    scale: _isHovered ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    FontAwesomeIcons.cube,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Add new Product",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                "Add medical equipment to inventory",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<InfoCardEntity> dashboardinfolist = [
  InfoCardEntity(
    text: "Total Revenue",
    count: "\$245,670",

    icon: const Icon(
      FontAwesomeIcons.dollarSign,
      color: Colors.green,
      size: 30,
    ),
  ),
  InfoCardEntity(
    text: "Active Rentals",
    count: "156",

    icon: const Icon(Icons.calendar_today_outlined, color: Colors.blueAccent),
  ),
  InfoCardEntity(
    text: "Pending Orders",
    count: "43",
    icon: const Icon(
      Icons.shopping_cart_outlined,
      color: Colors.deepOrangeAccent,
    ),
  ),
  InfoCardEntity(
    text: "Maintenance Requests",
    count: "12",
    icon: const Icon(Icons.build_outlined, color: Colors.deepPurple),
  ),
];

class HeaderDashboardView extends StatefulWidget {
  const HeaderDashboardView({super.key});

  @override
  State<HeaderDashboardView> createState() => _HeaderDashboardViewState();
}

class _HeaderDashboardViewState extends State<HeaderDashboardView> {
  List<String> categories = [
    "Last 7 days",
    "Last 30 days",
    "Last 6 months",
    "Last 1 year",
    "All time",
  ];
  String selected = "Last 6 months";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Welcome back! Here's what's happening with your medical equipment business.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: CategoryDropdown(
        categories: categories,
        onChanged: (value) {
          setState(() => selected = value!);
        },
        selected: selected,
      ),
    );
  }
}
