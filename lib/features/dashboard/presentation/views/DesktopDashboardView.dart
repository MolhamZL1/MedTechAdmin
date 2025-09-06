import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/core/utils/const_variable.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/views/widgets/add_product_dialog/add_product_dialog.dart';
import 'package:med_tech_admin/features/users/presentation/cubits/user_cubit.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';
import '../../../../core/entities/InfoCardEntity.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../Financial/presentaion/cubits/cubit.dart';
import '../../../Financial/presentaion/cubits/state.dart';
import '../../../Financial/presentaion/views/widgets/revenue_expenses_chart.dart';
import '../../../orders/presentation/views/widgets/InformCardList.dart';
import '../../../products/domain/repos/products_repo.dart';
import '../../../products/presentation/cubits/cubit/add_media_cubit.dart';
import '../../../products/presentation/views/widgets/InfoCardList.dart';
import '../cubits/cubit.dart';
import '../cubits/state.dart';
import 'ActionCard.dart';
import 'offer.dart';

class DesktopDashboardView extends StatefulWidget {
  const DesktopDashboardView({super.key});

  @override
  State<DesktopDashboardView> createState() => _DesktopDashboardViewState();
}

class _DesktopDashboardViewState extends State<DesktopDashboardView> {
  @override
  void initState() {
    super.initState();
    context.read<EarningsReportCubit>().fetchEarningsReport();
    context.read<AdvertisementCubit>().fetchAdvertisements();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EarningsReportCubit, EarningsReportState>(
        builder: (context, state) {
          if (state is EarningsReportLoading || state is EarningsReportInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading Financial reports...'),
                ],
              ),
            );
          }

          if (state is EarningsReportSuccess) {
            final report = state.report;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderDashboardView(),
                    const SizedBox(height: 24),
                    InformCardList(entities: dashboardinfolist),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 350,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.cardColorDark
                                  : AppColors.cardColorlight,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: FinancialReportChart(report: report),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: 350,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.cardColorDark
                                  : AppColors.cardColorlight,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 24),
                                    child: Text(
                                      'Company Offers',
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 1),

                                  BlocBuilder<AdvertisementCubit, AdvertisementState>(
                                    builder: (context, adState) {
                                      if (adState is AdvertisementLoading) {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      if (adState is AdvertisementSuccess) {
                                        if (adState.advertisements.isEmpty) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Text('No offers available.'),
                                            ),
                                          );
                                        }
                                        return Column(
                                          children: adState.advertisements.map((ad) {
                                            print(ad.imageUrl);
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                                              child: OfferCard(
                                                title: ad.title,
                                                description: ad.bio,
                                                imagePath: ad.imageUrl,
                                                price: '', // غير متوفر في الـ API
                                                growth: '', // غير متوفر في الـ API
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }
                                      if (adState is AdvertisementFailure) {
                                        return Center(child: Text(adState.errMessage));
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardColorDark
                            : AppColors.cardColorlight,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quick Actions",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(create: (context) => AddProductCubit(getIt.get<ProductsRepo>())),
                                          BlocProvider(create: (context) => AddMediaCubit()),
                                        ],
                                        child: const ProductAddDialog(),
                                      ),
                                    );
                                  },
                                  child: const ActionCard(
                                    leadingIcon: Icons.add,
                                    trailingIcon: Icons.medical_services,
                                    title: "Add new Product",
                                    subtitle: "Add medical equipment to inventory",
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const ActionCard(
                                  leadingIcon: Icons.add,
                                  trailingIcon: Icons.medication_outlined,
                                  title: "Add new Rental",
                                  subtitle: "Add medical rental to inventory",
                                  color: AppColors.warning,
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => showAddUserDialog(context, cubit: BlocProvider.of<UserCubit>(context)),
                                  child: const ActionCard(
                                    leadingIcon: Icons.add,
                                    trailingIcon: Icons.supervised_user_circle,
                                    title: "Add new User",
                                    subtitle: "Add user to company employment",
                                    color: AppColors.success,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => showAddOfferDialog(
                                    context,
                                    adCubit: context.read<AdvertisementCubit>(),
                                  ),
                                  child: const ActionCard(
                                    leadingIcon: Icons.add,
                                    trailingIcon: Icons.local_offer_sharp,
                                    title: "Add New Offer",
                                    subtitle: "Add a New Offer for Your Products",
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('An unexpected error occurred.'));
        });
  }
}


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
      trailing: DropdownButton<String>(
        value: selected,
        items: categories.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selected = newValue!;
          });
        },
      ),
    );
  }
}

List<InfoCardEntity> dashboardinfolist = [
  InfoCardEntity(
    text: "Total Revenue",
    count: "\$245,670",
    icon: const Icon(FontAwesomeIcons.dollarSign, color: Colors.green, size: 30),
  ),
  InfoCardEntity(
    text: "Active Rentals",
    count: "156",
    icon: const Icon(Icons.calendar_today_outlined, color: Colors.blueAccent),
  ),
  InfoCardEntity(
    text: "Pending Orders",
    count: pendingCount.toString(),
    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.deepOrangeAccent),
  ),
  InfoCardEntity(
    text: "Maintenance",
    count: totalCount.toString(),
    icon: const Icon(Icons.build_outlined, color: Colors.deepPurple),
  ),
];

Future<void> showAddOfferDialog(BuildContext context, {required AdvertisementCubit adCubit}) async {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? webImage;
  String? imageName;
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Add New Offer", style: Theme.of(context).textTheme.bodyLarge),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          final bytes = await pickedFile.readAsBytes();
                          setState(() {
                            webImage = bytes;
                            imageName = pickedFile.name;
                          });
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.cardColorDark
                              : AppColors.cardColorlight,
                        ),
                        child: webImage == null
                            ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: Colors.blue),
                              SizedBox(height: 8),
                              Text("Upload Image"),
                            ],
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            webImage!,
                            fit: BoxFit.cover,
                            width: 300,
                            height: 500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Offer Title", border: OutlineInputBorder()),
                      validator: (value) => (value == null || value.trim().isEmpty) ? "Please enter a title" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: bioController,
                      decoration: const InputDecoration(labelText: "Offer Bio/Description", border: OutlineInputBorder()),
                      maxLines: 3,
                      validator: (value) => (value == null || value.trim().isEmpty) ? "Please enter a description" : null,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (webImage == null) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(const SnackBar(content: Text("Please upload an image"), backgroundColor: Colors.red));
                      return;
                    }
                    adCubit.createAd(
                      title: titleController.text.trim(),
                      bio: bioController.text.trim(),
                      imageBytes: webImage!,
                      imageName: imageName!,
                    );
                    Navigator.of(dialogContext).pop();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Add"),
              ),
            ],
          );
        },
      );
    },
  );
}
