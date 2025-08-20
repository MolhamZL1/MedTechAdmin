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
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';

import '../../../../core/entities/InfoCardEntity.dart';
import '../../../Financial/presentaion/views/widgets/revenue_breakdown_chart.dart';
import '../../../Financial/presentaion/views/widgets/revenue_expenses_chart.dart';
import '../../../products/presentation/cubits/cubit/add_media_cubit.dart';
import '../../../products/presentation/views/widgets/InfoCardList.dart';
import '../../../users/presentation/cubits/user_cubit.dart';
import 'ActionCard.dart';

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 400,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const RevenueExpensesChart(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child:Container(
                  width: 600,
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                              child: ActionCard(
                                leadingIcon: Icons.add,
                                trailingIcon: Icons.medical_services,
                                title: "Add new Product",
                                subtitle: "Add medical equipment to inventory",
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 10,),
                            ActionCard(
                              leadingIcon: Icons.add,
                              trailingIcon: Icons.medication_outlined,
                              title: "Add new Rental",
                              subtitle: "Add medical rental to inventory",
                              color: AppColors.warning,
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () => showAddUserDialog(context,cubit: BlocProvider.of<UserCubit>(context)),
                              child: ActionCard(
                                leadingIcon: Icons.add,
                                trailingIcon: Icons.supervised_user_circle,
                                title: "Add new User",
                                subtitle: "Add user to company employment",
                                color: AppColors.success,

                              ),
                            ),



                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 24),

      ],
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
